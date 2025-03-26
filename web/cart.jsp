<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="header.jsp" %>
<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<fmt:setLocale value="en_US" scope="session"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Shopping Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* Giữ nguyên CSS của bạn */
            body {
                background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
                color: #333;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                padding-top: 80px;
            }
            .cart-container {
                max-width: 1000px;
                margin: 40px auto;
                background: #ffffff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            .cart-container:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
            }
            h2 {
                color: #333;
                font-weight: 700;
                text-align: center;
                margin-bottom: 30px;
                text-transform: uppercase;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }
            h2 i {
                color: #d4af37;
                font-size: 28px;
                transition: color 0.3s ease;
            }
            h2:hover i {
                color: #c0a062;
            }
            .table {
                background: #f5f5f5;
                border: none;
                color: #333;
                border-radius: 8px;
                overflow: hidden;
            }
            .cart-header th {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                color: #333;
                font-weight: 600;
                padding: 15px;
                text-transform: uppercase;
                border: none;
            }
            .cart-item td {
                vertical-align: middle;
                padding: 20px;
                border-bottom: 1px solid #ccc;
            }
            .cart-item img {
                max-width: 100px;
                border-radius: 10px;
                border: 2px solid #d4af37;
                transition: transform 0.3s ease;
            }
            .cart-item img:hover {
                transform: scale(1.1);
            }
            .cart-item td:nth-child(2) {
                color: #d4af37;
                font-weight: 500;
            }
            .quantity-input {
                width: 80px;
                background: #ffffff;
                border: 2px solid #ccc;
                color: #333;
                text-align: center;
                border-radius: 8px;
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }
            .quantity-input:focus {
                border-color: #d4af37;
                outline: none;
                box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
            }
            .btn-danger {
                background: #dc3545;
                border: none;
                font-weight: 500;
                padding: 8px 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }
            .btn-danger:hover {
                background: #c82333;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
            }
            .cart-footer {
                margin-top: 30px;
                text-align: right;
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 15px;
            }
            .cart-footer h4 {
                color: #333;
                font-weight: 600;
                margin: 0;
            }
            .cart-footer h4 span {
                color: #d4af37;
            }
            .cart-footer .btn {
                padding: 12px 25px;
                font-weight: 500;
                border-radius: 8px;
                transition: all 0.3s ease;
            }
            .btn-warning {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                border: none;
                color: #333;
            }
            .btn-warning:hover {
                background: linear-gradient(45deg, #c0a062, #d4af37);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            }
            .btn-primary {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                border: none;
                color: #333;
            }
            .btn-primary:hover {
                background: linear-gradient(45deg, #c0a062, #d4af37);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            }
            .empty-cart {
                text-align: center;
                color: red;
                font-size: 18px;
                margin-top: 20px;
            }

            .error-message {
                color: #dc3545;
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
                transition: opacity 0.3s ease;
            }
        </style>        
    </head>
    <body>
        <div class="container cart-container">
            <h2><i class="fas fa-shopping-cart"></i> Your Shopping Cart</h2>
            <form action="${pageContext.request.contextPath}/updateCart" method="post" id="cartForm">
                <table class="table table-bordered text-center">
                    <thead class="cart-header">
                        <tr>
                            <!-- Thêm cột checkbox "Chọn tất cả" -->
                            <th><input type="checkbox" id="selectAll" checked title="Chọn hoặc bỏ chọn tất cả sản phẩm trong giỏ hàng"> Select All</th>
                            <th>Product</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="entry" items="${cartItems}" varStatus="loop">
                            <c:set var="product" value="${productsInCart[loop.index]}"/>
                            <c:set var="quantity" value="${entry.quantity}"/>
                            <tr class="cart-item">
                                <!-- Thêm checkbox cho từng sản phẩm -->
                                <td><input type="checkbox" name="selectedProducts" value="${product.id}" class="selectItem" checked></td>
                                <td><img src="${product.image}" alt="${product.name}"></td>
                                <td>${product.name}</td>
                                <td class="price" data-price="${product.price}">
                                    $<fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2" />
                                </td>
                                <td>
                                    <!-- Đổi tên input để gửi dạng mảng -->
                                    <input type="hidden" name="productIds" value="${product.id}">
                                    <input type="number" name="quantities" class="form-control quantity-input" 
                                           value="${quantity}" min="1" data-product-id="${product.id}">
                                </td>
                                <td id="total_${product.id}">
                                    $<fmt:formatNumber value="${product.price * quantity}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2" />
                                </td>
                                <td class="action-buttons">
                                    <button class="btn btn-danger btn-sm" onClick="submitDelete(${customer.id}, ${product.id})">Remove</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="cart-footer">
                    <h4>Total: <span id="cartTotal">$0.00</span></h4>
                    <button type="submit" name="action" value="continue" class="btn btn-warning btn-lg">Continue Shopping</button>
                    <!-- Thêm id cho nút checkout để điều khiển trạng thái disabled -->
                    <button type="submit" name="action" value="checkout" class="btn btn-primary btn-lg" id="checkoutButton">Proceed to Checkout</button>
                </div>
                <c:if test="${empty customer.cart}">
                    <p class="empty-cart">Your cart is empty. Add some products to get started!</p>
                </c:if>

                <p class="error-message">${param.error}</p>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                        $(document).ready(function () {
                                            // Cập nhật số lượng sản phẩm trong badge
                                            let cartItemCount = ${customer.cart != null ? customer.cart.size() : 0};
                                            $('.new-cart-badge').text(cartItemCount);

                                            // Hàm tính tổng bill dựa trên các sản phẩm được chọn
                                            function updateCartTotal() {
                                                let cartTotal = 0;
                                                let selectedItems = $(".selectItem:checked");
                                                selectedItems.each(function () {
                                                    let productId = $(this).val();
                                                    let rowTotal = parseFloat($("#total_" + productId).text().replace('$', '').replace(/,/g, ''));
                                                    if (!isNaN(rowTotal)) {
                                                        cartTotal += rowTotal;
                                                    }
                                                });
                                                $("#cartTotal").text('$' + cartTotal.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}));
                                                $("#checkoutButton").prop("disabled", selectedItems.length === 0);
                                            }
                                            // Xử lý checkbox "Chọn tất cả"
                                            $("#selectAll").on("change", function () {
                                                $(".selectItem").prop("checked", $(this).prop("checked"));
                                                updateCartTotal();
                                            });

                                            // Xử lý khi checkbox từng sản phẩm thay đổi
                                            $(".selectItem").on("change", function () {
                                                if (!$(this).prop("checked")) {
                                                    $("#selectAll").prop("checked", false);
                                                }
                                                updateCartTotal();
                                            });

                                            // Xử lý khi thay đổi số lượng
                                            $(".quantity-input").on("input", function () {
                                                let productId = $(this).data("product-id");
                                                let quantity = parseInt($(this).val()) || 0;
                                                let price = parseFloat($(this).closest("tr").find(".price").data("price"));
                                                let productTotal = price * quantity;
                                                $("#total_" + productId).text('$' + productTotal.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}));
                                                updateCartTotal();
                                            });

                                            // Tính tổng ban đầu khi trang load (vì mặc định tất cả đều được chọn)
                                            updateCartTotal();
                                        });

                                        // Hàm xóa sản phẩm (giữ nguyên)
                                        function submitDelete(customerId, productId) {
                                            fetch("updateCart?customerId=" + customerId + "&productId=" + productId, {
                                                method: 'DELETE',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded'
                                                }
                                            })
                                                    .then(response => response.json())
                                                    .then(data => {
                                                        alert(data.message);
                                                        if (data.status === "success") {
                                                            window.location.href = "CartServlet";
                                                        }
                                                    })
                                                    .catch(_ => {
                                                        alert('Something went wrong');
                                                    });
                                        }
        </script>
    </body>
</html>