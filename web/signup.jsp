<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Register</title>
        <style>
            body {
                background: linear-gradient(135deg, #1a1a1a 0%, #333333 100%);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .container {
                width: 450px;
                margin: 50px auto;
                padding: 30px;
                border: 1px solid #ffd700;
                border-radius: 15px;
                background-color: #1f1f1f;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
                transition: transform 0.3s ease;
            }

            .container:hover {
                transform: translateY(-5px);
            }

            h2 {
                text-align: center;
                color: #ffd700;
                margin-bottom: 25px;
                font-weight: 600;
            }

            .form-group {
                margin-bottom: 20px;
                position: relative;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #ffd700;
                font-size: 14px;
                font-weight: 500;
            }

            input {
                width: 100%;
                padding: 12px;
                box-sizing: border-box;
                border: 2px solid #4d4d4d;
                border-radius: 8px;
                font-size: 14px;
                background-color: #2a2a2a;
                color: #ffffff;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            input:focus {
                outline: none;
                border-color: #ffd700;
                box-shadow: 0 0 5px rgba(255, 215, 0, 0.3);
            }

            .error {
                color: #ff4d4d;
                font-size: 12px;
                position: absolute;
                bottom: -18px;
                left: 0;
            }

            button {
                background: linear-gradient(45deg, #ffd700, #ccac00);
                color: #1a1a1a;
                padding: 12px 20px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            button:hover {
                background: linear-gradient(45deg, #ccac00, #ffd700);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
            }

            #sendOTP {
                width: auto;
                padding: 12px 20px; /* Tăng kích thước nút để cân đối với input */
                background: linear-gradient(45deg, #ffd700, #ccac00);
                position: absolute;
                right: 0;
                top: 32px;
                font-size: 14px;
            }

            #sendOTP:hover {
                background: linear-gradient(45deg, #ccac00, #ffd700);
            }

            #sendOTP:disabled {
                background: #4d4d4d;
                color: #999999;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            .text-danger {
                color: #ff4d4d;
                text-align: center;
                margin-top: 15px;
            }

            .text-success {
                color: #ffd700;
                text-align: center;
                margin-top: 15px;
            }

            .mt-3 {
                margin-top: 20px;
                text-align: center;
                color: #b3b3b3;
            }

            .mt-3 a {
                color: #ffd700;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .mt-3 a:hover {
                color: #ccac00;
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Form Đăng Ký Khách Hàng</h2>
            <form action="register" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="name">Họ và tên:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại:</label>
                    <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required>
                    <span class="error" id="phoneError"></span>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                    <button type="button" id="sendOTP" disabled>Xác thực</button>
                </div>
                <div class="form-group">
                    <label for="otp">Mã OTP:</label>
                    <input type="text" id="otp" name="otp" required>
                </div>
                <div class="form-group">
                    <label for="address">Địa chỉ:</label>
                    <input type="text" id="address" name="address" required>
                </div>
                <button type="submit">Đăng ký</button>
            </form>
            <p class="text-danger">${requestScope.error}</p>
            <p class="text-success">${requestScope.message}</p>
            <p class="mt-3 text-center">
                Already have an account? <a href="login.jsp">Login</a>
            </p>
        </div>

        <!-- Script giữ nguyên -->
        <script>
            document.getElementById('email').addEventListener('input', function () {
                var email = this.value;
                var sendOTPBtn = document.getElementById('sendOTP');
                if (email && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    sendOTPBtn.disabled = false;
                } else {
                    sendOTPBtn.disabled = true;
                }
            });

            document.getElementById('sendOTP').addEventListener('click', function () {
                console.log("Time send mail " +new Date().getTime());
                var email = document.getElementById('email').value;
                var username = document.getElementById('username').value;
                fetch('sendOTP', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'email=' + encodeURIComponent(email) + '&username=' + encodeURIComponent(username)
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.status === 'success') {
                                alert(data.message);
                            } else {
                                alert(data.message);
                            }
                        })
                        .catch(error => {
                            alert('Lỗi khi gửi OTP. Vui lòng thử lại.');
                        });
            });

            function validateForm() {
                let phone = document.getElementById("phone").value;
                let phoneError = document.getElementById("phoneError");
                let phonePattern = /^[0-9]{10}$/;

                if (!phonePattern.test(phone)) {
                    phoneError.textContent = "Số điện thoại phải là 10 chữ số!";
                    return false;
                }
                phoneError.textContent = "";
                return true;
            }
        </script>
    </body>
</html>