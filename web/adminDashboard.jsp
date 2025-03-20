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
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background: #ffffff;
            border-bottom: 2px solid #ccc;
            padding: 15px 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .navbar h2 {
            margin: 0;
            font-size: 24px;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar h2 i {
            color: #d4af37;
            transition: color 0.3s ease;
        }

        .navbar h2:hover i {
            color: #c0a062;
        }

        .navbar-menu {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .navbar-menu a {
            color: #333;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .navbar-menu a:hover {
            background: linear-gradient(45deg, #d4af37, #c0a062);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
        }

        .navbar-menu a i {
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
            margin-bottom: 20px;
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
            color: #d4af37;
            transition: color 0.3s ease;
        }

        .header h1:hover i {
            color: #c0a062;
        }

        .header .logout {
            color: #ff4d4d;
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
        }

        .card {
            background-color: #ffffff;
            padding: 20px;
            border: 2px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            text-align: center;
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
            border-color: #d4af37;
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
            color: #d4af37;
            transition: color 0.3s ease;
        }

        .card:hover h3 i {
            color: #c0a062;
        }

        .card p {
            font-size: 24px;
            margin: 0;
            color: #d4af37;
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }
            .navbar-menu {
                flex-direction: column;
                width: 100%;
                margin-top: 10px;
            }
            .navbar-menu a {
                width: 100%;
                justify-content: flex-start;
            }
            .header h1 {
                font-size: 24px;
            }
            .dashboard-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <c:if test="${sessionScope.session_Admin == null}">
        <c:redirect url="${pageContext.request.contextPath}/login" />
    </c:if>

    <div class="navbar">
        <h2><i class="fas fa-user-shield"></i> Admin Panel</h2>
        <div class="navbar-menu">
            <a href="${pageContext.request.contextPath}/adminDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/adminProduct"><i class="fas fa-box"></i> Manage Products</a>
            <a href="${pageContext.request.contextPath}/adminCustomers"><i class="fas fa-users"></i> Manage Customers</a>
            <a href="${pageContext.request.contextPath}/adminOrders"><i class="fas fa-shopping-cart"></i> Manage Orders</a>
            <a href="${pageContext.request.contextPath}/adminVouchers"><i class="fas fa-ticket-alt"></i> Manage Vouchers</a>
        </div>
    </div>

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
</body>
</html>