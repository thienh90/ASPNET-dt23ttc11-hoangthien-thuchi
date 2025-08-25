<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DanhMuc.aspx.cs" Inherits="TC.Pages.DanhMuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn {
            border-radius: 8px;
        }
        .form-control {
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
                <div class="card p-4" style="min-height: 72vh;">
                    <div class="card-body">
                        <h2 class="card-title text-primary text-center mb-4">Quản Lý Danh Mục Thu Chi</h2>
                        
                        <!-- Hiển thị GridView để CRUD danh mục -->
                        <div class="table-responsive">
                            <asp:GridView ID="gvCategories" runat="server" 
                                AutoGenerateColumns="False" 
                                DataKeyNames="CategoryID"
                                CssClass="table table-hover table-striped"
                                GridLines="None"
                                AllowPaging="True" PageSize="10"
                                OnRowEditing="gvCategories_RowEditing"
                                OnRowDeleting="gvCategories_RowDeleting"
                                >
                                <Columns>
                                    <asp:BoundField DataField="CategoryName" HeaderText="Tên Danh Mục" SortExpression="CategoryName" />
                                    <asp:BoundField DataField="Type" HeaderText="Loại" SortExpression="Type" />
                                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="Thao tác" EditText="Sửa" DeleteText="Xóa" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center p-3">
                                        <p class="mb-0">Chưa có danh mục nào được tạo.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <HeaderStyle CssClass="bg-primary text-info" />
                                <RowStyle CssClass="" />
                                <AlternatingRowStyle CssClass="" />
                            </asp:GridView>
                        </div>

                        <!-- Form thêm danh mục mới -->
                        <div class="mt-4">
                            <h4 class="text-secondary">Thêm/Sửa Danh mục</h4>
                            <div class="row g-3 align-items-end">
                                <div class="col-md-5">
                                    <label for="txtCategoryName" class="form-label">Tên Danh Mục</label>
                                    <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="Ví dụ: Ăn uống, Lương"></asp:TextBox>
                                    <asp:TextBox ID="txtCategoryId" runat="server" Visible="false"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="ddlType" class="form-label">Loại</label>
                                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="Chi">Chi</asp:ListItem>
                                        <asp:ListItem Value="Thu">Thu</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-3 d-grid">
                                    <asp:Button ID="btnAddCategory" runat="server" Text="Lưu" CssClass="btn btn-primary" OnClick="btnAddCategory_Click" />
                                </div>
                            </div>
                        </div>

                        <!-- Hiển thị thông báo -->
                        <div class="text-center mt-3">
                            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>