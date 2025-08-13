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
    public partial class DangKy : System.Web.UI.Page
    {
        private IUnitOfWork _uow;
        private IRepository<Users> _userRepo;
        public DangKy()
        {
            _uow = ServiceLocator.GetService<IUnitOfWork>();
            _userRepo = _uow.Repository<Users>();
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            var user = new Users();
            user.Username = txtUsername.Text.ToLower();
            user.FullName = txtFullName.Text;
            user.Password = txtPassword.Text;
            user.Email = txtEmail.Text;
            _userRepo.Add(user);
            _uow.Commit();
            // Hiển thị thông báo đăng ký thành công
            lblMessage.Text = "Đăng ký thành công!";
            lblMessage.CssClass = "text-success";
            // Xóa các trường nhập liệu
            txtUsername.Text = string.Empty;
            txtFullName.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtEmail.Text = string.Empty;
        }

        protected void cvUsernameExists_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var username = args.Value.ToLower();
            // Kiểm tra xem tên đăng nhập đã tồn tại trong cơ sở dữ liệu chưa
            var userExists = _userRepo.Filter().Any(x => x.Username.ToLower() == username);
            args.IsValid = !userExists; // Trả về true nếu không tồn tại, false nếu đã tồn tại
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var email = args.Value.ToLower();
            // Kiểm tra xem email đã tồn tại trong cơ sở dữ liệu chưa
            var emailExists = _userRepo.Filter().Any(x => x.Email.ToLower() == email);
            args.IsValid = !emailExists; // Trả về true nếu không tồn tại, false nếu đã tồn tại
        }
    }
}