<%-- 
    Document   : login.jsp
    Created on : Mar 9, 2025, 6:55:22 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div>
            <form action="login" method="POST">
                <label>Username </label><input type="text" name="Username" value="" /><br>
                <label>Password </label><input type="password" name="Password" value="" /><br>
                <input type="submit" value="Login" /><br>
                <input type="checkbox" name="Remember me" value="ON" /><label>Remember me</label><br>
            </form>
            <label>Don't have a account? </label><a class="nav-link" href="signup.jsp">Sign Up</a>
        </div>


    </body>
</html>
