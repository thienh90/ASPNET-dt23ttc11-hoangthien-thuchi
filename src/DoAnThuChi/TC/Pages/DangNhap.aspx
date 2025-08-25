<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="TC.Pages.DangNhap" %>
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
		<div class="row justify-content-center" style="min-height: 72vh;">
			<div class="col-lg-6 col-md-8">
				<div class="card p-4">
					<div class="card-body">
						<h2 class="card-title text-primary text-center mb-4">Đăng nhập</h2>
						<asp:Panel ID="pnlRegistration" runat="server">

							<!-- Tên đăng nhập -->
							<div class="mb-3">
								<label for="txtUsername" class="form-label">Tên Đăng Nhập</label>
								<asp:TextBox ID="txtUsername" runat="server" CssClass="form-control w-100" placeholder="Tên đăng nhập không dấu"></asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Vui lòng nhập tên đăng nhập." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
							</div>

							<!-- Mật khẩu -->
							<div class="mb-3">
								<label for="txtPassword" class="form-label">Mật Khẩu</label>
								<asp:TextBox ID="txtPassword" runat="server" CssClass="form-control w-100" TextMode="Password" placeholder="Nhập mật khẩu"></asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Vui lòng nhập mật khẩu." CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
							</div>

							<!-- Nút Đăng nhập -->
							<div class="d-grid gap-2 mt-4">
								<asp:Button ID="btnLogin" runat="server" Text="Đăng Nhập" CssClass="btn btn-primary btn-lg" OnClick="btnLogin_Click" />
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