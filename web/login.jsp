<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
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
            padding-top: 80px; 
        }

        .login-container {
            display: flex;
            width: 900px;
            height: 500px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
        }

        .login {
            width: 50%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #ffffff;
        }

        .login label {
            margin-bottom: 10px;
            font-weight: 500;
            font-size: 16px;
            color: #333;
        }

        .login input[type="text"],
        .login input[type="password"] {
            padding: 12px;
            margin-bottom: 20px;
            width: 100%;
            border: 2px solid #ccc;
            border-radius: 8px;
            background-color: #f5f5f5;
            color: #333;
            font-size: 14px;
            transition: all 0.3s ease;
            box-sizing: border-box;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .login input[type="text"]:focus,
        .login input[type="password"]:focus {
            outline: none;
            border-color: #d4af37; /* Vàng nhạt */
            box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
        }

        .login input[type="submit"] {
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

        .login input[type="submit"]:hover {
            background: linear-gradient(45deg, #c0a062, #d4af37);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
        }

        .perfume-shop {
            width: 50%;
            background: linear-gradient(45deg, #d4af37, #c0a062);
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 60px;
            font-weight: 700;
            padding: 0px 30px;
            height: 100%;
            border-radius: 0 15px 15px 0;
            transition: all 0.3s ease;
        }

        .perfume-shop:hover {
            background: linear-gradient(45deg, #c0a062, #d4af37);
            transform: scale(1.02);
        }

        .sign_up {
            margin-top: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            color: #666;
        }

        .sign_up .link {
            text-decoration: none;
            color: #d4af37;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .sign_up .link:hover {
            color: #c0a062;
            text-decoration: underline;
        }

        .check_box {
            display: inline;
            font-size: 14px;
            margin-left: 5px;
            color: #333;
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
            color: #666;
            cursor: pointer;
            font-size: 18px;
            padding: 0;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: color 0.3s ease;
        }

        .toggle-btn:hover {
            color: #d4af37;
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

        .success-message {
            color: #28a745;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .forgot-password {
            margin-top: 15px;
            text-align: center;
        }

        .forgot-password a {
            color: #d4af37;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .forgot-password a:hover {
            color: #c0a062;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="perfume-shop">
            <i class="fas fa-spray-can"></i> Perfume Shop
        </div>
        <div class="login">
            <form action="login" method="POST" onsubmit="return validateForm()">
                <label>Username:</label>
                <input type="text" name="username" id="username" value="${cookie.CookieUserName.value}" required />

                <label>Password:</label>
                <div class="password-toggle">
                    <input type="password" name="password" id="password" value="${cookie.CookiePassWord.value}" required />
                    <button type="button" class="toggle-btn" onclick="togglePassword()"><i class="fas fa-eye"></i></button>
                </div>

                <input type="checkbox" name="rememberme" id="rememberme" value="ON" ${cookie.CookieUserName != null ? 'checked' : ''} />
                <label class="check_box" for="rememberme">Remember Me</label>

                <input type="submit" value="Login" />
            </form>
            <div class="sign_up">
                <span>Don't have an account?</span>
                <a class="nav-link link" href="register">Sign Up</a>
            </div>
            <div class="forgot-password">
                <a href="forgotPassword">Forgot your password?</a>
            </div>
            <p class="error-message ${requestScope.error != null ? 'show' : ''}">${requestScope.error}</p>
            <p class="success-message">${param.message}</p>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.querySelector('.toggle-btn i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
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

        document.getElementById('username').addEventListener('input', function() {
            document.querySelector('.error-message').classList.remove('show');
        });
        document.getElementById('password').addEventListener('input', function() {
            document.querySelector('.error-message').classList.remove('show');
        });
    </script>
</body>
</html>