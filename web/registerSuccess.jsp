<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration Successful</title>
    <style>
        body {
            background: linear-gradient(135deg, #1a1a1a 0%, #333333 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            width: 400px;
            padding: 40px;
            background-color: #1f1f1f;
            border: 1px solid #9c1010;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            text-align: center;
            transition: transform 0.3s ease;
        }
        .container:hover {
            transform: translateY(-5px);
        }
        .confirmation-icon {
            font-size: 80px;
            color: #00cc00; /* Xanh lá cho thành công */
            margin-bottom: 20px;
        }
        h1 {
            color: #9c1010;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        p {
            color: #b3b3b3;
            font-size: 16px;
            margin-bottom: 30px;
        }
        .btn-login {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(45deg, #9c1010, #570808);
            color: #7d7777;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-login:hover {
            background: linear-gradient(45deg, #570808, #9c1010);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="confirmation-icon">✔️</div>
        <h1>Đăng Ký Thành Công!</h1>
        <p>Cảm ơn bạn đã đăng ký. Vui lòng đăng nhập để tiếp tục.</p>
        <a href="login.jsp" class="btn-login">Đăng Nhập</a>
    </div>
</body>
</html>