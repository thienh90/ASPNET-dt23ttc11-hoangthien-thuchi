<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="TC.Pages.DangKy" %>


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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   <main class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="card p-4">
                    <div class="card-body">
                        <h2 class="card-title text-primary text-center mb-4">Tạo Tài Khoản Mới</h2>
                        <asp:Panel ID="pnlRegistration" runat="server">

                            <!-- Tên đầy đủ -->
                            <div class="mb-3">
                                <label for="txtFullName" class="form-label">Họ và Tên</label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control w-100" placeholder="Nhập họ và tên"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                                    ErrorMessage="Vui lòng nhập họ và tên." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <!-- Tên đăng nhập -->
                            <div class="mb-3">
                                <label for="txtUsername" class="form-label">Tên Đăng Nhập</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control w-100" placeholder="Tên đăng nhập không dấu"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                                    ErrorMessage="Vui lòng nhập tên đăng nhập." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                 <asp:CustomValidator ID="cvUsernameExists" runat="server" ControlToValidate="txtUsername"
        ErrorMessage="Tên đăng nhập này đã tồn tại." CssClass="validation-error" Display="Dynamic" OnServerValidate="cvUsernameExists_ServerValidate"></asp:CustomValidator>

                            </div>

                            <!-- Email -->
                            <div class="mb-3">
                                <label for="txtEmail" class="form-label">Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control w-100" TextMode="Email" placeholder="ví dụ: tenban@email.com"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                    ErrorMessage="Vui lòng nhập địa chỉ email." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ErrorMessage="Địa chỉ email không hợp lệ." CssClass="validation-error" Display="Dynamic"></asp:RegularExpressionValidator>
                                 <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtEmail"
        ErrorMessage="Email này đã tồn tại." CssClass="validation-error" Display="Dynamic" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
                            </div>

                            <!-- Mật khẩu -->
                            <div class="mb-3">
                                <label for="txtPassword" class="form-label">Mật Khẩu</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control w-100" TextMode="Password" placeholder="Nhập mật khẩu"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                                    ErrorMessage="Vui lòng nhập mật khẩu." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <!-- Xác nhận mật khẩu -->
                            <div class="mb-3">
                                <label for="txtConfirmPassword" class="form-label">Xác Nhận Mật Khẩu</label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control w-100" TextMode="Password" placeholder="Nhập lại mật khẩu"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                                    ErrorMessage="Vui lòng xác nhận mật khẩu." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="txtConfirmPassword"
                                    ControlToCompare="txtPassword" ErrorMessage="Mật khẩu không khớp." CssClass="validation-error" Display="Dynamic"></asp:CompareValidator>
                            </div>

                            <!-- Nút Đăng ký -->
                            <div class="d-grid gap-2 mt-4">
                                <asp:Button ID="btnRegister" runat="server" Text="Đăng Ký" CssClass="btn btn-primary btn-lg" OnClick="btnRegister_Click" />
                            </div>

                            <!-- Hiển thị tóm tắt lỗi -->
                            <div class="text-center mt-3">
                                <asp:ValidationSummary ID="vsRegistration" runat="server" CssClass="validation-error mt-2" HeaderText="Vui lòng sửa các lỗi sau:" />
                            </div>
                        </asp:Panel>
                        <!-- Hiển thị thông báo khi đăng ký thành công -->
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-success mt-3" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </main>
</asp:Content>