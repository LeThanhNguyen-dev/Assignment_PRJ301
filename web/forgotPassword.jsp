<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px; /* Đẩy nội dung xuống để tránh bị header che */
        }

        .container {
            width: 400px;
            padding: 40px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 700;
        }

        p {
            color: #666;
            text-align: center;
            margin-bottom: 20px;
            font-size: 16px;
        }

        label {
            color: #333;
            font-weight: 500;
            font-size: 16px;
        }

        input[type="email"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px;
            border: 2px solid #ccc;
            border-radius: 8px;
            background-color: #f5f5f5;
            color: #333;
            font-size: 14px;
            box-sizing: border-box;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        input[type="email"]:focus {
            outline: none;
            border-color: #d4af37; /* Vàng nhạt */
            box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, #d4af37, #c0a062);
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
            color: #dc3545;
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
            color: #d4af37;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-link a:hover {
            color: #c0a062;
            text-decoration: underline;
        }

        .back-link a i {
            margin-right: 5px;
            transition: color 0.3s ease;
        }

        .back-link a:hover i {
            color: #c0a062;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-key"></i> Reset Password</h2>
        <p>Enter your email to receive a verification code.</p>
        <form action="forgotPassword" method="POST">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <button type="submit">Send OTP</button>
        </form>
        <p class="error-message ${requestScope.error != null ? 'show' : ''}">${requestScope.error}</p>
        <div class="back-link">
            <a href="login.jsp"><i class="fas fa-arrow-left"></i> Back to Login</a>
        </div>
    </div>
</body>
</html>