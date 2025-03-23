<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="header.jsp" %>

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
        body {
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%); 
            color: #333; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .product-card {
            transition: transform 0.3s;
            background: #ffffff;
            border: 2px solid #ccc; 
        }

        .product-card:hover {
            transform: scale(1.05);
            border-color: #d4af37; 
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .card-img-top {
            height: 400px; 
            object-fit: cover;
        }

        .card-title {
            color: #d4af37;
        }

        .card-text {
            color: #666; 
        }

        .card-text strong {
            color: #333; 
        }

           .btn-success, .btn-primary {
    width: 50%; /* Chia đều 50% mỗi nút trong hàng */
    padding: 12px 10px; /* Padding đồng nhất */
    height: 48px; /* Chiều cao cố định */
    font-size: 15px; /* Cỡ chữ đồng đều */
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center; /* Căn giữa icon và text */
    text-align: center;
    border-radius: 8px;
    transition: transform 0.2s, box-shadow 0.2s;
    box-sizing: border-box; /* Đảm bảo padding không làm vượt kích thước */
}

.btn-success {
    background: linear-gradient(45deg, #d4af37, #c0a062);
    color: #fff;
    border: none;
}

.btn-success:hover {
    background: linear-gradient(45deg, #c0a062, #d4af37);
    transform: scale(1.05);
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
}

.btn-primary {
    background: linear-gradient(45deg, #e0e0e0, #c0c0c0);
    color: #333;
    border: none;
}

.btn-primary:hover {
    background: linear-gradient(45deg, #c0c0c0, #e0e0e0);
    transform: scale(1.05);
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
}

.btn i {
    margin-right: 5px; /* Khoảng cách giữa icon và chữ */
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
            background: linear-gradient(90deg, #e0e0e0, #c0c0c0); 
            color: #333;
            text-align: center;
            padding: 20px 0;
            margin-top: 10px; 
            position: relative;
            bottom: 0;
            width: 100%;
            box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.1); 
        }
    </style>
</head>


<body>
    
    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="img/banner_welcome.png" class="d-block w-100" alt="Banner 1">
            </div>
            <div class="carousel-item">
                <img src="img/Blue-And-White-Modern-New-Product-Facebook-Ad-1024x536.png" class="d-block w-100" alt="Banner 3">
            </div>
            <div class="carousel-item">
                <img src="img/476498250_1622121185087076_4096243358621469653_n.png" class="d-block w-100" alt="Banner 2">
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
        <h2 class="text-center mb-4">Danh Sách Sản Phẩm</h2>
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
                                <div class="d-flex justify-content-between gap-2 mt-auto">
                                    <!-- Nút BUY gửi POST request đến AddToCartServlet -->
                                    <form action="AddToCartServlet" method="post" class="w-100">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <input type="hidden" name="redirect" value="true">
                                        <button type="submit" class="btn btn-success w-100">BUY</button>
                                    </form>
                                    <button class="btn btn-primary w-100 add-to-cart" data-id="${product.id}">
                                        <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                                    </button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <footer class="footer">
        <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".add-to-cart").forEach(button => {
            button.addEventListener("click", function () {
                let productId = this.getAttribute("data-id");
                addToCart(productId);
            });
        });
    });

    function addToCart(productId) {
        fetch('AddToCartServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({'productId': productId})
        })
            .then(response => response.json())
            .then(data => {
                if (data.cartItemCount !== undefined) {
                    document.querySelector('.new-cart-badge').textContent = data.cartItemCount;
                } else {
                    alert("Có lỗi xảy ra khi thêm vào giỏ hàng!");
                }
            })
            .catch(error => console.error('Lỗi:', error));
    }
</script>
</body>
</html>