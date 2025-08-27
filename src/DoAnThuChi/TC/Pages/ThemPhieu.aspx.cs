using System;
using System.Linq;
using System.Web.UI;
using TC.Services;
using TC.Services.Models;

namespace TC.Pages
{
    public partial class ThemPhieu : System.Web.UI.Page
    {
        private IUnitOfWork _uow;
        private IRepository<Categories> _catRepo;
        private IRepository<Transactions> _tranRepo;

        public ThemPhieu()
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
                // Set default date to today
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                
                // Bind categories
                var cats = _catRepo.Filter().Where(_ => _.UserId == UserID).ToList();
                ddlCategories.DataSource = cats;
                ddlCategories.DataTextField = "CategoryName";
                ddlCategories.DataValueField = "CategoryId";
                ddlCategories.DataBind();
            }
        }

        protected void btnAddTransaction_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var newTransaction = new Transactions
                {
                    UserId = UserID,
                    Amount = decimal.Parse(txtAmount.Text),
                    TransactionDate = DateTime.Parse(txtDate.Text),
                    CategoryId = int.Parse(ddlCategories.SelectedValue),
                    Description = txtDescription.Text
                };
                _tranRepo.Upsert(newTransaction);
                _uow.Commit();

                // Redirect back to the main list page
                Response.Redirect("~/Pages/Phieu.aspx");
            }
        }
    }
}
