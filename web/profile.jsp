<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông Tin Cá Nhân | Perfume Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .profile-info {
            margin-bottom: 20px;
        }
        .profile-info label {
            font-weight: bold;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="home.jsp">Perfume Store</a>
            <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="product.jsp">Products</a></li>
                    <c:if test="${isLoggedIn}">
                        <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                        <li class="nav-item"><a class="nav-link" href="cart.jsp"><i class="fas fa-shopping-cart"></i> Cart</a></li>
                        <li class="nav-item"><a class="nav-link text-warning" href="profile.jsp">${customer.name}</a></li>
                        <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container profile-container">
        <h2 class="text-center mb-4">Thông Tin Cá Nhân</h2>
        <c:if test="${isLoggedIn}">
            <div class="profile-info">
                <label>Tên đăng nhập:</label> ${customer.username}
            </div>
            <div class="profile-info">
                <label>Họ và tên:</label> ${customer.name}
            </div>
            <div class="profile-info">
                <label>Số điện thoại:</label> ${customer.phone}
            </div>
            <div class="profile-info">
                <label>Email:</label> ${customer.email}
            </div>
            <div class="profile-info">
                <label>Địa chỉ:</label> ${customer.address}
            </div>
            <div class="text-center mt-4">
                <a href="editProfile.jsp" class="btn btn-warning">Chỉnh sửa thông tin</a>
                <a href="home.jsp" class="btn btn-primary">Quay lại</a>
            </div>
            <p class="text-success mt-3">${requestScope.message}</p>
        </c:if>
        <c:if test="${!isLoggedIn}">
            <p class="text-center text-danger">Vui lòng đăng nhập để xem thông tin cá nhân!</p>
            <div class="text-center">
                <a href="login.jsp" class="btn btn-primary">Đăng nhập</a>
            </div>
        </c:if>
    </div>

    <footer class="bg-dark text-white text-center py-3">
        <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>