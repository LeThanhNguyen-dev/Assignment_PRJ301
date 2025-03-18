<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding-top: 80px; /* Đẩy nội dung xuống để tránh bị header che */
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
            color: #666;
            font-size: 18px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container cart-container">
        <h2><i class="fas fa-shopping-cart"></i> Your Shopping Cart</h2>

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
                                <form action="UpdateCartServlet" method="post" class="update-cart-form">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <input type="number" name="quantity" class="form-control quantity-input" 
                                           value="${quantity}" min="1" data-product-id="${product.id}" onchange="this.form.submit();">
                                </form>
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
            $(".quantity-input").on("input", function () {
                let productId = $(this).data("product-id");
                let quantity = parseInt($(this).val());
                let price = parseFloat($(this).closest("tr").find(".price").data("price"));

                let productTotal = price * quantity;
                $("#total_" + productId).text(productTotal + " VNĐ");

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