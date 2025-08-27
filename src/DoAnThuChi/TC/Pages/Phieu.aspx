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

        .form-control,
        .form-select {
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
                        <h2 class="card-title text-primary text-center mb-4">Quản lý Giao dịch</h2>

                        <div class="d-flex justify-content-end mb-4">
                            <a href="ThemPhieu.aspx" class="btn btn-primary">Thêm Giao Dịch Mới</a>
                        </div>

                        <!-- Lọc và Hiển thị Giao dịch -->
                        <div class="mb-4">
                            <h4 class="text-secondary mb-3">Lịch Sử Giao Dịch</h4>
                            <div class="row g-3 align-items-end mb-3">
                                <div class="col-md-4">
                                    <label for="ddlFilterCategory" class="form-label">Lọc theo Danh mục</label>
                                    <asp:DropDownList ID="ddlFilterCategory" runat="server" CssClass="form-select" DataTextField="CategoryName" DataValueField="CategoryId"></asp:DropDownList>
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
                                    <asp:Button ID="btnFilter" runat="server" Text="Lọc" CssClass="btn btn-outline-primary" OnClick="btnFinFilter_Click" />
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <asp:GridView ID="gvTransactions" runat="server" AutoGenerateColumns="False" DataKeyNames="TransactionId" CssClass="table table-hover table-striped" GridLines="None" AllowPaging="True" PageSize="10" OnRowEditing="gvTransactions_RowEditing" OnRowCancelingEdit="gvTransactions_RowCancelingEdit" OnRowUpdating="gvTransactions_RowUpdating" OnRowDeleting="gvTransactions_RowDeleting" OnPageIndexChanging="gvTransactions_PageIndexChanging" OnRowDataBound="gvTransactions_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Ngày" SortExpression="TransactionDate">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%# Bind("TransactionDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEditDate" runat="server" Text='<%# Bind("TransactionDate", "{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Mô Tả" SortExpression="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEditDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Danh Mục">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCategoryName" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlEditCategory" runat="server" CssClass="form-select"></asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Số Tiền" SortExpression="Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount", "{0:N0}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEditAmount" runat="server" Text='<%# Bind("Amount", "{0:F0}") %>' TextMode="Number" CssClass="form-control"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="Thao tác" EditText="Sửa" CancelText="Hủy" UpdateText="Lưu" DeleteText="Xóa" ControlStyle-CssClass="btn btn-sm" ButtonType="Link">
                                        <ControlStyle CssClass="btn btn-sm p-0 me-2 text-info"></ControlStyle>
                                    </asp:CommandField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center p-3">
                                        <p class="mb-0">Chưa có giao dịch nào được ghi lại.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <HeaderStyle CssClass="bg-primary text-info" />
                                <RowStyle CssClass="" />
                                <AlternatingRowStyle CssClass="" />
                                <PagerStyle CssClass="pagination-style" />
                                <EditRowStyle BackColor="#ffffcc" />
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