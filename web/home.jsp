<%-- 
    Document   : home.jsp
    Created on : Mar 8, 2025, 11:08:53 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Customer" %>
<%
    // Lấy thông tin khách hàng từ session
    Customer customer = (Customer) session.getAttribute("session_Login");
    boolean isLoggedIn = (customer != null);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Shop Nước Hoa</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .product-card:hover {
                transform: scale(1.05);
                transition: 0.3s;
            }
            .footer {
                margin-top: 700px;
                padding-top: 20px;
                position: relative;
                bottom: 0;
                width: 100%;
            }

            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            footer {
                margin-top: auto;
            }

            .img_banner img{
                width: 90%;
                height: 500px;
                margin: 10px -5% 10px 5%;
            }

            .navbar-nav {
                margin: 0 auto;
                display: flex;
                gap: 20px;
            }
            .navbar-brand {
                font-size: 1.5rem;
                font-weight: bold;
            }

        </style>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="home.jsp">Perfume Store</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#products">Product</a></li>
                        <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>

                        <% if (isLoggedIn) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="logout">Logout</a> 
                        </li>
                        <li class="nav-item">
                            <span class="nav-link text-warning">Hello, <%= customer.getName()%>!</span>
                        </li>
                        <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                        <% } %>

                        <!-- Biểu tượng giỏ hàng -->
                        <li class="nav-item">
                            <a class="nav-link" href="cart.jsp">
                                <i class="fas fa-shopping-cart"></i> Cart
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>


        <!-- Slider -->
        <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active img_banner">
                    <img src="img/476498250_1622121185087076_4096243358621469653_n.png"  alt="Nước hoa 1"/>
                </div>
                <div class="carousel-item img_banner">
                    <img src="img/Blue-And-White-Modern-New-Product-Facebook-Ad-1024x536.png"  alt="Nước hoa 2"/>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>

        <!-- Danh sách sản phẩm -->
        <div class="container my-5" id="products">
            <h2 class="text-center mb-4">Sản Phẩm Nổi Bật</h2>
            <div class="row">
                <c:forEach var="product" items="${productList}">
                    <div class="col-md-4">
                        <div class="card product-card">
                            <img src="${product.image}" class="card-img-top" alt="${product.name}">
                            <div class="card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text">${product.description}</p>
                                <h6 class="text-danger">${product.price} VNĐ</h6>
                                <a href="#" class="btn btn-primary">Mua ngay</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Modal Đăng Nhập -->
        <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="loginModalLabel">Đăng Nhập</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="loginServlet" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên đăng nhập</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Mật khẩu</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Đăng Nhập</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-dark text-white text-center py-3 footer">
            <p>&copy; 2025 Perfume Store. Copyright nhung chu be dan.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
