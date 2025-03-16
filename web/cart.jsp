<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Shopping Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .cart-container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
            }
            .cart-item img {
                max-width: 100px;
                max-height: 100px;
                object-fit: cover;
                display: block;
                margin: 0 auto;
            }
            .table td {
                vertical-align: middle;
            }
            .quantity-input {
                width: 80px;
                margin: 0 auto;
            }
            .cart-header {
                background-color: #f8f9fa;
            }
            .cart-footer {
                margin-top: 20px;
                text-align: right;
            }
            .empty-cart {
                text-align: center;
                color: #6c757d;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container cart-container">
            <h2>🛒 Your Shopping Cart</h2>

            <form action="updateCart" method="post" id="cartForm">
                <table class="table table-bordered text-center">
                    <thead class="cart-header">
                        <tr>
                            <th>Product</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="cartTotal" value="0"/>
                        <c:forEach var="entry" items="${sessionScope.cart}" varStatus="loop">
                            <c:set var="product" value="${entry.key}"/>
                            <c:set var="quantity" value="${entry.value}"/>
                            <tr class="cart-item">
                                <td><img src="${product.image}" alt="${product.name}"></td>
                                <td>${product.name}</td>
                                <td class="price" data-price="${product.price}">${product.price} VNĐ</td>
                                <td>
                                    <input type="number" name="quantity_${product.id}" class="form-control quantity-input" 
                                           value="${quantity}" min="1" data-product-id="${product.id}">
                                </td>
                                <td id="total_${product.id}">${product.price * quantity} VNĐ</td>
                                <td class="action-buttons">
                                    <button type="submit" formaction="removeFromCart?productId=${product.id}" 
                                            class="btn btn-danger btn-sm">Remove</button>
                                </td>
                            </tr>
                            <c:set var="cartTotal" value="${cartTotal + (product.price * quantity)}"/>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="cart-footer">
                    <h4>Total: <span id="cartTotal">${cartTotal} VNĐ</span></h4>
                    <a href="updateCart" class="btn btn-warning btn-lg">Update Cart</a>
                    <a href="checkOUT.jsp" class="btn btn-primary btn-lg">Proceed to Checkout</a>
                </div>

                <c:if test="${empty sessionScope.cart}">
                    <p class="empty-cart">Your cart is empty. Add some products to get started!</p>
                </c:if>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            $(document).ready(function () {
                // Lắng nghe sự kiện thay đổi số lượng
                $(".quantity-input").on("input", function () {
                    let productId = $(this).data("product-id");
                    let quantity = parseInt($(this).val());
                    let price = parseFloat($(this).closest("tr").find(".price").data("price"));

                    // Tính tổng tiền của sản phẩm
                    let productTotal = price * quantity;
                    $("#total_" + productId).text(productTotal + " VNĐ");

                    // Tính lại tổng tiền giỏ hàng
                    let cartTotal = 0;
                    $(".quantity-input").each(function () {
                        let qty = parseInt($(this).val());
                        let prc = parseFloat($(this).closest("tr").find(".price").data("price"));
                        cartTotal += qty * prc;
                    });
                    $("#cartTotal").text(cartTotal + " VNĐ");
                });
            });
        </script>
    </body>
</html>