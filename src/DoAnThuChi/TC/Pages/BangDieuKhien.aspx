<%@ Page Title="Tổng Quan Tài Chính" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BangDieuKhien.aspx.cs" Inherits="TC.Pages.BangDieuKhien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .kpi-card {
            border-left: 5px solid;
            border-radius: .5rem;
        }
        .kpi-card .card-body {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .kpi-card .card-text {
            font-size: 1.1rem;
            font-weight: 500;
        }
        .kpi-card .card-title {
            font-size: 2.2rem;
            font-weight: 700;
        }
        .kpi-card i {
            font-size: 3.5rem;
            opacity: 0.3;
        }
        .border-primary { border-left-color: var(--bs-primary) !important; }
        .border-success { border-left-color: var(--bs-success) !important; }
        .border-danger { border-left-color: var(--bs-danger) !important; }
        .border-info { border-left-color: var(--bs-info) !important; }

        .chart-container {
            position: relative;
            height: 400px;
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-4 py-5">
        <h1 class="mt-4">Tổng Quan Tài Chính</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Nơi bạn quản lý dòng tiền hiệu quả</li>
        </ol>

        <!-- KPI Cards -->
        <div class="row">
            <div class="col-md-3 mb-4">
                <div class="card kpi-card border-primary shadow h-100 py-2">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs font-weight-bold text-primary text-uppercase">Số Dư Hiện Tại</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><asp:Literal ID="litCurrentBalance" runat="server"></asp:Literal></div>
                        </div>
                        <i class="bi bi-wallet2 text-primary" style="font-size: 2rem;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card kpi-card border-success shadow h-100 py-2">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs font-weight-bold text-success text-uppercase">Thu Nhập (Tháng Này)</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><asp:Literal ID="litMonthlyIncome" runat="server"></asp:Literal></div>
                        </div>
                        <i class="bi bi-arrow-up-circle text-success" style="font-size: 2rem;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card kpi-card border-danger shadow h-100 py-2">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs font-weight-bold text-danger text-uppercase">Chi Tiêu (Tháng Này)</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><asp:Literal ID="litMonthlyExpense" runat="server"></asp:Literal></div>
                        </div>
                        <i class="bi bi-arrow-down-circle text-danger" style="font-size: 2rem;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card kpi-card border-info shadow h-100 py-2">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="text-xs font-weight-bold text-info text-uppercase">Giao Dịch (Tháng Này)</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800"><asp:Literal ID="litMonthlyTransactions" runat="server"></asp:Literal></div>
                        </div>
                        <i class="bi bi-receipt text-info" style="font-size: 2rem;"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts -->
        <div class="row">
            <div class="col-xl-6">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Chi Tiêu Theo Danh Mục</h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="expenseByCategoryChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-6">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Thu Nhập vs Chi Tiêu (6 Tháng Gần Nhất)</h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="incomeVsExpenseChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xl-8">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Xu Hướng Số Dư</h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="balanceTrendChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-4">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Phân Bổ Chi Tiêu</h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="expenseDistributionChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Parse JSON data from code-behind
            var expenseByCategoryData = JSON.parse('<%= ExpenseByCategoryJson %>');
            var incomeVsExpenseData = JSON.parse('<%= IncomeVsExpenseJson %>');
            var balanceTrendData = JSON.parse('<%= BalanceTrendJson %>');

            // Helper function to format currency
            function formatCurrency(amount) {
                return amount.toLocaleString('vi-VN') + ' VNĐ';
            }

            // 1. Chi Tiêu Theo Danh Mục (Bar Chart)
            if (expenseByCategoryData && expenseByCategoryData.length > 0) {
                var ctxExpenseByCategory = document.getElementById('expenseByCategoryChart').getContext('2d');
                new Chart(ctxExpenseByCategory, {
                    type: 'bar',
                    data: {
                        labels: expenseByCategoryData.map(item => item.Category),
                        datasets: [{
                            label: 'Tổng Chi Tiêu',
                            data: expenseByCategoryData.map(item => item.TotalAmount),
                            backgroundColor: 'rgba(255, 99, 132, 0.5)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value, index, values) {
                                        return formatCurrency(value);
                                    }
                                }
                            }
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return context.dataset.label + ': ' + formatCurrency(context.raw);
                                    }
                                }
                            }
                        }
                    }
                });
            }

            // 2. Thu Nhập vs Chi Tiêu (Line Chart)
            if (incomeVsExpenseData && incomeVsExpenseData.length > 0) {
                var ctxIncomeVsExpense = document.getElementById('incomeVsExpenseChart').getContext('2d');
                new Chart(ctxIncomeVsExpense, {
                    type: 'line',
                    data: {
                        labels: incomeVsExpenseData.map(item => item.Month),
                        datasets: [
                            {
                                label: 'Thu Nhập',
                                data: incomeVsExpenseData.map(item => item.Income),
                                borderColor: 'rgba(75, 192, 192, 1)',
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                fill: true
                            },
                            {
                                label: 'Chi Nhập',
                                data: incomeVsExpenseData.map(item => item.Expense),
                                borderColor: 'rgba(255, 99, 132, 1)',
                                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                                fill: true
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value, index, values) {
                                        return formatCurrency(value);
                                    }
                                }
                            }
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return context.dataset.label + ': ' + formatCurrency(context.raw);
                                    }
                                }
                            }
                        }
                    }
                });
            }

            // 3. Xu Hướng Số Dư (Line Chart)
            if (balanceTrendData && balanceTrendData.length > 0) {
                var ctxBalanceTrend = document.getElementById('balanceTrendChart').getContext('2d');
                new Chart(ctxBalanceTrend, {
                    type: 'line',
                    data: {
                        labels: balanceTrendData.map(item => item.Date),
                        datasets: [{
                            label: 'Số Dư',
                            data: balanceTrendData.map(item => item.Balance),
                            borderColor: 'rgba(54, 162, 235, 1)',
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value, index, values) {
                                        return formatCurrency(value);
                                    }
                                }
                            }
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return context.dataset.label + ': ' + formatCurrency(context.raw);
                                    }
                                }
                            }
                        }
                    }
                });
            }

            // 4. Phân Bổ Chi Tiêu (Pie Chart)
            if (expenseByCategoryData && expenseByCategoryData.length > 0) {
                var ctxExpenseDistribution = document.getElementById('expenseDistributionChart').getContext('2d');
                var backgroundColors = [
                    '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40', '#8D6E63', '#FFD700', '#ADFF2F', '#20B2AA'
                ];
                new Chart(ctxExpenseDistribution, {
                    type: 'pie',
                    data: {
                        labels: expenseByCategoryData.map(item => item.Category),
                        datasets: [{
                            data: expenseByCategoryData.map(item => item.TotalAmount),
                            backgroundColor: backgroundColors.slice(0, expenseByCategoryData.length),
                            hoverOffset: 4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        let label = context.label || '';
                                        if (label) {
                                            label += ': ';
                                        }
                                        if (context.parsed !== null) {
                                            label += formatCurrency(context.parsed);
                                        }
                                        return label;
                                    }
                                }
                            }
                        }
                    }
                });
            }
        });
    </script>
</asp:Content>