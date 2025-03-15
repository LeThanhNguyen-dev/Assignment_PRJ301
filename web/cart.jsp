<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="dao.CustomerDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Shopping Cart</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #1a1a1a 0%, #333333 100%);
                color: #ffffff;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                padding-top: 70px;
            }

            .cart-container {
                max-width: 1000px;
                margin: 0 auto;
                background: #1f1f1f;
                padding: 40px;
                border: 1px solid #ffd700;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
                transition: transform 0.3s ease;
            }

            .cart-container:hover {
                transform: translateY(-5px);
            }

            h2 {
                color: #ffd700;
                font-weight: 600;
                text-align: center;
                margin-bottom: 30px;
                text-transform: uppercase;
            }

            .table {
                background: #2a2a2a;
                border: none;
                color: #ffffff;
            }

            .cart-header th {
                background: linear-gradient(45deg, #ffd700, #ccac00);
                color: #1a1a1a;
                font-weight: 600;
                padding: 15px;
                text-transform: uppercase;
                border: none;
            }

            .cart-item td {
                vertical-align: middle;
                padding: 20px;
                border-bottom: 1px solid #4d4d4d;
            }

            .cart-item img {
                max-width: 100px;
                border-radius: 10px;
                border: 1px solid #ffd700;
                transition: transform 0.3s ease;
            }

            .cart-item img:hover {
                transform: scale(1.1);
            }

            .cart-item td:nth-child(2) {
                color: #ffd700;
                font-weight: 500;
            }

            .cart-item td:nth-child(3),
            .cart-item td:nth-child(5) {
                color: #b3b3b3;
            }

            .quantity-input {
                width: 80px;
                background: #2a2a2a;
                border: 2px solid #4d4d4d;
                color: #ffffff;
                text-align: center;
                border-radius: 8px;
                transition: border-color 0.3s ease;
            }

            .quantity-input:focus {
                border-color: #ffd700;
                outline: none;
                box-shadow: 0 0 5px rgba(255, 215, 0, 0.3);
            }

            .action-buttons .btn-danger {
                background: #ff4d4d;
                border: none;
                font-weight: 500;
                padding: 8px 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .action-buttons .btn-danger:hover {
                background: #e63939;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4);
            }

            .cart-footer {
                margin-top: 30px;
                text-align: right;
            }

            .cart-footer h4 {
                color: #ffd700;
                font-weight: 600;
            }

            .cart-footer h4 span {
                color: #ff4d4d;
            }

            .cart-footer .btn {
                padding: 12px 25px;
                font-weight: 500;
                border-radius: 8px;
                margin-left: 15px;
                transition: all 0.3s ease;
                text-decoration: none; /* Loại bỏ gạch dưới */
            }

            .cart-footer .btn-warning {
                background: linear-gradient(45deg, #ffd700, #ccac00);
                border: none;
                color: #1a1a1a;
            }

            .cart-footer .btn-warning:hover {
                background: linear-gradient(45deg, #ccac00, #ffd700);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
            }

            .cart-footer .btn-primary {
                background: linear-gradient(45deg, #ffd700, #ccac00);
                border: none;
                color: #1a1a1a;
            }

            .cart-footer .btn-primary:hover {
                background: linear-gradient(45deg, #ccac00, #ffd700);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
            }

            .empty-cart {
                text-align: center;
                color: #b3b3b3;
                font-size: 1.2rem;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container cart-container">
            <h2>🛒 Your Shopping Cart</h2>

            <form action="updateCart" method="post">
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
                            <c:forEach var="product" items="${products}">
                                <tr class="cart-item">
                                    <td><img src="${product.image}" alt="${product.name}"></td>
                                    <td>${product.name}</td>
                                    <td>${product.price} VNĐ</td>
                                    <td>
                                        <input type="number" name="quantity_${product.id}" class="form-control quantity-input" value="${product.quantity}" min="1">
                                    </td>
                                    <td>${product.price * product.quantity} VNĐ</td>
                                    <td class="action-buttons">
                                        <button type="submit" formaction="removeFromCart?productId=${product.id}" class="btn btn-danger btn-sm">Remove</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="cart-footer">
                        <h4>Total: <span>${cartTotal} VNĐ</span></h4>
                        <a href="product.jsp" class="btn btn-warning btn-lg">Update Cart</a>
                        <a href="checkOUT.jsp" class="btn btn-primary btn-lg">Proceed to Checkout</a>
                    </div>
                
                <c:if test="${empty products}">
                    <p class="empty-cart">Your cart is empty. Add some products to get started!</p>
                </c:if>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>