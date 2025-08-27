using System;
using System.Data.Entity;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using TC.Services;
using TC.Services.Models;

namespace TC.Pages
{
    public partial class Phieu : System.Web.UI.Page
    {
        private IUnitOfWork _uow;
        private IRepository<Categories> _catRepo;
        private IRepository<Transactions> _tranRepo;

        public Phieu()
        {
            _uow = ServiceLocator.GetService<IUnitOfWork>();
            _catRepo = _uow.Repository<Categories>();
            _tranRepo = _uow.Repository<Transactions>();
        }

        private int UserID
        {
            get
            {
                if (Session["User"] != null)
                {
                    var user = Session["User"] as Users;
                    return user.UserId;
                }
                Response.Redirect("/Pages/DangNhap.aspx");
                return -1;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateFilterDropDown();
                BindTransactions();
            }
        }

        private void PopulateFilterDropDown()
        {
            var cats = _catRepo.Filter().Where(_ => _.UserId == UserID).ToList();
            ddlFilterCategory.DataSource = cats;
            ddlFilterCategory.DataTextField = "CategoryName";
            ddlFilterCategory.DataValueField = "CategoryId";
            ddlFilterCategory.DataBind();
            ddlFilterCategory.Items.Insert(0, new ListItem("Tất cả danh mục", "0"));
        }

        private void BindTransactions(int? categoryId = null, DateTime? startDate = null, DateTime? endDate = null)
        {
            var transactionsQuery = _tranRepo.Filter()
                                             .Include(t => t.Category)
                                             .Where(t => t.UserId == UserID);

            if (categoryId.HasValue && categoryId.Value > 0)
            {
                transactionsQuery = transactionsQuery.Where(t => t.CategoryId == categoryId.Value);
            }
            if (startDate.HasValue)
            {
                transactionsQuery = transactionsQuery.Where(t => t.TransactionDate >= startDate.Value);
            }
            if (endDate.HasValue)
            {
                var inclusiveEndDate = endDate.Value.AddDays(1).Date;
                transactionsQuery = transactionsQuery.Where(t => t.TransactionDate < inclusiveEndDate);
            }

            var displayData = transactionsQuery
                              .OrderByDescending(t => t.TransactionDate)
                              .Select(t => new
                              {
                                  t.TransactionId,
                                  t.TransactionDate,
                                  t.Description,
                                  CategoryName = t.Category.CategoryName,
                                  t.Amount
                              });

            gvTransactions.DataSource = displayData.ToList();
            gvTransactions.DataBind();
        }

        protected void btnFinFilter_Click(object sender, EventArgs e)
        {
            int? categoryId = null;
            if (int.TryParse(ddlFilterCategory.SelectedValue, out int catId) && catId > 0)
            {
                categoryId = catId;
            }

            DateTime? startDate = null;
            if (!string.IsNullOrEmpty(txtStartDate.Text) && DateTime.TryParse(txtStartDate.Text, out DateTime sDate))
            {
                startDate = sDate;
            }

            DateTime? endDate = null;
            if (!string.IsNullOrEmpty(txtEndDate.Text) && DateTime.TryParse(txtEndDate.Text, out DateTime eDate))
            {
                endDate = eDate;
            }

            ViewState["FilterCategoryId"] = categoryId;
            ViewState["FilterStartDate"] = startDate;
            ViewState["FilterEndDate"] = endDate;

            gvTransactions.PageIndex = 0;
            BindTransactions(categoryId, startDate, endDate);
        }

        protected void gvTransactions_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTransactions.EditIndex = e.NewEditIndex;
            int? categoryId = ViewState["FilterCategoryId"] as int?;
            DateTime? startDate = ViewState["FilterStartDate"] as DateTime?;
            DateTime? endDate = ViewState["FilterEndDate"] as DateTime?;
            BindTransactions(categoryId, startDate, endDate);
        }

        protected void gvTransactions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTransactions.EditIndex = -1;
            int? categoryId = ViewState["FilterCategoryId"] as int?;
            DateTime? startDate = ViewState["FilterStartDate"] as DateTime?;
            DateTime? endDate = ViewState["FilterEndDate"] as DateTime?;
            BindTransactions(categoryId, startDate, endDate);
        }

        protected void gvTransactions_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int transactionId = Convert.ToInt32(gvTransactions.DataKeys[e.RowIndex].Value);
                var transactionToUpdate = _tranRepo.GetById(transactionId);

                if (transactionToUpdate != null)
                {
                    TextBox txtEditDate = gvTransactions.Rows[e.RowIndex].FindControl("txtEditDate") as TextBox;
                    TextBox txtEditDescription = gvTransactions.Rows[e.RowIndex].FindControl("txtEditDescription") as TextBox;
                    DropDownList ddlEditCategory = gvTransactions.Rows[e.RowIndex].FindControl("ddlEditCategory") as DropDownList;
                    TextBox txtEditAmount = gvTransactions.Rows[e.RowIndex].FindControl("txtEditAmount") as TextBox;

                    transactionToUpdate.TransactionDate = DateTime.Parse(txtEditDate.Text);
                    transactionToUpdate.Description = txtEditDescription.Text;
                    transactionToUpdate.CategoryId = int.Parse(ddlEditCategory.SelectedValue);
                    transactionToUpdate.Amount = decimal.Parse(txtEditAmount.Text);

                    _tranRepo.Upsert(transactionToUpdate);
                    _uow.Commit();

                    gvTransactions.EditIndex = -1;
                    lblMessage.Text = "Cập nhật giao dịch thành công!";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi cập nhật: " + ex.Message;
            }
            finally
            {
                int? categoryId = ViewState["FilterCategoryId"] as int?;
                DateTime? startDate = ViewState["FilterStartDate"] as DateTime?;
                DateTime? endDate = ViewState["FilterEndDate"] as DateTime?;
                BindTransactions(categoryId, startDate, endDate);
            }
        }

        protected void gvTransactions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int transactionId = Convert.ToInt32(gvTransactions.DataKeys[e.RowIndex].Value);
                var transactionToDelete = _tranRepo.GetById(transactionId);

                if (transactionToDelete != null)
                {
                    _tranRepo.Remove(transactionToDelete);
                    _uow.Commit();
                    lblMessage.Text = "Giao dịch đã được xóa thành công.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi xóa: " + ex.Message;
            }
            finally
            {
                int? categoryId = ViewState["FilterCategoryId"] as int?;
                DateTime? startDate = ViewState["FilterStartDate"] as DateTime?;
                DateTime? endDate = ViewState["FilterEndDate"] as DateTime?;
                BindTransactions(categoryId, startDate, endDate);
            }
        }

        protected void gvTransactions_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTransactions.PageIndex = e.NewPageIndex;
            int? categoryId = ViewState["FilterCategoryId"] as int?;
            DateTime? startDate = ViewState["FilterStartDate"] as DateTime?;
            DateTime? endDate = ViewState["FilterEndDate"] as DateTime?;
            BindTransactions(categoryId, startDate, endDate);
        }

        protected void gvTransactions_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList ddlEditCategory = (DropDownList)e.Row.FindControl("ddlEditCategory");
                if (ddlEditCategory != null)
                {
                    var cats = _catRepo.Filter().Where(_ => _.UserId == UserID).ToList();
                    ddlEditCategory.DataSource = cats;
                    ddlEditCategory.DataTextField = "CategoryName";
                    ddlEditCategory.DataValueField = "CategoryId";
                    ddlEditCategory.DataBind();

                    // The DataItem is an anonymous type, so we can't easily get the CategoryId directly.
                    // We'll fetch the original transaction to get the value.
                    int transactionId = Convert.ToInt32(gvTransactions.DataKeys[e.Row.RowIndex].Value);
                    var transaction = _tranRepo.GetById(transactionId);
                    if (transaction != null)
                    {
                        ddlEditCategory.SelectedValue = transaction.CategoryId.ToString();
                    }
                }
            }
        }
    }
}
