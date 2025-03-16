<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Forgot Password</title>
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
            transition: transform 0.3s ease;
        }
        .container:hover {
            transform: translateY(-5px);
        }
        h2 {
            color: #9c1010;
            text-align: center;
            margin-bottom: 20px;
        }
        p {
            color: #b3b3b3;
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            color: #9c1010;
            font-weight: 500;
            font-size: 16px;
        }
        input[type="email"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px;
            border: 2px solid #4d4d4d;
            border-radius: 8px;
            background-color: #2a2a2a;
            color: #ffffff;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input[type="email"]:focus {
            outline: none;
            border-color: #9c1010;
            box-shadow: 0 0 5px rgba(156, 152, 152, 0.3);
        }
        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, #9c1010, #570808);
            color: #7d7777;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        button[type="submit"]:hover {
            background: linear-gradient(45deg, #570808, #9c1010);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
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
            color: #9c1010;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .back-link a:hover {
            color: #570808;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reset Password</h2>
        <p>Enter your email to receive a verification code.</p>
        <form action="forgotPassword" method="POST">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <button type="submit">Send OTP</button>
        </form>
        <p class="error-message ${requestScope.error != null ? 'show' : ''}">${requestScope.error}</p>
        <div class="back-link">
            <a href="login.jsp">Back to Login</a>
        </div>
    </div>
</body>
</html>