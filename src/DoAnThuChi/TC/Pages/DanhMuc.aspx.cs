using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TC.Services;
using TC.Services.Models;

namespace TC.Pages
{
    public partial class DanhMuc : System.Web.UI.Page
    {
        private IUnitOfWork _uow;
        private IRepository<Categories> _catRepo;
        public DanhMuc()
        {
            _uow = ServiceLocator.GetService<IUnitOfWork>();
            _catRepo = _uow.Repository<Categories>();
        }
        // Lấy UserID từ Session
        private int UserID
        {
            get
            {
                // Kiểm tra Session và trả về UserID, nếu không có thì chuyển hướng
                if (Session["User"] != null)
                {
                    var user = Session["User"] as Users;
                    return user.UserId;
                }
                // Chuyển hướng về trang đăng nhập nếu Session không tồn tại
                Response.Redirect("/Pages/DangNhap.aspx");
                return -1;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }
        private void BindGridView()
        {
            try
            {
                var  categories = _catRepo.Filter().Where(_ => _.UserId == UserID).ToList();
                gvCategories.DataSource = categories;
                gvCategories.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
            }
        }

        private void ClearFields()
        {
            txtCategoryName.Text = string.Empty;
            txtCategoryId.Text = string.Empty;
            ddlType.SelectedIndex = 0;
        }

        protected void gvCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            e.Cancel = true;
            int categoryId = (int)gvCategories.DataKeys[e.NewEditIndex].Value;
            var editModel = _catRepo.Filter().FirstOrDefault(_ => _.CategoryId == categoryId && _.UserId == UserID);
            txtCategoryName.Text = editModel.CategoryName;
            txtCategoryId.Text = editModel.CategoryId.ToString();
            ddlType.SelectedValue = editModel.Type;
        }

        protected void gvCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int categoryId = (int)gvCategories.DataKeys[e.RowIndex].Value;
            var category = _catRepo.Filter().FirstOrDefault(_ => _.CategoryId == categoryId && _.UserId == UserID);
            if (category != null)
            {
                _catRepo.Remove(category);
                _uow.Commit();
                lblMessage.Text = "Xóa danh mục thành công.";
                BindGridView();
            }
            else
            {
                lblMessage.Text = "Danh mục không tồn tại.";
            }
        }
        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            string categoryName = (string)txtCategoryName.Text.Trim();
            string type = (string)ddlType.SelectedValue;
            if (string.IsNullOrEmpty(categoryName))
            {
                lblMessage.Text = "Tên danh mục không được để trống.";
                return;
            }

            if (int.TryParse(txtCategoryId.Text, out int categoryId) == false)
            {
                //tạo mới

                var checkCat = _catRepo.Filter().Any(c => c.CategoryName.ToLower() == categoryName.ToLower() && c.UserId == UserID);
                if (checkCat == true)
                {
                    lblMessage.Text = "Tên danh mục đã tồn tại.";
                    return;
                }

                var newCategory = new Categories
                {
                    CategoryName = categoryName,
                    Type = type,
                    UserId = UserID
                };
                _catRepo.Upsert(newCategory);
                _uow.Commit();
                lblMessage.Text = "Thêm danh mục thành công.";
            }
            else
            {
                // Cập nhật
                var category = _catRepo.Filter().FirstOrDefault(c => c.CategoryId == categoryId && c.UserId == UserID);
                if (category == null)
                {
                    lblMessage.Text = "Danh mục không tồn tại.";
                    return;
                }
                var checkCat = _catRepo.Filter().Any(c => c.CategoryName.ToLower() == categoryName.ToLower() && c.CategoryId != categoryId && c.UserId == UserID);
                if (checkCat == true)
                {
                    lblMessage.Text = "Tên danh mục đã tồn tại.";
                    return;
                }

                category.CategoryName = categoryName;
                category.Type = type;
                _catRepo.Upsert(category);
                _uow.Commit();

                lblMessage.Text = "Cập nhật danh mục thành công.";
            }
            ClearFields();
            BindGridView();
        }
    }
}