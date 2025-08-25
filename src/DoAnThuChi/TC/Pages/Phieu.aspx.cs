using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TC.Pages
{
    public partial class Phieu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void BindTransactions()
        {
            // This method should bind the transaction data to the GridView
            // For example, you might retrieve data from a database and set it as the DataSource
            // gvTransactions.DataSource = GetTransactionData();
            // gvTransactions.DataBind();
        }

        protected void btnAddTransaction_Click(object sender, EventArgs e)
        {

        }

        protected void gvTransactions_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gvTransactions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void gvTransactions_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gvTransactions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void gvTransactions_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            // Set the new page index for the GridView
            gvTransactions.PageIndex = e.NewPageIndex;
            // Rebind the data to the GridView
            BindTransactions();
        }
    }
}