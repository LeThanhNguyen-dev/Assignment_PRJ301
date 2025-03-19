<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng Ký Thành Công</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome cho biểu tượng -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%); /* Màu nền giống header.jsp và login.jsp */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px; /* Để tránh bị header che */
        }

        .container {
            max-width: 450px;
            padding: 40px;
            background: #ffffff; /* Nền trắng giống login.jsp */
            border: 2px solid #ccc; /* Viền xám giống login.jsp */
            border-radius: 15px; /* Bo góc giống login.jsp */
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); /* Hiệu ứng bóng giống login.jsp */
            text-align: center;
            transition: all 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px); /* Hiệu ứng nâng lên giống login.jsp */
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
        }

        .confirmation-icon {
            font-size: 80px;
            color: #28a745; /* Màu xanh lá cho biểu tượng thành công */
            margin-bottom: 25px;
        }

        h1 {
            font-size: 28px;
            font-weight: 600;
            color: #333; /* Màu chữ giống header.jsp */
            margin-bottom: 15px;
        }

        p {
            font-size: 16px;
            color: #666; /* Màu chữ phụ giống login.jsp */
            margin-bottom: 30px;
        }

        .btn-login {
            display: inline-block;
            padding: 12px 35px;
            background: linear-gradient(45deg, #d4af37, #c0a062); /* Gradient vàng giống login.jsp */
            color: #333; /* Màu chữ giống login.jsp */
            text-decoration: none;
            border-radius: 8px; /* Bo góc giống login.jsp */
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background: linear-gradient(45deg, #c0a062, #d4af37); /* Gradient đảo ngược khi hover */
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4); /* Hiệu ứng bóng giống login.jsp */
        }

        /* Responsive */
        @media (max-width: 576px) {
            .container {
                max-width: 90%;
                padding: 30px;
            }

            h1 {
                font-size: 24px;
            }

            p {
                font-size: 14px;
            }

            .btn-login {
                padding: 10px 25px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="confirmation-icon">
            <i class="fas fa-check-circle"></i> <!-- Sử dụng Font Awesome giống header.jsp -->
        </div>
        <h1>Đăng Ký Thành Công!</h1>
        <p>Cảm ơn bạn đã đăng ký. Vui lòng đăng nhập để tiếp tục.</p>
        <a href="login.jsp" class="btn-login">Đăng Nhập</a>
    </div>

    <!-- Bootstrap 5 JS và Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>