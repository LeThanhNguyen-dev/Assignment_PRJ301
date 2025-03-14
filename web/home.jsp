<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Customer" %>
<%@page import="model.Product" %>
<%@page import="dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
    // Kiểm tra đăng nhập
    Customer customer = (Customer) session.getAttribute("session_Login");
    boolean isLoggedIn = (customer != null);

    // Lấy danh sách sản phẩm
    ProductDAO productDAO = new ProductDAO();
    List<Product> productList = productDAO.listAllProducts();

    // Giỏ hàng (HashMap lưu productId và quantity)
    Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
        session.setAttribute("cart", cart);
    }

    // Xử lý thêm sản phẩm vào giỏ hàng
    String productId = request.getParameter("productId");
    if (productId != null) {
        cart.put(productId, cart.getOrDefault(productId, 0) + 1);
        session.setAttribute("cartSize", cart.values().stream().mapToInt(Integer::intValue).sum());
    }
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
    margin: 1rem auto; /* Cách trên dưới 2rem, giữa 2 bên auto */
    padding: 1rem 0; /* Thêm padding để tạo khoảng trống bên trong */
}

.carousel-inner {
    display: flex;
    align-items: center; /* Căn giữa hình ảnh theo chiều dọc */
}

.carousel-item img {
    max-width: 100%;
    height: 550px; /* Giảm chiều cao xuống 300px */
    object-fit: cover; /* Đảm bảo ảnh giữ tỉ lệ và lấp đầy khung */
    width: 100%;
    border-radius: 8px; /* Bo góc nhẹ cho đẹp */
}



        </style>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="home">Perfume Store</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#products">Products</a></li>
                        <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                        <% if (isLoggedIn) { %>
                            <li class="nav-item"><span class="nav-link text-warning">Hello, <%= customer.getName() %>!</span></li>
                            <li class="nav-item">
                                <a class="nav-link position-relative" href="cart.jsp">
                                    <i class="fas fa-shopping-cart"></i> Cart
                                    <span class="cart-badge"><%= session.getAttribute("cartSize") != null ? session.getAttribute("cartSize") : 0 %></span>
                                </a>
                            </li>
                            <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                        <% } else { %>
                            <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Slider -->
        <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active img_banner">
                    <img src="img/476498250_1622121185087076_4096243358621469653_n.png" class="d-block w-100" alt="Banner 1">
                </div>
                <div class="carousel-item img_banner">
                    <img src="img/Blue-And-White-Modern-New-Product-Facebook-Ad-1024x536.png" class="d-block w-100" alt="Banner 2">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>

        <!-- Product List -->
        <div class="container mt-5">
            <h3 class="text-center mb-4">Danh sách sản phẩm</h3>
            <div class="row">
                <% for (Product product : productList) { %>
                    <div class="col-md-4 mb-4">
                        <div class="card product-card">
                            <img src="<%= product.getImage() %>" class="card-img-top" alt="<%= product.getName() %>">
                            <div class="card-body">
                                <h5 class="card-title"><%= product.getName() %></h5>
                                <p class="card-text"><strong>Giá: </strong><%= product.getPrice() %> VNĐ</p>
                                <% if (isLoggedIn) { %>
                                    <form method="POST" action="home.jsp">
                                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                                        <button type="submit" class="btn btn-primary">Thêm vào giỏ hàng</button>
                                    </form>
                                <% } else { %>
                                    <button class="btn btn-secondary" onclick="alert('Vui lòng đăng nhập trước khi thêm vào giỏ hàng.')">Thêm vào giỏ hàng</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                <% } %>
                <% if (productList.isEmpty()) { %>
                    <div class="col-12 text-center"><p>Không có sản phẩm nào.</p></div>
                <% } %>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
