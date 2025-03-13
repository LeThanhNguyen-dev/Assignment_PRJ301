<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Register</title>
        <style>
            .container {
                width: 400px;
                margin: 50px auto;
                padding: 20px;
                border: 3px solid black;
                border-radius: 10px;
                background-color: white;
                color: black;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            input {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }
            .error {
                color: red;
                font-size: 12px;
            }
            button {
                background-color: #333333;
                color: gold;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: gold;
                color: #333333;
            }
            #sendOTP:disabled {
                background-color: #000000;
                color: #ffffff;
                cursor: not-allowed;
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
                    <span id="otpStatus" style="display:none; color:blue;">Đang gửi mã OTP...</span>
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

        <script>
            // Kiểm tra email hợp lệ để bật nút "Xác thực"
            document.getElementById('email').addEventListener('input', function () {
                var email = this.value;
                var sendOTPBtn = document.getElementById('sendOTP');
                if (email && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    sendOTPBtn.disabled = false;
                } else {
                    sendOTPBtn.disabled = true;
                }
            });

            // Gửi yêu cầu OTP qua AJAX
            document.getElementById('sendOTP').addEventListener('click', function () {
                var email = document.getElementById('email').value;
                var username = document.getElementById('username').value;

                var otpStatus = document.getElementById('otpStatus');
                otpStatus.style.display = 'inline';

                this.disabled = true;

                fetch('sendOTP', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'email=' + encodeURIComponent(email) + '&username=' + encodeURIComponent(username)
                })
                        .then(response => response.json())
                        .then(data => {
                            otpStatus.style.display = 'none';
                            this.disabled = false;

                            if (data.status === 'success') {
                                alert(data.message);
                            } else {
                                alert(data.message);
                            }
                        })
                        .catch(error => {
                            otpStatus.style.display = 'none';
                            this.disabled = false;
                            alert('Lỗi khi gửi OTP. Vui lòng thử lại.');
                        });
            });

            // Kiểm tra số điện thoại
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