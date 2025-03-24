<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="header.jsp" %>

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
            body {
                background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
                color: #333;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                padding-top: 80px; /* Đẩy nội dung xuống để tránh bị header che */
                display: flex;
                flex-direction: column;
            }

            .container-fluid {
                padding: 0 15px;
                flex-grow: 1;
            }

            .sidebar {
                height: 100%;
                padding: 15px;
                background: #ffffff;
                border-right: 2px solid #ccc;
                border-radius: 0 15px 15px 0;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                max-width: 200px; /* Giới hạn bề ngang sidebar */
            }

            .filter-section {
                margin-bottom: 20px;
            }

            .filter-section h5 {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 12px;
                color: #333;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .filter-section h5 i {
                color: #d4af37;
                transition: color 0.3s ease;
            }

            .filter-section h5:hover i {
                color: #c0a062;
            }

            .category-buttons, .price-buttons {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .category-buttons .btn, .price-buttons .btn {
                padding: 8px 10px;
                font-size: 0.9rem;
                border-radius: 8px;
                transition: all 0.3s ease;
                background: #f5f5f5;
                border: 2px solid #ccc;
                color: #333;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .category-buttons .btn:hover, .category-buttons .btn.active,
            .price-buttons .btn:hover, .price-buttons .btn.active {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                color: #333;
                border-color: #d4af37;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
            }

            .category-buttons .btn i, .price-buttons .btn i {
                font-size: 0.9rem;
                color: #666;
                transition: color 0.3s ease;
            }

            .category-buttons .btn:hover i, .category-buttons .btn.active i,
            .price-buttons .btn:hover i, .price-buttons .btn.active i {
                color: #333;
            }

            .product-list {
                padding: 20px;
            }

            .product-card {
                background: #ffffff;
                border: 2px solid #ccc;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .product-card:hover {
                transform: scale(1.05);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
                border-color: #d4af37;
            }

            .product-card img {
                border-radius: 8px 8px 0 0;
                height: 200px; /* Giảm chiều cao ảnh để cân bằng layout */
                object-fit: cover;
            }

            .card-body {
                padding: 15px;
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }

            .card-title {
                color: #d4af37;
                font-weight: 500;
                margin-bottom: 10px;
                font-size: 1.1rem;
            }

            .card-text {
                color: #666;
                font-size: 0.9rem;
            }

            .card-text strong {
                color: #333;
            }

            .action-buttons {
                display: flex;
                justify-content: space-between; /* Để hai nút cách đều nhau */
                gap: 10px; /* Khoảng cách giữa hai nút */
                margin-top: auto;
                padding: 10px 0;
            }

            .btn-buy, .btn-cart {
                width: 50%; /* Đảm bảo cả hai nút có cùng kích thước */
                padding: 10px;
                font-size: 0.9rem;
                font-weight: 500;
                border-radius: 8px;
                transition: all 0.3s ease;
                text-align: center;
                border: none;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
                height: 40px; /* Đảm bảo cùng chiều cao */
            }

            .btn-buy {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                color: #333;
            }

            .btn-buy:hover {
                background: linear-gradient(45deg, #c0a062, #d4af37);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            }

            .btn-cart {
                background: linear-gradient(45deg, #e0e0e0, #c0c0c0);
                color: #333;
            }

            .btn-cart:hover {
                background: linear-gradient(45deg, #c0c0c0, #e0e0e0);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            }


            .btn-cart {
                background: linear-gradient(45deg, #e0e0e0, #c0c0c0);
                color: #333;
            }

            .btn-cart:hover {
                background: linear-gradient(45deg, #c0c0c0, #e0e0e0);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
                color: #333;
            }

            .btn-buy i, .btn-cart i {
                font-size: 0.9rem;
            }

            .footer {
                background: linear-gradient(90deg, #e0e0e0, #c0c0c0);
                color: #333;
                text-align: center;
                padding: 20px 0;
                margin-top: 40px;
                width: 100%;
                box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.1);
            }
            .image-container {
                position: relative;
                overflow: hidden;
            }

            .card-img-top {
                transition: opacity 0.3s ease;
                width: 100%;
                height: auto;
            }

            .overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                opacity: 0;
                transition: opacity 0.3s ease;
                display: flex;
                align-items: flex-end; /* Đẩy button xuống dưới */
                padding-bottom: 0px; /* Tùy chỉnh khoảng cách nếu cần */
            }
            .image-container:hover .overlay {
                opacity: 1;
            }

            .overlay .view-detail {
                color: white;
                font-size: 18px;
                text-decoration: none;
                padding: 10px 0; /* Chỉ giữ padding trên/dưới, bỏ padding trái/phải */
                background-color: #d4af37;
                border-radius: 0px;
                opacity: 1;
                width: 100%; /* Chiều dài bằng ảnh */
                text-align: center; /* Canh giữa chữ trong button */
                box-sizing: border-box; /* Đảm bảo padding không làm vượt kích thước */
                opacity: 0.7;
                transition: opacity 0.3s ease;
                z-index: 1;
            }

            .image-container:hover .card-img-top {
                opacity: 0.3; /* Ảnh mờ khi hover */
            }

            .image-container:hover .overlay {
                opacity: 1; /* Hiển thị overlay khi hover */
            }


            @media (max-width: 768px) {
                .sidebar {
                    padding: 10px;
                    border-radius: 15px;
                    margin-bottom: 20px;
                    max-width: 100%; /* Full width trên mobile */
                }
                .category-buttons .btn, .price-buttons .btn {
                    padding: 6px 8px;
                    font-size: 0.85rem;
                }
                .product-card img {
                    height: 150px; /* Giảm chiều cao ảnh trên mobile */
                }
                .btn-buy, .btn-cart {
                    padding: 8px 12px; /* Chuẩn hóa padding trên mobile */
                    font-size: 0.85rem;
                    height: 36px; /* Đặt chiều cao cố định trên mobile */
                    max-width: 130px; /* Giảm chiều rộng tối đa trên mobile */
                }
                .action-buttons {
                    gap: 10px; /* Giảm khoảng cách trên mobile */
                }

            }
        </style>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 sidebar"> <!-- Giữ bề ngang hẹp -->
                    <div class="filter-section">
                        <h5><i class="fas fa-filter"></i> Danh mục</h5>
                        <div class="category-buttons">
                            <a href="product" class="btn ${empty param.category && empty param.priceRange ? 'active' : ''}">
                                <i class="fas fa-globe"></i> All
                            </a>
                            <a href="product?category=Men" class="btn ${param.category == 'Men' ? 'active' : ''}">
                                <i class="fas fa-male"></i> Man
                            </a>
                            <a href="product?category=Women" class="btn ${param.category == 'Women' ? 'active' : ''}">
                                <i class="fas fa-female"></i> Woman
                            </a>
                            <a href="product?category=Kid" class="btn ${param.category == 'Kid' ? 'active' : ''}">
                                <i class="fas fa-child"></i> Kid
                            </a>
                        </div>
                    </div>
                    <div class="filter-section">
                        <h5><i class="fas fa-money-bill-wave"></i> Lọc theo giá</h5>
                        <div class="price-buttons">
                            <a href="product?priceRange=under500k" class="btn ${param.priceRange == 'under500k' ? 'active' : ''}">
                                <i class="fas fa-coins"></i> Dưới 500K
                            </a>
                            <a href="product?priceRange=500k-1m" class="btn ${param.priceRange == '500k-1m' ? 'active' : ''}">
                                <i class="fas fa-wallet"></i> 500K - 1M
                            </a>
                            <a href="product?priceRange=over1m" class="btn ${param.priceRange == 'over1m' ? 'active' : ''}">
                                <i class="fas fa-money-check-alt"></i> Trên 1M
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-10 product-list">
                    <div class="row">
                        <c:forEach var="product" items="${productList}">
                            <div class="col-md-3 mb-4 d-flex align-items-stretch">
                                <div class="card w-100 product-card">
                                    <div class="image-container">
                                        <img src="${product.image}" class="card-img-top img-fluid" alt="${product.name}">
                                        <div class="overlay">
                                            <a href="#" class="view-detail" data-product-id="${product.id}">Xem chi tiết</a>
                                        </div>
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text flex-grow-1">${product.description}</p>
                                        <p class="card-text"><strong>Giá: </strong>$<fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2" /></p>
                                        <c:if test="${isLoggedIn}">
                                            <div class="action-buttons">
                                                <form method="POST" action="CheckoutServlet" class="w-100">
                                                    <input type="hidden" name="productId" value="${product.id}">
                                                    <input type="hidden" name="isBuyNow" value="true">
                                                    <button type="submit" class="btn btn-buy w-100">
                                                        <i class="fas fa-shopping-bag"></i> Mua ngay
                                                    </button>
                                                </form>
                                                <button type="button" class="btn btn-cart add-to-cart-btn w-100" onClick="addToCart(${product.id}, 1)">
                                                    <i class="fas fa-cart-plus"></i> Thêm vào giỏ
                                                </button>                                        
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty productList}">
                            <div class="col-12 text-center">
                                <p style="color: #666;">Không có sản phẩm nào. ${error}</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer">
            <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
        </footer>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Modal cho Chi Tiết Sản Phẩm -->
        <div class="modal fade" id="productDetailModal" tabindex="-1" aria-labelledby="productDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="max-width: 800px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="productDetailModalLabel">Chi Tiết Sản Phẩm</h5>
                        <!-- Bỏ button Đóng -->
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <img id="modalProductImage" src="" class="img-fluid" alt="Hình ảnh sản phẩm" style="max-height: 400px; object-fit: cover;">
                            </div>
                            <div class="col-md-6">
                                <h5 id="modalProductName"></h5>
                                <p id="modalProductDescription"></p>
                                <p><strong>Giá: </strong><span id="modalProductPrice"></span></p>
                                <p><strong>Thương hiệu: </strong><span id="modalProductBrand"></span></p>
                                <p><strong>Chất liệu: </strong><span id="modalProductMaterial"></span></p>
                                <p><strong>Dung tích: </strong><span id="modalProductVolume"></span> ml</p>
                                <p><strong>Kích thước: </strong><span id="modalProductDimensions"></span></p>
                                <p><strong>Tồn kho: </strong><span id="modalProductStock"></span></p>
                                <!-- Thêm ô chọn số lượng -->
                                <c:if test="${isLoggedIn}">
                                    <div class="mb-3">
                                        <label for="quantityInput" class="form-label"><strong>Số lượng:</strong></label>
                                        <input type="number" id="quantityInput" class="form-control w-50" min="1" value="1">
                                    </div>
                                    <div class="d-flex gap-3">
                                        <form id="buyNowForm" method="POST" action="CheckoutServlet" class="d-inline">
                                            <input type="hidden" name="productId" id="modalProductId">
                                            <input type="hidden" name="quantity" id="modalQuantity">
                                            <input type="hidden" name="isBuyNow" value="true">
                                            <button type="submit" class="btn btn-buy" style="width: 150px;"><i class="fas fa-shopping-bag"></i> Mua ngay</button>
                                        </form>
                                        <button type="button" class="btn btn-cart add-to-cart-btn" id="modalAddToCartBtn" style ="width: 150px;"><i class="fas fa-cart-plus"></i> Thêm vào giỏ</button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
                                                    function addToCart(productId, quantity) {
                                                        fetch('AddToCartServlet?productId=' + productId + '&quantity=' + quantity, {
                                                            method: 'GET'
                                                        })
                                                                .then(response => response.json())
                                                                .then(data => {
                                                                    if (data.status === 'success') {
                                                                        // Cập nhật badge giỏ hàng
                                                                        const cartBadge = document.querySelector('.cart-badge');
                                                                        cartBadge.textContent = data.cartSize; // Giá trị từ server
                                                                        alert(data.message);
                                                                    }
                                                                })
                                                                .catch(error => console.error('Error:', error));
                                                    }
                                                    $(document).ready(function () {
                                                        // Xử lý sự kiện khi nhấn "Xem chi tiết"
                                                        $('.view-detail').click(function (e) {
                                                            e.preventDefault();
                                                            const productId = $(this).data('product-id');

                                                            // Gửi yêu cầu AJAX để lấy chi tiết sản phẩm
                                                            $.ajax({
                                                                url: 'ProductDetailServlet',
                                                                type: 'GET',
                                                                data: {productId: productId},
                                                                dataType: 'json',
                                                                success: function (response) {
                                                                    // Kiểm tra nếu có lỗi
                                                                    if (response.error) {
                                                                        alert(response.error);
                                                                        return;
                                                                    }

                                                                    // Điền dữ liệu từ ProductDetailDTO
                                                                    $('#modalProductImage').attr('src', response.image);
                                                                    $('#modalProductName').text(response.name);
                                                                    $('#modalProductDescription').text(response.description);
                                                                    $('#modalProductPrice').text(Number(response.price).toLocaleString('en-US', {style: 'currency', currency: 'USD'}));
                                                                    $('#modalProductId').val(response.productId);
                                                                    $('#modalProductBrand').text(response.brand || 'Không có thông tin');
                                                                    $('#modalProductMaterial').text(response.material || 'Không có thông tin');
                                                                    $('#modalProductVolume').text(response.volume || 'Không có thông tin');
                                                                    $('#modalProductDimensions').text(response.dimensions || 'Không có thông tin');
                                                                    $('#modalProductStock').text(response.stock || '0');

                                                                    // Hiển thị modal
                                                                    $('#productDetailModal').modal('show');
                                                                },
                                                                error: function () {
                                                                    alert('Có lỗi xảy ra khi lấy chi tiết sản phẩm!');
                                                                }
                                                            });
                                                        });

                                                        // Thêm sự kiện click cho nút "Thêm vào giỏ" trong modal
                                                        $('#modalAddToCartBtn').click(function () {
                                                            const productId = $('#modalProductId').val();
                                                            const quantity = $('#quantityInput').val();

                                                            if (productId) {
                                                                addToCart(productId, quantity); // Gọi hàm addToCart với productId
                                                            } else {
                                                                alert('Không tìm thấy ID sản phẩm!');
                                                            }
                                                        });


                                                    });
                                                    document.getElementById('buyNowForm').addEventListener('submit', function (e) {
                                                        // Lấy giá trị của quantityInput
                                                        var quantityValue = document.getElementById('quantityInput').value;
                                                        // Gán giá trị đó cho modalQuantity
                                                        document.getElementById('modalQuantity').value = quantityValue;
                                                    });
        </script>
    </body>
</html>