<%@ Page Title="Thêm Giao Dịch" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThemPhieu.aspx.cs" Inherits="TC.Pages.ThemPhieu" %>

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
            <div class="col-lg-8 col-md-10">
                <div class="card p-4">
                    <div class="card-body">
                        <h2 class="card-title text-primary text-center mb-4">Thêm Giao Dịch Mới</h2>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="txtAmount" class="form-label">Số Tiền</label>
                                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" TextMode="Number" placeholder="Nhập số tiền"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ControlToValidate="txtAmount"
                                    ErrorMessage="Vui lòng nhập số tiền." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <label for="txtDate" class="form-label">Ngày</label>
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate"
                                    ErrorMessage="Vui lòng chọn ngày." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-12">
                                <label for="ddlCategories" class="form-label">Danh Mục</label>
                                <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-select" DataTextField="CategoryName" DataValueField="CategoryId"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategories"
                                    ErrorMessage="Vui lòng chọn danh mục." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-12">
                                <label for="txtDescription" class="form-label">Mô Tả</label>
                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Nhập mô tả chi tiết" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                    ErrorMessage="Vui lòng nhập mô tả." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="text-center mt-4">
                            <asp:Button ID="btnAddTransaction" runat="server" Text="Lưu Giao Dịch" CssClass="btn btn-success me-2" OnClick="btnAddTransaction_Click" />
                            <a href="Phieu.aspx" class="btn btn-secondary">Hủy</a>
                        </div>
                        <div class="text-center mt-3">
                            <asp:ValidationSummary ID="vsAddTransaction" runat="server" CssClass="validation-error" HeaderText="Lỗi:" />
                            <asp:Label ID="lblAddMessage" runat="server" CssClass="text-success"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>