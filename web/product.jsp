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
                font-size: 0.75rem;
                position: absolute;
                top: -5px;
                right: -10px;
                background: #dc3545;
                color: white;
                padding: 2px 6px;
                border-radius: 50%;
                line-height: 1;
                font-weight: 600;
                min-width: 18px;
                text-align: center;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
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

            /* Style cho layout 2 cột */
            .container-fluid {
                padding: 0 15px;
            }
            .sidebar {
                height: 100%;
                padding: 20px;
                background-color: #f8f9fa;
                border-right: 1px solid #dee2e6;
            }
            .filter-section {
                margin-bottom: 20px;
            }
            .filter-section h5 {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 10px;
                color: #343a40;
            }
            .category-buttons, .price-buttons {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }
            .category-buttons .btn, .price-buttons .btn {
                width: 100%;
                text-align: left;
                padding: 10px 15px;
                font-size: 0.95rem;
                border-radius: 5px;
                transition: all 0.3s ease;
            }
            .category-buttons .btn {
                background-color: #fff;
                border: 1px solid #ced4da;
                color: #495057;
            }
            .category-buttons .btn:hover, .category-buttons .btn.active {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }
            .price-buttons .btn {
                background-color: #fff;
                border: 1px solid #ced4da;
                color: #495057;
            }
            .price-buttons .btn:hover, .price-buttons .btn.active {
                background-color: #28a745;
                color: #fff;
                border-color: #28a745;
            }
            .product-list {
                padding: 20px;
            }
            @media (max-width: 768px) {
                .sidebar {
                    padding: 10px;
                }
                .category-buttons, .price-buttons {
                    flex-direction: row;
                    flex-wrap: wrap;
                    justify-content: center;
                }
                .category-buttons .btn, .price-buttons .btn {
                    width: auto;
                    margin: 5px;
                }
            }

            .action-buttons {
                display: flex;
                gap: 10px;
                margin-top: 10px;
            }
            .btn-buy, .btn-cart {
                flex: 1;
                padding: 8px 12px;
                font-size: 0.9rem;
                font-weight: 500;
                border-radius: 5px;
                transition: all 0.3s ease;
                text-align: center;
                min-width: 0;
            }
            .btn-buy {
                background-color: #ff6b6b;
                border: 1px solid #ff6b6b;
                color: #fff;
            }
            .btn-buy:hover {
                background-color: #ff8787;
                border-color: #ff8787;
                color: #fff;
            }
            .btn-cart {
                background-color: #17a2b8;
                border: 1px solid #17a2b8;
                color: #fff;
            }
            .btn-cart:hover {
                background-color: #1cc0d8;
                border-color: #1cc0d8;
                color: #fff;
            }

            /* Other Styles */
            .product-card {
                transition: transform 0.3s;
            }
            .product-card:hover {
                transform: scale(1.05);
            }

            html, body {
                height: 100%;
            }
            body {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .footer {
                margin-top: 20px;
                padding-top: 20px;
                position: relative;
                bottom: 0;
                width: 100%;
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
                    <div class="text-danger mt-2" id="search-error" style="display: none; font-size: 14px;"></div>
                </form>
                <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="home">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="product">Products</a></li>
                            <c:if test="${isLoggedIn}">
                            <li class="nav-item"><a class="nav-link" href="sendEmail">Contact</a></li>
                            <li class="nav-item">
                                <a class="nav-link position-relative" href="cart.jsp">
                                    <i class="fas fa-shopping-cart"></i> Cart
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger cart-badge">
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

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 sidebar">
                    <div class="filter-section">
                        <h5>Danh mục</h5>
                        <div class="category-buttons">
                            <a href="product" class="btn ${empty param.category && empty param.priceRange ? 'active' : ''}">All</a>
                            <a href="product?category=Men" class="btn ${param.category == 'Men' ? 'active' : ''}">Man</a>
                            <a href="product?category=Women" class="btn ${param.category == 'Women' ? 'active' : ''}">Woman</a>
                            <a href="product?category=Kid" class="btn ${param.category == 'Kid' ? 'active' : ''}">Kid</a>
                        </div>
                    </div>
                    <div class="filter-section">
                        <h5>Lọc theo giá</h5>
                        <div class="price-buttons">
                            <a href="product?priceRange=under500k" class="btn ${param.priceRange == 'under500k' ? 'active' : ''}">Dưới 500K</a>
                            <a href="product?priceRange=500k-1m" class="btn ${param.priceRange == '500k-1m' ? 'active' : ''}">500K - 1M</a>
                            <a href="product?priceRange=over1m" class="btn ${param.priceRange == 'over1m' ? 'active' : ''}">Trên 1M</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-9 product-list">
                    <div class="row">
                        <c:forEach var="product" items="${productList}">
                            <div class="col-md-4 mb-4 d-flex align-items-stretch">
                                <div class="card w-100 product-card">
                                    <img src="${product.image}" class="card-img-top img-fluid" alt="${product.name}" style="height:350px; object-fit:cover;">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text flex-grow-1">${product.description}</p>
                                        <p class="card-text"><strong>Giá: </strong>${product.price} VNĐ</p>
                                        <c:if test="${isLoggedIn}">
                                            <div class="action-buttons">
                                                <form method="POST" action="buyProduct" style="flex: 1;">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <button type="submit" class="btn btn-buy">Mua ngay</button>
                                                </form>
                                                <button type="button" class="btn btn-cart add-to-cart-btn" data-product-id="${product.id}">
                                                    Thêm vào giỏ hàng
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty productList}">
                            <div class="col-12 text-center">
                                <p>Không có sản phẩm nào. ${error}</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <footer class="bg-dark text-white text-center py-3">
            <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                $(".add-to-cart-btn").click(function () {
                    let productId = $(this).data("product-id");
                    $.ajax({
                        url: 'AddToCartServlet',
                        type: 'POST',
                        data: {productId: productId},
                        dataType: 'json',
                        success: function (response) {
                            if (response.cartSize !== undefined) {
                                $(".cart-badge").text(response.cartSize);
                                alert("✅ Đã thêm vào giỏ hàng thành công!");
                            } else {
                                alert("Lỗi: không nhận được thông tin giỏ hàng.");
                            }
                        },
                        error: function () {
                            alert("Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng!");
                        }
                    });
                });
            });

            document.addEventListener("DOMContentLoaded", function () {
                document.querySelector(".search-form").addEventListener("submit", function (event) {
                    let queryInput = document.querySelector("input[name='query']");
                    let errorDiv = document.getElementById("search-error");

                    if (!queryInput.value.trim()) {
                        event.preventDefault(); // Ngăn không cho form submit
                        errorDiv.textContent = "Vui lòng nhập từ khóa tìm kiếm!";
                        errorDiv.style.display = "block"; // Hiển thị thông báo lỗi
                    } else {
                        errorDiv.style.display = "none"; // Ẩn thông báo lỗi nếu nhập hợp lệ
                    }
                });
            });

        </script>
    </body>
</html>