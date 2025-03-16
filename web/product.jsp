<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>
<c:set var="productList" value="${requestScope.product}"/>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Danh Sách Sản Phẩm | Perfume Store</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .navbar {
                padding: 0.5rem 1rem;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
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

            html, body {
                height: 100%;

            }

            body {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .container {
                flex-grow: 1;
                width: 70%;
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
                                <!-- For "All", don't specify a category parameter or use a special value -->
                                <li><a class="dropdown-item" href="product">All</a></li>
                                <li><a class="dropdown-item" href="product?category=Kid">Kid</a></li>
                                <li><a class="dropdown-item" href="product?category=Men">Man</a></li>
                                <li><a class="dropdown-item" href="product?category=Women">Woman</a></li>
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

        <div class="container">
            <div class="row">
                <c:forEach var="product" items="${productList}">
                    <div class="col-md-4 mb-4 d-flex align-items-stretch">
                        <div class="card w-100">
                            <img src="${product.image}" class="card-img-top img-fluid" alt="${product.name}" style="height:350px; object-fit:cover;">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text flex-grow-1">${product.description}</p>
                                <p class="card-text"><strong>Giá: </strong>${product.price} VNĐ</p>
                                <c:if test="${isLoggedIn}">
                                    <div class="d-flex justify-content-between gap-2 mt-auto">
                                        <form method="POST" action="buyNow.jsp" class="flex-fill">
                                            <input type="hidden" name="productId" value="${product.id}">
                                            <button type="submit" class="btn btn-success w-100">Mua hàng</button>
                                        </form>
                                        <form method="POST" action="home.jsp" class="flex-fill">
                                            <input type="hidden" name="productId" value="${product.id}">
                                            <button type="submit" class="btn btn-primary w-100">Thêm vào giỏ hàng</button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty productList}">
                    <div class="col-12 text-center">
                        <p>Không có sản phẩm nào.</p>
                    </div>
                </c:if>
            </div>
        </div>

        <footer class="bg-dark text-white text-center py-3">
            <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>