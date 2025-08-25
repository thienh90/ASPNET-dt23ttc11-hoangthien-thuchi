<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Phieu.aspx.cs" Inherits="TC.Pages.Phieu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn {
            border-radius: 8px;
        }
        .form-control, .form-select {
            border-radius: 8px;
        }
        .validation-error {
            color: #dc3545;
            font-size: 0.875em;
        }
        .form-control {
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-md-12">
                <div class="card p-4">
                    <div class="card-body">
                        <h2 class="card-title text-primary text-center mb-4">Quản Lý Giao Dịch</h2>
                        
                        <!-- Form Thêm Giao dịch mới -->
                        <div class="mb-5">
                            <h4 class="text-secondary mb-3">Thêm Giao Dịch Mới</h4>
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label for="txtAmount" class="form-label">Số Tiền</label>
                                    <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" TextMode="Number" placeholder="Nhập số tiền"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ControlToValidate="txtAmount"
                                        ErrorMessage="Vui lòng nhập số tiền." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label for="txtDate" class="form-label">Ngày</label>
                                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate"
                                        ErrorMessage="Vui lòng chọn ngày." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3">
                                    <label for="ddlCategories" class="form-label">Danh Mục</label>
                                    <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-select"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategories"
                                        ErrorMessage="Vui lòng chọn danh mục." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-3 d-grid">
                                    <asp:Button ID="btnAddTransaction" runat="server" Text="Thêm Giao Dịch" CssClass="btn btn-success mt-4" OnClick="btnAddTransaction_Click" />
                                </div>
                                <div class="col-12">
                                    <label for="txtDescription" class="form-label">Mô Tả</label>
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Nhập mô tả chi tiết"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                        ErrorMessage="Vui lòng nhập mô tả." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="text-center mt-3">
                                <asp:ValidationSummary ID="vsAddTransaction" runat="server" CssClass="validation-error" HeaderText="Lỗi:" />
                                <asp:Label ID="lblAddMessage" runat="server" CssClass="text-success"></asp:Label>
                            </div>
                        </div>

                        <hr />

                        <!-- Lọc và Hiển thị Giao dịch -->
                        <div class="mb-4">
                            <h4 class="text-secondary mb-3">Lịch Sử Giao Dịch</h4>
                            <div class="row g-3 align-items-end mb-3">
                                <div class="col-md-4">
                                    <label for="ddlFilterCategory" class="form-label">Lọc theo Danh mục</label>
                                    <asp:DropDownList ID="ddlFilterCategory" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label for="txtStartDate" class="form-label">Từ Ngày</label>
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label for="txtEndDate" class="form-label">Đến Ngày</label>
                                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                </div>
                                <div class="col-md-2 d-grid">
                                    <asp:Button ID="btnFilter" runat="server" Text="Lọc" CssClass="btn btn-outline-primary" OnClick="btnFilter_Click" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="table-responsive">
                            <asp:GridView ID="gvTransactions" runat="server" 
                                AutoGenerateColumns="False" 
                                DataKeyNames="TransactionID"
                                CssClass="table table-hover table-striped"
                                GridLines="None"
                                AllowPaging="True" PageSize="10"
                                OnRowEditing="gvTransactions_RowEditing"
                                OnRowCancelingEdit="gvTransactions_RowCancelingEdit"
                                OnRowUpdating="gvTransactions_RowUpdating"
                                OnRowDeleting="gvTransactions_RowDeleting"
                                OnPageIndexChanging="gvTransactions_PageIndexChanging">
                                <Columns>
                                    <asp:BoundField DataField="TransactionDate" HeaderText="Ngày" SortExpression="TransactionDate" DataFormatString="{0:dd/MM/yyyy}" />
                                    <asp:BoundField DataField="Description" HeaderText="Mô Tả" SortExpression="Description" />
                                    <asp:TemplateField HeaderText="Danh Mục">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCategoryName" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Số Tiền">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount", "{0:C0}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="Thao tác" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center p-3">
                                        <p class="mb-0">Chưa có giao dịch nào được ghi lại.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <HeaderStyle CssClass="bg-primary text-white" />
                                <PagerStyle CssClass="pagination-style" />
                                <RowStyle CssClass="table-light" />
                                <AlternatingRowStyle CssClass="table-secondary" />
                            </asp:GridView>
                        </div>
                        <div class="text-center mt-3">
                            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>