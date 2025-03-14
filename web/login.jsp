<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
            }
            .login-container {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 80%;
                height: 60%;
                background-color: white;
                border-radius: 10px;
                box-shadow: 10px 4px 12px rgba(0, 0, 0, 0.1);

            }
            .login {
                width: 50%;
                padding: 20px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
            .login label {
                margin-bottom: 10px;
                font-weight: bold;
                font-size: 20px;
            }
            .login input[type="text"], .login input[type="password"] {
                padding: 8px;
                margin-bottom: 15px;
                width: 95%;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .login input[type="submit"] {
                width: 99.5%;
                padding: 10px;
                background-color: #333333;
                color: gold;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 20px;
                margin-bottom: 10px;
            }
            .login input[type="submit"]:hover {
                background-color: gold;
                color: #333333;
            }
            .perfume-shop {
                width: 50%;
                background-color: #333333;
                color: gold;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 80px;
                font-weight: bold;
                height: 100%;
                border-radius: 10px;
                padding-left: 20px;
            }

            .perfume-shop:hover{
                width: 50%;
                background-color:gold ;
                color: #333333;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 80px;
                font-weight: bold;
                height: 100%;
                border-radius: 10px;
                padding-left: 20px;
            }

            .sign_up{
                margin-top: 10px;
                display: flex;
                gap: 10px;
            }

            .sign_up .link{
                text-decoration: none;
                color: black;
            }


        </style>
    </head>
    <body>
        <div class="login-container">
                <div class="perfume-shop">
                    Perfume Shop
                </div>


        <div class="login">
            <form action="login" method="POST">
                <label>Username: </label>
                <input type="text" name="username" value="" />

                <label>Password: </label>
                <input type="password" name="password" value="" />

                <input type="submit" value="Login" />
                <input type="checkbox" name="rememberme" value="ON" />
                <label class="check_box">Remember Me</label><br>
            </form>
            <div class="sign_up">
                <label>Don't have an account?</label>
                <a class="nav-link link" href="signup.jsp">Sign Up</a>
            </div>
            <p style="color: red">${requestScope.error}</p>
        </div>
    </div>
</body>
</html>
