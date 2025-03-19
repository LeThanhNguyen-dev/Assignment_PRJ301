<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PerfumeNhungChuBeDan</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%); /* Gradient nền giống các trang khác */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            display: flex;
            min-height: calc(100vh - 60px); /* Trừ chiều cao footer */
        }

        .sidebar {
            width: 250px;
            background: #ffffff; /* Nền trắng */
            border-right: 2px solid #ccc; /* Viền giống các trang khác */
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .sidebar h2 {
            margin-top: 0;
            font-size: 24px;
            color: #333; /* Màu chữ giống các trang khác */
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .sidebar h2 i {
            color: #d4af37; /* Màu icon vàng nhạt */
            transition: color 0.3s ease;
        }

        .sidebar h2:hover i {
            color: #c0a062; /* Hover đổi màu */
        }

        .sidebar a {
            color: #333;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .sidebar a:hover {
            background: linear-gradient(45deg, #d4af37, #c0a062); /* Gradient vàng nhạt */
            color: #333;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
        }

        .sidebar a i {
            font-size: 18px;
        }

        .main-content {
            flex-grow: 1;
            padding: 20px;
        }

        .header {
            background-color: #ffffff;
            padding: 15px 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 8px;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header h1 i {
            color: #d4af37; /* Màu icon vàng nhạt */
            transition: color 0.3s ease;
        }

        .header h1:hover i {
            color: #c0a062; /* Hover đổi màu */
        }

        .header .logout {
            color: #ff4d4d; /* Màu đỏ cho logout */
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            padding: 8px 15px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .header .logout:hover {
            background: linear-gradient(45deg, #ff4d4d, #e63946);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 77, 77, 0.3);
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
            border: 2px solid #ccc; /* Viền giống các trang khác */
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            text-align: center;
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
            border-color: #d4af37; /* Viền vàng nhạt khi hover */
        }

        .card h3 {
            margin: 0 0 10px 0;
            color: #333;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .card h3 i {
            color: #d4af37; /* Màu icon vàng nhạt */
            transition: color 0.3s ease;
        }

        .card:hover h3 i {
            color: #c0a062; /* Hover đổi màu */
        }

        .card p {
            font-size: 24px;
            margin: 0;
            color: #d4af37; /* Màu số liệu vàng nhạt */
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                border-right: none;
                border-bottom: 2px solid #ccc;
            }
            .main-content {
                padding: 15px;
            }
            .header h1 {
                font-size: 24px;
            }
            .dashboard-cards {
                grid-template-columns: 1fr; /* 1 cột trên mobile */
            }
        }
    </style>
</head>
<body>
    <c:if test="${sessionScope.session_Admin == null}">
        <c:redirect url="${pageContext.request.contextPath}/login" />
    </c:if>

    <div class="container">
        <div class="sidebar">
            <h2><i class="fas fa-user-shield"></i> Admin Panel</h2>
            <a href="${pageContext.request.contextPath}/adminDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/adminProduct"><i class="fas fa-box"></i> Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/customers"><i class="fas fa-users"></i> Manage Customers</a>
            <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/vouchers"><i class="fas fa-ticket-alt"></i> Manage Vouchers</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1><i class="fas fa-handshake"></i> Welcome, ${sessionScope.session_Admin.name}</h1>
                <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
            </div>

            <div class="dashboard-cards">
                <div class="card">
                    <h3><i class="fas fa-users"></i> Total Customers</h3>
                    <p>${requestScope.totalCustomers}</p>
                </div>
                <div class="card">
                    <h3><i class="fas fa-shopping-cart"></i> Total Orders</h3>
                    <p>${requestScope.totalOrders}</p>
                </div>
                <div class="card">
                    <h3><i class="fas fa-box"></i> Total Products</h3>
                    <p>${requestScope.totalProducts}</p>
                </div>
                <div class="card">
                    <h3><i class="fas fa-dollar-sign"></i> Total Revenue</h3>
                    <p>${requestScope.totalRevenue} $</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>