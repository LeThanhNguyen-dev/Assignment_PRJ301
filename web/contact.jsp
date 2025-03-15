<%-- 
    Document   : contact
    Created on : Mar 12, 2025, 4:01:50 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Customer" %>
<%
    Customer customer = (Customer) session.getAttribute("session_Login");
    boolean isLoggedIn = (customer != null);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liên Hệ | Perfume Store</title>
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
                transition: color 0.3s;
            }

            .navbar-brand:hover {
                color: #ddd !important;
            }

            .navbar-nav {
                gap: 1.5rem;
                align-items: center;
            }

            .nav-link {
                color: #fff !important;
                font-weight: 500;
                padding: 0.5rem 1rem !important;
                transition: all 0.3s ease;
            }

            .nav-link:hover {
                color: #ddd !important;
                transform: translateY(-2px);
            }

            .nav-link i {
                margin-right: 0.3rem;
            }

            .navbar-toggler {
                border: none;
            }

            @media (max-width: 991px) {
                .navbar-nav {
                    padding: 1rem;
                    background: #212529;
                }
            }

            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f8f8;
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
                margin-top: 700px;
                padding-top: 20px;
                position: relative;
                bottom: 0;
                width: 100%;
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

                        <% if (isLoggedIn) { %>
                            <li class="nav-item">
                                <a class="nav-link" href="contact.jsp">Contact</a>
                            </li>
                            <li class="nav-item">
                                <span class="nav-link text-warning">Hello, <%= customer.getName()%>!</span>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="cart.jsp">
                                    <i class="fas fa-shopping-cart"></i> Cart
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="logout">Logout</a> 
                            </li>
                        <% } else { %>
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp">Login</a>
                            </li>
                        <% } %>
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