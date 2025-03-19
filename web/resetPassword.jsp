<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reset Password</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%); /* Gradient nền giống các trang khác */
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
            background-color: #ffffff; /* Nền trắng */
            border: 2px solid #ccc; /* Viền giống các trang khác */
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); /* Shadow nhẹ */
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #333; /* Màu chữ giống các trang khác */
            text-align: center;
            margin-bottom: 20px;
            font-weight: 700;
            text-transform: uppercase;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        h2 i {
            color: #d4af37; /* Màu icon vàng nhạt */
            font-size: 28px;
            transition: color 0.3s ease;
        }

        h2:hover i {
            color: #c0a062; /* Hover đổi màu */
        }

        p {
            color: #666; /* Màu chữ xám nhạt */
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            color: #333; /* Màu chữ giống các trang khác */
            font-weight: 500;
            font-size: 16px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px;
            border: 2px solid #ccc; /* Viền giống các trang khác */
            border-radius: 8px;
            background-color: #f5f5f5; /* Nền xám nhạt */
            color: #333;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #d4af37; /* Viền vàng nhạt khi focus */
            box-shadow: 0 0 5px rgba(212, 175, 55, 0.3);
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, #d4af37, #c0a062); /* Gradient vàng nhạt */
            color: #333;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        button[type="submit"]:hover {
            background: linear-gradient(45deg, #c0a062, #d4af37);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
        }

        .error-message {
            color: #ff4d4d;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .error-message.show {
            opacity: 1;
        }

        .back-link {
            text-align: center;
            margin-top: 15px;
        }

        .back-link a {
            color: #d4af37; /* Màu link vàng nhạt */
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .back-link a:hover {
            color: #c0a062; /* Hover đổi màu */
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-key"></i> Reset Your Password</h2>
        <p>Enter the OTP sent to your email and your new password.</p>
        <form action="resetPassword" method="POST">
            <label for="otp">OTP:</label>
            <input type="text" id="otp" name="otp" required>
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            <button type="submit">Reset Password</button>
        </form>
        <p class="error-message ${requestScope.error != null ? 'show' : ''}">${requestScope.error}</p>
        <div class="back-link">
            <a href="login.jsp">Back to Login</a>
        </div>
    </div>
</body>
</html>