<%@ Page Title="Giới thiệu" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="TC.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .about-section {
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .feature-list {
            list-style: none;
            padding-left: 0;
        }

        .feature-list li {
            background: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-circle-fill" viewBox="0 0 16 16"><path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z" fill="green"/></svg>') no-repeat left center;
            padding-left: 25px;
            margin-bottom: 10px;
            font-size: 1.1em;
        }
    </style>

    <main aria-labelledby="title" class="about-section">
        <h2 id="title" class="text-center text-primary" style="font-weight: bold;"><%: Title %>: Làm Chủ Tài Chính, Kiến Tạo Tương Lai</h2>
        <p class="lead text-center">
            Chào mừng bạn đến với ứng dụng Quản lý Thu chi Cá nhân - người bạn đồng hành đáng tin cậy trên hành trình tài chính của bạn.
        </p>
        <hr />

        <div class="row mt-4">
            <div class="col-md-12">
                <h3><i class="bi bi-question-circle-fill text-warning"></i> Tại sao bạn cần chúng tôi?</h3>
                <p>
                    Bạn có bao giờ cảm thấy bối rối không biết tiền của mình đã "đi đâu về đâu" vào cuối tháng? Bạn có những mục tiêu lớn lao nhưng lại cảm thấy chúng thật xa vời vì không thể tiết kiệm? Quản lý tài chính cá nhân không hề đơn giản, và chúng tôi hiểu điều đó. Giữa bộn bề cuộc sống, việc theo dõi từng đồng thu chi có thể trở nên mệt mỏi và dễ bị bỏ qua, dẫn đến những quyết định tài chính không tối ưu.
                </p>

                <h3 class="mt-4"><i class="bi bi-lightbulb-fill text-success"></i> Giải pháp của chúng tôi là gì?</h3>
                <p>
                    Ứng dụng Quản lý Thu chi Cá nhân ra đời với sứ mệnh đơn giản hóa cuộc sống tài chính của bạn. Với giao diện trực quan và các công cụ mạnh mẽ, chúng tôi giúp bạn:
                </p>
                <ul class="feature-list">
                    <li><strong>Ghi chép nhanh chóng:</strong> Dễ dàng nhập các khoản thu, chi mọi lúc mọi nơi chỉ với vài thao tác.</li>
                    <li><strong>Theo dõi thông minh:</strong> Các báo cáo, biểu đồ sinh động giúp bạn có cái nhìn tổng quan và sâu sắc về thói quen chi tiêu.</li>
                    <li><strong>Lập kế hoạch hiệu quả:</strong> Thiết lập ngân sách cho từng hạng mục và nhận cảnh báo khi sắp vượt mức để điều chỉnh kịp thời.</li>
                    <li><strong>Đặt mục tiêu và đạt được:</strong> Xây dựng các kế hoạch tiết kiệm cho những ước mơ (du lịch, mua sắm, đầu tư...) và theo dõi tiến trình mỗi ngày.</li>
                </ul>

                <h3 class="mt-4"><i class="bi bi-gem text-info"></i> Tầm nhìn và Sứ mệnh</h3>
                <p>
                    Đây không chỉ là một đồ án tốt nghiệp, mà là tâm huyết của chúng tôi với mong muốn tạo ra một công cụ thực sự hữu ích. Chúng tôi tin rằng việc quản lý tài chính tốt không chỉ là về những con số, mà là về việc xây dựng một cuộc sống tự do, an tâm và có kế hoạch. Hãy để ứng dụng này trở thành trợ lý đắc lực, giúp bạn kiểm soát tương lai tài chính và tự tin thực hiện mọi dự định. Bắt đầu hành trình của bạn ngay hôm nay!
                </p>
            </div>
        </div>
    </main>
</asp:Content>
