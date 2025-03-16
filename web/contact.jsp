<%-- 
    Document   : contact
    Created on : Mar 12, 2025, 4:01:50 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Customer" %>
<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>

<c:set var="productList" value="${requestScope.productList}"/>
<c:set var="cart" value="${sessionScope.cart}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liên Hệ | Perfume Store</title>
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
           

            .containers {
                width: 80%;
                margin: 20px auto;
                padding: 20px;
                background: white;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #333;
            }

            .contact-info {
                text-align: center;
                margin-bottom: 20px;
            }

            .contact-form {
                max-width: 600px;
                margin: 0 auto;
            }

            .contact-form label {
                display: block;
                margin: 10px 0 5px;
            }

            .contact-form input, 
            .contact-form textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .contact-form button {
                width: 101%;
                padding: 10px;
                background: #333;
                color: white;
                cursor: pointer;
                border: white solid 2px;
                border-radius: 3px;
            }

            iframe {
                width: 100%;
                height: 300px;
                border: 0;
            }
            .footer {
                margin-top: 100px;
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
        <div class="containers">
            <h2>Liên Hệ</h2>
            <div class="contact-info">
                <p><strong>Địa chỉ:</strong> 344 Nguyễn Duy Hiệu, thành phố Hội An</p>
                <p><strong>Điện thoại:</strong> 0796555878</p>
                <p><strong>Email:</strong> nhungchubedan@gmail.com</p>
            </div>

            <div class="contact-form">
                <h3>Gửi Tin Nhắn</h3>
                <form action="sendEmail" method="post">
                    <label for="name">Họ và Tên:</label>
                    <input type="text" id="name" name="name" required>

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>

                    <label for="message">Nội dung:</label>
                    <textarea id="message" name="message" rows="5" required></textarea>

                    <button type="submit">Gửi</button>
                    <p>${requestScope.messageStatus}</p>
                </form>
            </div>

            <h3>Bản Đồ</h3>
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3837.5903579205033!2d108.33225087591964!3d15.87811314452433!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31420dd5cf609957%3A0x5e46b5d87efcfd01!2zMzQ0IE5ndXnhu4VuIER1eSBIaeG7h3UsIEPhuqltIENow6J1LCBI4buZaSBBbiwgUXXhuqNuZyBOYW1sIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1741750390698!5m2!1svi!2s" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
                <!-- Footer -->
        <footer class="bg-dark text-white text-center py-3 footer">
            <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>