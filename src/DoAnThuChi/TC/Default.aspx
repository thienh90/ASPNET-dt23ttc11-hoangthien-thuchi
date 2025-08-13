<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TC._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Inter', sans-serif; /* Sử dụng font Inter */
            background-color: #f8f9fa; /* Màu nền nhẹ */
        }
        .navbar {
            border-bottom-left-radius: 15px; /* Bo tròn góc dưới trái */
            border-bottom-right-radius: 15px; /* Bo tròn góc dưới phải */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
        }
        .card {
            border-radius: 15px; /* Bo tròn góc thẻ */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Đổ bóng */
        }
        .btn {
            border-radius: 8px; /* Bo tròn nút */
        }
        .hero-section {
            background: linear-gradient(rgba(197, 227, 238, 0.7), rgba(0, 123, 255, 0.7)), url('https://weupgroup.vn/wp-content/uploads/2022/03/quan-ly-thu-chi-doanh-nghiep-1-1.jpg') no-repeat center center;
            /*background: url('https://weupgroup.vn/wp-content/uploads/2022/03/quan-ly-thu-chi-doanh-nghiep-1-1.jpg') no-repeat center center;*/
            background-size: cover;
            color: white;
            padding: 80px 0;
            border-radius: 15px;
            margin-bottom: 3rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        .feature-icon {
            width: 80px;
            height: 80px;
            margin-bottom: 1rem;
        }
    </style>
    <!-- Hero Section (Phần giới thiệu chính) -->
    <header class="container hero-section text-center">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-md-12">
                <h1 class="display-4 fw-bold mb-4" style="color: aquamarine;">Chào mừng đến với Website Quản Lý Thu Chi Cá Nhân</h1>
                <p class="lead mb-4">
                    Kiểm soát tài chính của bạn chưa bao giờ dễ dàng đến thế!
                    Phần mềm của chúng tôi giúp bạn theo dõi thu nhập, chi tiêu, và phân tích thói quen tài chính một cách trực quan, hiệu quả.
                </p>
                <a href="#" class="btn btn-success btn-lg px-4 me-2">Bắt đầu ngay</a>
                <a href="#" class="btn btn-outline-light btn-lg px-4">Tìm hiểu thêm</a>
            </div>
        </div>
    </header>

    <!-- Main Content (Nội dung chính) -->
    <main class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="card text-center p-4">
                    <div class="card-body">
                        <h2 class="card-title text-primary mb-4">Tại sao bạn nên chọn chúng tôi?</h2>
                        <p class="card-text mb-4">
                            Với giao diện thân thiện, dễ sử dụng và các tính năng báo cáo thông minh, bạn sẽ có cái nhìn rõ ràng về dòng tiền của mình, từ đó đưa ra các quyết định tài chính sáng suốt hơn.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row my-5 text-center">
            <div class="col-md-4 mb-4">
                <div class="card h-100 p-3">
                    <div class="card-body">
                        <img src="https://placehold.co/80x80/FFD700/000000?text=Theo+dõi" class="img-fluid rounded-circle mb-3 feature-icon" alt="Icon theo dõi thu chi">
                        <h5 class="card-title text-secondary">Theo dõi thu chi</h5>
                        <p class="card-text">Ghi lại mọi giao dịch một cách nhanh chóng và chính xác.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 p-3">
                    <div class="card-body">
                        <img src="https://placehold.co/80x80/32CD32/000000?text=Báo+cáo" class="img-fluid rounded-circle mb-3 feature-icon" alt="Icon báo cáo trực quan">
                        <h5 class="card-title text-secondary">Báo cáo trực quan</h5>
                        <p class="card-text">Xem biểu đồ và thống kê chi tiết về tình hình tài chính của bạn.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 p-3">
                    <div class="card-body">
                        <img src="https://placehold.co/80x80/8A2BE2/000000?text=Danh+mục" class="img-fluid rounded-circle mb-3 feature-icon" alt="Icon quản lý danh mục">
                        <h5 class="card-title text-secondary">Quản lý danh mục</h5>
                        <p class="card-text">Tùy chỉnh các danh mục để phù hợp với nhu cầu của bạn.</p>
                    </div>
                </div>
            </div>
        </div>
    </main>


</asp:Content>
