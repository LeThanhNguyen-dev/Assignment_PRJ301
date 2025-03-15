<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>

<c:set var="productList" value="${requestScope.productList}"/>
<c:set var="cart" value="${sessionScope.cart}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shop Nước Hoa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
            /* Navbar Styles */
            .navbar {
                padding: 1rem 0;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .navbar-brand {
                font-size: 1.8rem;
                font-weight: 700;
                color: #fff !important;
            }
            .navbar-nav {
                gap: 1.5rem;
                align-items: center;
            }
            .nav-link {
                color: #fff !important;
                font-weight: 500;
            }
            .nav-link:hover {
                color: #ddd !important;
            }
            .cart-badge {
                font-size: 0.8rem;
                position: absolute;
                top: 5px;
                right: 10px;
                background: red;
                color: white;
                padding: 2px 5px;
                border-radius: 50%;
            }
            .product-card {
                transition: transform 0.3s;
            }
            .product-card:hover {
                transform: scale(1.05);
            }
            .card-img-top {
                height: 400px;
                object-fit: cover;
            }
            #carouselExample {
                max-width: 90%;
                margin: 1rem auto; 
                padding: 1rem 0; 
            }

            .carousel-inner {
                display: flex;
                align-items: center; 
            }

            .carousel-item img {
                max-width: 100%;
                height: 550px; 
                object-fit: cover; 
                width: 100%;
                border-radius: 8px; 
            }
            .footer {
                margin-top: 700px;
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
        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="product.jsp">Products</a></li>
                <c:if test="${isLoggedIn}">
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    <li class="nav-item">
                        <a class="nav-link position-relative" href="cart.jsp">
                            <i class="fas fa-shopping-cart"></i> Cart
                            <span class="cart-badge">${sessionScope.cartSize != null ? sessionScope.cartSize : 0}</span>
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

<div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="img/476498250_1622121185087076_4096243358621469653_n.png" class="d-block w-100" alt="Banner 1">
        </div>
        <div class="carousel-item">
            <img src="img/Blue-And-White-Modern-New-Product-Facebook-Ad-1024x536.png" class="d-block w-100" alt="Banner 2">
        </div>
    </div>
    <button class="carousel-control-prev" data-bs-target="#carouselExample" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" data-bs-target="#carouselExample" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>

<div class="container mt-5">
    <h3 class="text-center mb-4">Danh sách sản phẩm</h3>
    <div class="row">
        <c:forEach var="product" items="${productList}">
            <div class="col-md-4 mb-4">
                <div class="card product-card">
                    <img src="${product.image}" class="card-img-top" alt="${product.name}">
                    <div class="card-body">
                        <h5 class="card-title">${product.name}</h5>
                        <p class="card-text"><strong>Giá: </strong><fmt:formatNumber value="${product.price}" type="number"/> VNĐ</p>
                        <c:if test="${isLoggedIn}">
                            <form method="POST" action="home.jsp">
                                <input type="hidden" name="productId" value="${product.id}">
                                <button type="submit" class="btn btn-primary">Thêm vào giỏ hàng</button>
                            </form>
                        </c:if>
                        <c:if test="${!isLoggedIn}">
                            <button class="btn btn-secondary" onclick="alert('Vui lòng đăng nhập trước khi thêm vào giỏ hàng.')">Thêm vào giỏ hàng</button>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty productList}">
            <div class="col-12 text-center"><p>Không có sản phẩm nào.</p></div>
        </c:if>
    </div>
</div>

<footer class="bg-dark text-white text-center py-3">
    <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>