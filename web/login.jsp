<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
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

        .login-container {
            display: flex;
            width: 900px;
            height: 500px;
            background-color: #1f1f1f;
            border: 1px solid #9c1010;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-5px);
        }

        .login {
            width: 50%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login label {
            margin-bottom: 10px;
            font-weight: 500;
            font-size: 16px;
            color: #9c1010;
        }

        .login input[type="text"],
        .login input[type="password"] {
            padding: 12px;
            margin-bottom: 20px;
            width: 100%;
            border: 2px solid #4d4d4d;
            border-radius: 8px;
            background-color: #2a2a2a;
            color: #ffffff;
            font-size: 14px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            box-sizing: border-box;
        }

        .login input[type="text"]:focus,
        .login input[type="password"]:focus {
            outline: none;
            border-color: #9c1010;
            box-shadow: 0 0 5px rgba(156, 152, 152, 0.3);
        }

        .login input[type="submit"] {
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

        .login input[type="submit"]:hover {
            background: linear-gradient(45deg, #570808, #9c1010);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
        }

        .perfume-shop {
            width: 50%;
            background: linear-gradient(45deg, #9c1010, #570808);
            color: #7d7777;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 60px;
            font-weight: 700;
            height: 100%;
            border-radius: 0 15px 15px 0;
            transition: all 0.3s ease;
        }

        .perfume-shop:hover {
            background: linear-gradient(45deg, #570808, #9c1010);
            transform: scale(1.02);
        }

        .sign_up {
            margin-top: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            color: #b3b3b3;
        }

        .sign_up .link {
            text-decoration: none;
            color: #9c1010;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .sign_up .link:hover {
            color: #570808;
            text-decoration: underline;
        }

        .check_box {
            display: inline;
            font-size: 14px;
            margin-left: 5px;
        }

        .password-toggle {
            position: relative;
        }

        .toggle-btn {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #9c1010;
            cursor: pointer;
            font-size: 18px;
            padding: 0;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .toggle-btn:hover {
            color: #570808;
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

        .success-message {
            color: #00cc00;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .forgot-password {
            margin-top: 15px;
            text-align: center;
        }

        .forgot-password a {
            color: #9c1010;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .forgot-password a:hover {
            color: #570808;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="perfume-shop">
            Perfume Shop
        </div>
        <div class="login">
            <form action="login" method="POST" onsubmit="return validateForm()">
                <label>Username:</label>
                <input type="text" name="username" id="username" value="${cookie.CookieUserName.value}" required />

                <label>Password:</label>
                <div class="password-toggle">
                    <input type="password" name="password" id="password" value="${cookie.CookiePassWord.value}" required />
                    <button type="button" class="toggle-btn" onclick="togglePassword()">👁️</button>
                </div>

                <input type="checkbox" name="rememberme" id="rememberme" value="ON" ${cookie.CookieUserName != null ? 'checked' : ''} />
                <label class="check_box" for="rememberme">Remember Me</label>

                <input type="submit" value="Login" />
            </form>
            <div class="sign_up">
                <span>Don't have an account?</span>
                <a class="nav-link link" href="signup.jsp">Sign Up</a>
            </div>
            <div class="forgot-password">
                <a href="forgotPassword.jsp">Forgot your password?</a>
            </div>
            <p class="error-message ${requestScope.error != null ? 'show' : ''}">${requestScope.error}</p>
            <p class="success-message">${param.message}</p>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleBtn = document.querySelector('.toggle-btn');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleBtn.innerHTML = '👁️‍🗨️'; 
            } else {
                passwordInput.type = 'password';
                toggleBtn.innerHTML = '👁️';
            }
        }

        function validateForm() {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const errorMessage = document.querySelector('.error-message');

            if (username.trim() === '' || password.trim() === '') {
                errorMessage.textContent = 'Please fill in all fields!';
                errorMessage.classList.add('show');
                return false;
            }
            return true;
        }

        // Xóa thông báo lỗi khi người dùng bắt đầu nhập
        document.getElementById('username').addEventListener('input', function() {
            document.querySelector('.error-message').classList.remove('show');
        });
        document.getElementById('password').addEventListener('input', function() {
            document.querySelector('.error-message').classList.remove('show');
        });
    </script>
</body>
</html>