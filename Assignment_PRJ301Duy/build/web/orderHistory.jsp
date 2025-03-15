<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Order" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Your Order History</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                </tr>
            </thead>
            <tbody>
                <% if (orders != null && !orders.isEmpty()) { %>
                    <% for (Order order : orders) { %>
                        <tr>
                            <td><%= order.getProductName() %></td>
                            <td><%= order.getQuantity() %></td>
                            <td>$<%= order.getTotalPrice() %></td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="3">No orders found.</td></tr>
                <% } %>
            </tbody>
        </table>
        <a href="home" class="btn btn-primary">Back to Home</a>
    </div>
</body>
</html>
