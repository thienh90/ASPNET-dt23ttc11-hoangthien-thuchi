using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TC.Services;
using TC.Services.Models;
using System.Data.Entity; // Required for .Include()
using System.Globalization; // For month formatting

namespace TC.Pages
{
    public partial class BangDieuKhien : System.Web.UI.Page
    {
        private IUnitOfWork _uow;
        private IRepository<Transactions> _tranRepo;
        private IRepository<Categories> _catRepo;

        // Public properties to expose chart data to the client-side
        public string ExpenseByCategoryJson { get; set; }
        public string IncomeVsExpenseJson { get; set; }
        public string BalanceTrendJson { get; set; }

        public BangDieuKhien()
        {
            _uow = ServiceLocator.GetService<IUnitOfWork>();
            _tranRepo = _uow.Repository<Transactions>();
            _catRepo = _uow.Repository<Categories>();
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
                return -1; // Should not be reached due to redirect
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra xem người dùng đã đăng nhập hay chưa
            if (Session["User"] == null)
            {
                Response.Redirect("/Pages/DangNhap.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadDashboardData();
                }
            }
        }

        private void LoadDashboardData()
        {
            int currentUserId = UserID;
            var transactions = _tranRepo.Filter()
                                        .Include(t => t.Category) // Tải Category để lọc theo Type
                                        .Where(t => t.UserId == currentUserId)
                                        .OrderBy(t => t.TransactionDate)
                                        .ToList();

            decimal totalIncome = transactions
                                    .Where(t => t.Category != null && t.Category.Type == "Thu")
                                    .Sum(t => t.Amount);

            decimal totalExpense = transactions
                                    .Where(t => t.Category != null && t.Category.Type == "Chi")
                                    .Sum(t => t.Amount);

            decimal netBalance = totalIncome - totalExpense;

            // Lấy số lượng giao dịch trong tháng hiện tại
            DateTime firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            DateTime lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);

            int monthlyTransactions = transactions
                                        .Where(t => t.TransactionDate >= firstDayOfMonth && t.TransactionDate <= lastDayOfMonth)
                                        .Count();

            // Gán giá trị vào các điều khiển Literal
            litCurrentBalance.Text = netBalance.ToString("N0");
            litMonthlyIncome.Text = totalIncome.ToString("N0");
            litMonthlyExpense.Text = totalExpense.ToString("N0");
            litMonthlyTransactions.Text = monthlyTransactions.ToString();

            // --- Prepare data for charts ---

            // 1. Chi Tiêu Theo Danh Mục (Expense by Category) & Phân Bổ Chi Tiêu (Expense Distribution)
            var expenseByCategory = transactions
                .Where(t => t.Category != null && t.Category.Type == "Chi")
                .GroupBy(t => t.Category.CategoryName)
                .Select(g => new { Category = g.Key, TotalAmount = g.Sum(t => t.Amount) })
                .OrderByDescending(x => x.TotalAmount)
                .ToList();
            ExpenseByCategoryJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(expenseByCategory);

            // 2. Thu Nhập vs Chi Tiêu (6 Tháng Gần Nhất) (Income vs Expense Last 6 Months)
            var monthlyData = new List<object>();
            for (int i = 5; i >= 0; i--) // Last 6 months including current
            {
                DateTime month = DateTime.Now.AddMonths(-i);
                DateTime startOfMonth = new DateTime(month.Year, month.Month, 1);
                DateTime endOfMonth = startOfMonth.AddMonths(1).AddDays(-1);

                var monthTransactions = transactions.Where(t => t.TransactionDate >= startOfMonth && t.TransactionDate <= endOfMonth).ToList();

                decimal monthIncome = monthTransactions
                    .Where(t => t.Category != null && t.Category.Type == "Thu")
                    .Sum(t => t.Amount);

                decimal monthExpense = monthTransactions
                    .Where(t => t.Category != null && t.Category.Type == "Chi")
                    .Sum(t => t.Amount);

                monthlyData.Add(new
                {
                    Month = month.ToString("MMM yyyy", new CultureInfo("vi-VN")), // Format month name
                    Income = monthIncome,
                    Expense = monthExpense
                });
            }
            IncomeVsExpenseJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(monthlyData);

            // 3. Xu Hướng Số Dư (Balance Trend)
            var balanceTrend = new List<object>();
            decimal runningBalance = 0;
            foreach (var tran in transactions.OrderBy(t => t.TransactionDate))
            {
                if (tran.Category != null)
                {
                    if (tran.Category.Type == "Thu")
                    {
                        runningBalance += tran.Amount;
                    }
                    else if (tran.Category.Type == "Chi")
                    {
                        runningBalance -= tran.Amount;
                    }
                }
                balanceTrend.Add(new { Date = tran.TransactionDate.ToString("yyyy-MM-dd"), Balance = runningBalance });
            }
            BalanceTrendJson = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(balanceTrend);
        }
    }
}