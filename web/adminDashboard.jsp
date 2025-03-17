<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PerfumeNhungChuBeDan</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar h2 {
            margin-top: 0;
            font-size: 24px;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .sidebar a:hover {
            background-color: #34495e;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
        }
        .header {
            background-color: #ffffff;
            padding: 10px 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
            font-size: 28px;
        }
        .header .logout {
            color: #e74c3c;
            text-decoration: none;
            font-weight: bold;
        }
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .card h3 {
            margin: 0 0 10px 0;
            color: #2c3e50;
        }
        .card p {
            font-size: 24px;
            margin: 0;
            color: #3498db;
        }
    </style>
</head>
<body>
    <c:if test="${sessionScope.session_Admin == null}">
        <c:redirect url="${pageContext.request.contextPath}/login" />
    </c:if>

    <div class="container">
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <a href="${pageContext.request.contextPath}/adminDashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/products">Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/customers">Manage Customers</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/vouchers">Manage Vouchers</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Welcome, ${sessionScope.session_Admin.name}</h1>
                <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
            </div>

            <div class="dashboard-cards">
                <div class="card">
                    <h3>Total Customers</h3>
                    <p>${requestScope.totalCustomers}</p>
                </div>
                <div class="card">
                    <h3>Total Orders</h3>
                    <p>${requestScope.totalOrders}</p>
                </div>
                <div class="card">
                    <h3>Total Products</h3>
                    <p>${requestScope.totalProducts}</p>
                </div>
                <div class="card">
                    <h3>Total Revenue</h3>
                    <p>${requestScope.totalRevenue} $</p>
                </div>
                
            </div>
        </div>
    </div>
</body>
</html>