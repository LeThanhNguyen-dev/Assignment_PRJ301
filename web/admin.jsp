<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang Quản Trị | Perfume Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .admin-container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
        }
        .navbar {
            padding: 1rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
            color: #fff !important;
        }
        .nav-link {
            color: #fff !important;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="home.jsp">Perfume Store</a>
            <div class="navbar-nav ms-auto">
                <c:if test="${isLoggedIn}">
                    <span class="nav-link text-warning">Xin chào, ${customer.name}</span>
                    <a class="nav-link" href="logout">Đăng xuất</a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container admin-container">
        <h2 class="text-center mb-4">Trang Quản Trị</h2>
        
        <c:if test="${isLoggedIn && customer.username eq 'admin'}">
            <ul class="nav nav-tabs mb-4">
                <li class="nav-item">
                    <a class="nav-link active" href="#products">Quản lý sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#customers">Quản lý khách hàng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#orders">Quản lý đơn hàng</a>
                </li>
            </ul>

            <div id="products">
                <h3>Quản lý sản phẩm</h3>
                <a href="addProduct.jsp" class="btn btn-success mb-3">Thêm sản phẩm mới</a>
                <!-- Thêm bảng danh sách sản phẩm ở đây -->
            </div>

            <div id="customers">
                <h3>Quản lý khách hàng</h3>
                <!-- Thêm danh sách khách hàng ở đây -->
            </div>

            <div id="orders">
                <h3>Quản lý đơn hàng</h3>
                <!-- Thêm danh sách đơn hàng ở đây -->
            </div>
        </c:if>

        <c:if test="${isLoggedIn && customer.username ne 'admin'}">
            <div class="alert alert-danger text-center">
                <p>Bạn không có quyền truy cập trang quản trị!</p>
                <a href="home.jsp" class="btn btn-primary">Quay lại trang chủ</a>
            </div>
        </c:if>

        <c:if test="${!isLoggedIn}">
            <div class="alert alert-warning text-center">
                <p>Vui lòng đăng nhập với tài khoản admin để truy cập!</p>
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