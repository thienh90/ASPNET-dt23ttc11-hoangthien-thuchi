<%@ Page Title="Liên hệ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TC.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .contact-card {
            background-color: #f8f9fa;
            border-left: 5px solid #007bff;
            padding: 20px;
            margin-top: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .contact-info p {
            margin-bottom: 10px;
            font-size: 1.1em;
        }
        .contact-info .bi {
            margin-right: 10px;
            color: #007bff;
            width: 20px; /* Align icons */
            text-align: center;
        }
    </style>

    <main aria-labelledby="title">
        <h2 id="title" class="text-center text-primary" style="font-weight: bold;"><%: Title %></h2>
        <p class="lead text-center">
            Chúng tôi luôn sẵn lòng lắng nghe mọi ý kiến đóng góp, báo lỗi hoặc các câu hỏi từ bạn.
        </p>
        <hr />

        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="contact-card">
                    <h3>Thông tin người thực hiện đồ án</h3>
                    <div class="contact-info mt-3">
                        <p><i class="bi bi-person-fill"></i><strong>Họ và tên:</strong> Hoàng Thiên</p>
                        <p><i class="bi bi-card-text"></i><strong>Mã số sinh viên:</strong> 170123634</p>
                        <p><i class="bi bi-people-fill"></i><strong>Lớp:</strong> DT23TTC11</p>
                        <p><i class="bi bi-building"></i><strong>Trường:</strong> Đại học Trà Vinh</p>
                        <hr>
                        <p><i class="bi bi-envelope-fill"></i><strong>Email:</strong> <a href="mailto:thienh251290@sv-onuni.edu.vn">thienh251290@sv-onuni.edu.vn</a></p>
                        <p><i class="bi bi-telephone-fill"></i><strong>Điện thoại:</strong> 0398 445 823</p>
                        <p><i class="bi bi-github"></i><strong>GitHub:</strong> <a href="https://github.com/thienh90" target="_blank">https://github.com/thienh90</a></p>
                    </div>
                </div>

                <div class="mt-4 text-center">
                    <h4>Gửi phản hồi</h4>
                    <p>Nếu bạn có bất kỳ ý tưởng nào để cải thiện ứng dụng, đừng ngần ngại chia sẻ với chúng tôi qua email.</p>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
