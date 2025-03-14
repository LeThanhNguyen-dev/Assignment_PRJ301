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
            background-color: #f8f9fa;
            padding-top: 50px;
        }
        .cart-container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .cart-header, .cart-footer {
            font-weight: bold;
        }
        .cart-item img {
            max-width: 80px;
            border-radius: 8px;
        }
        .quantity-input {
            width: 60px;
        }
        .action-buttons button {
            margin-right: 5px;
        }
    </style>
</head>
<body>
 

    <div class="container cart-container">
        <h2 class="text-center mb-4">🛒 Your Shopping Cart</h2>

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

            <div class="cart-footer text-end mt-4">
                <h4>Total: <span class="text-danger">${cartTotal} VNĐ</span></h4>
                <button type="submit" class="btn btn-warning btn-lg mt-3">Update Cart</button>
                <button type="submit" formaction="checkOUT.jsp" class="btn btn-primary btn-lg mt-3">Proceed to Checkout</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
