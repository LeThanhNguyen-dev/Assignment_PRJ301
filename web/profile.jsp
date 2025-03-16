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
        .navbar {
            padding: 0.5rem 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff !important;
            margin-right: 1rem;
        }
        .navbar-nav {
            gap: 0.8rem;
            align-items: center;
        }
        .nav-link {
            color: #fff !important;
            font-weight: 500;
            padding: 0.5rem 0.8rem !important;
        }
        .nav-link:hover {
            color: #ddd !important;
        }
        .cart-badge {
            font-size: 0.7rem;
            position: absolute;
            top: 2px;
            right: 5px;
            background: red;
            color: white;
            padding: 1px 4px;
            border-radius: 50%;
        }
        .search-form {
            width: 25%;
            margin: 0 1rem;
        }
        .search-form .input-group {
            width: 100%;
        }
        .search-form .form-control {
            font-size: 0.9rem;
            padding: 0.4rem 0.6rem;
        }
        .search-form .btn {
            padding: 0.4rem 0.6rem;
        }
        .dropdown-toggle.nav-link {
            color: #fff !important;
        }
        .dropdown-toggle.nav-link:hover {
            color: #ddd !important;
        }
        .dropdown-menu {
            margin-top: 0;
            border-radius: 0.25rem;
        }
        .dropdown-item:hover {
            background-color: #f8f9fa;
        }
        @media (max-width: 992px) {
            .search-form {
                width: 20%;
            }
            .navbar-brand {
                font-size: 1.3rem;
            }
            .nav-link {
                padding: 0.4rem 0.6rem !important;
            }
        }

        .profile-container {
            max-width: 800px; 
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .profile-info {
            margin-bottom: 15px;
        }
        .profile-info label {
            font-weight: bold;
            margin-right: 10px;
            min-width: 120px; 
            display: inline-block;
        }
        .order-history {
            margin-top: 40px;
        }
        .order-history h5 {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: #343a40;
        }
        .table {
            font-size: 0.95rem;
        }
        .table th, .table td {
            vertical-align: middle;
        }

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .container {
            flex-grow: 1;
        }
        .footer {
            margin-top: 20px;
            padding-top: 20px;
            position: relative;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="home">Perfume Store</a>
            <form class="search-form" method="GET" action="search">
                <div class="input-group">
                    <input type="text" class="form-control" name="query" placeholder="Tìm kiếm..." aria-label="Search">
                    <button class="btn btn-outline-light" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
            <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="home">Home</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="productsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Products
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="productsDropdown">
                            <li><a class="dropdown-item" href="product.jsp">All</a></li>
                            <li><a class="dropdown-item" href="product.jsp?category=kid">Kid</a></li>
                            <li><a class="dropdown-item" href="product.jsp?category=man">Man</a></li>
                            <li><a class="dropdown-item" href="product.jsp?category=woman">Woman</a></li>
                        </ul>
                    </li>
                    <c:if test="${isLoggedIn}">
                        <li class="nav-item"><a class="nav-link" href="sendEmail">Contact</a></li>
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="cart.jsp">
                                <i class="fas fa-shopping-cart"></i> Cart
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${sessionScope.cartSize != null ? sessionScope.cartSize : 0}
                                </span>
                            </a>
                        </li>
                        <li class="nav-item"><a class="nav-link text-warning" href="profile.jsp">${customer.name}</a></li>
                        <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                    </c:if>
                    <c:if test="${!isLoggedIn}">
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container profile-container">
        <h2 class="text-center mb-4">Thông Tin Cá Nhân</h2>
        <c:if test="${isLoggedIn}">
            <!-- Thông tin cá nhân -->
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
                <a href="home" class="btn btn-primary">Quay lại</a>
            </div>
            <p class="text-success mt-3">${requestScope.message}</p>

            <!-- Lịch sử đơn hàng -->
            <div class="order-history">
                <h5>Lịch Sử Đơn Hàng</h5>
                <c:choose>
                    <c:when test="${not empty requestScope.orderList}">
                        <table class="table table-bordered table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã đơn hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${requestScope.orderList}">
                                    <tr>
                                        <td>${order.id}</td>
                                        <td>${order.orderDate}</td>
                                        <td>${order.total} VNĐ</td>
                                        <td>${order.status}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center">Bạn chưa có đơn hàng nào.</p>
                    </c:otherwise>
                </c:choose>
            </div>
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