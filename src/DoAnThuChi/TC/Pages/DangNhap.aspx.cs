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
    public partial class DangNhap : System.Web.UI.Page
    {
        private IUnitOfWork _uow;
        private IRepository<Users> _userRepo;
        public DangNhap()
        {
            _uow = ServiceLocator.GetService<IUnitOfWork>();
            _userRepo = _uow.Repository<Users>();
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            var username = txtUsername.Text.ToLower();
            var password = txtPassword.Text;

            var user = _userRepo.Filter().FirstOrDefault(u => u.Username.ToLower() == username && u.Password == password);
            if (user != null)
            {
                // Login successful
                Session["User"] = user;
                Response.Redirect("BangDieuKhien.aspx");
            }
            else
            {
                // Login failed
                lblMessage.Text = "Tên đăng nhập hoặc mật khẩu không hợp lệ";
                lblMessage.CssClass = "text-danger";
                lblMessage.Visible = true;
            }
        }
    }
}