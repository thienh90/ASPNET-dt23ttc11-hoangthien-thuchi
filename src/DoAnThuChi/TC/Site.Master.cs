using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TC.Services.Models;

namespace TC
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra xem Session["Username"] có tồn tại không
            var user = Session["User"] as Users;
            if (user != null)
            {
                // Nếu người dùng đã đăng nhập
                pnlLoggedOut.Visible = false;
                pnlLoggedOutNav.Visible = false;
                pnlLoggedIn.Visible = true;
                pnlLoggedInNav.Visible = true;
                litUsername.Text = user.FullName;
            }
            else
            {
                // Nếu người dùng chưa đăng nhập
                pnlLoggedOut.Visible = true;
                pnlLoggedOutNav.Visible = true;
                pnlLoggedIn.Visible = false;
                pnlLoggedInNav.Visible = false;
            }
        }

        protected void lbtnSignOut_Click(object sender, EventArgs e)
        {
            Session["User"] = null;
            Response.Redirect("~/");
        }
    }
}