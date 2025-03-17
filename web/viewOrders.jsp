<%-- 
    Document   : viewOrders
    Created on : Mar 18, 2025, 1:18:06 AM
    Author     : Dell
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%
    List<List<Product>> orderHistory = (List<List<Product>>) session.getAttribute("orderHistory");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light">
    <div class="container mt-5">
        <h2 class="text-center">Your Order History</h2>
        <a href="home" class="btn btn-primary mb-3">Back to Home</a>
        
        <% if (orderHistory == null || orderHistory.isEmpty()) { %>
            <p class="text-center">No orders found.</p>
        <% } else { %>
            <% for (int i = 0; i < orderHistory.size(); i++) { %>
                <div class="card mb-3 bg-secondary text-white">
                    <div class="card-header">
                        <strong>Order <%= i + 1 %></strong>
                    </div>
                    <ul class="list-group list-group-flush">
                        <% for (Product p : orderHistory.get(i)) { %>
                            <li class="list-group-item bg-dark text-light">
                                <%= p.getName() %> - $<%= p.getPrice() %>
                            </li>
                        <% } %>
                    </ul>
                </div>
            <% } %>
        <% } %>
    </div>
</body>
</html>
