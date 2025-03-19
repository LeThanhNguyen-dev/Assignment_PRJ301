<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>

<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Thông Tin Cá Nhân | Perfume Store</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
                color: #333;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                padding-top: 80px; /* Đẩy nội dung xuống để tránh bị header che */
                display: flex;
                flex-direction: column;
            }

            .profile-container {
                max-width: 800px;
                margin: 40px auto;
                background: #ffffff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
                flex-grow: 1;
            }

            .profile-container:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
            }

            h2 {
                color: #333;
                font-weight: 700;
                text-align: center;
                margin-bottom: 25px;
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

            .profile-info {
                margin-bottom: 15px;
                padding: 10px;
                border-bottom: 1px solid #ccc;
            }

            .profile-info label {
                font-weight: 500;
                color: #333;
                margin-right: 10px;
                min-width: 120px;
                display: inline-block;
            }

            .profile-info span {
                color: #666;
            }

            .order-history {
                margin-top: 40px;
            }

            .order-history h5 {
                font-size: 1.2rem;
                font-weight: 600;
                margin-bottom: 20px;
                color: #333;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .order-history h5 i {
                color: #d4af37;
                transition: color 0.3s ease;
            }

            .order-history h5:hover i {
                color: #c0a062;
            }

            .table {
                background: #f5f5f5;
                color: #333;
                font-size: 0.95rem;
                border-radius: 8px;
                overflow: hidden;
            }

            .table th, .table td {
                vertical-align: middle;
                padding: 15px;
            }

            .table thead {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                color: #333;
            }

            .table tbody tr {
                border-bottom: 1px solid #ccc;
            }

            .table tbody tr:hover {
                background: rgba(212, 175, 55, 0.1);
            }

            .btn-warning {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                color: #333;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .btn-warning:hover {
                background: linear-gradient(45deg, #c0a062, #d4af37);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
                color: #333;
            }

            .btn-primary {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                color: #333;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background: linear-gradient(45deg, #c0a062, #d4af37);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
                color: #333;
            }

            .text-success {
                color: #28a745;
                text-align: center;
                margin-top: 15px;
            }

            .text-danger {
                color: #dc3545;
                text-align: center;
                margin-top: 15px;
                font-size: 1.1rem;
            }

            .footer {
                background: linear-gradient(90deg, #e0e0e0, #c0c0c0);
                color: #333;
                text-align: center;
                padding: 20px 0;
                margin-top: 40px;
                width: 100%;
                box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <div class="container profile-container">
            <h2><i class="fas fa-user"></i> Thông Tin Cá Nhân</h2>
            <c:if test="${isLoggedIn}">
                <div class="profile-info">
                    <label>Tên đăng nhập:</label> <span>${customer.username}</span>
                </div>
                <div class="profile-info">
                    <label>Họ và tên:</label> <span>${customer.name}</span>
                </div>
                <div class="profile-info">
                    <label>Số điện thoại:</label> <span>${customer.phone}</span>
                </div>
                <div class="profile-info">
                    <label>Email:</label> <span>${customer.email}</span>
                </div>
                <div class="profile-info">
                    <label>Địa chỉ:</label> <span>${customer.address}</span>
                </div>
                <div class="text-center mt-4">
                    <a href="editProfile.jsp" class="btn btn-warning">Chỉnh sửa thông tin</a>
                    <a href="home" class="btn btn-primary">Quay lại</a>
                </div>
                <p class="text-success mt-3">${requestScope.message}</p>

                <!-- Order History Section -->
                <div class="order-history">
                    <h5><i class="fas fa-history"></i> Lịch Sử Đơn Hàng</h5>
                    <c:choose>
                        <c:when test="${not empty requestScope.orders}">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Mã đơn hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        
                                        <th>Địa chỉ</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${requestScope.orders}">
                                        <tr>
                                            <td>${order.orderId}</td>
                                            <td>${order.orderDate}</td>
                                            <td>${order.totalAmount} VNĐ</td>
                                            <td>${order.status}</td>
                                            <td>${order.shippingAddress}</td>

                                            
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center">Bạn chưa có đơn hàng nào.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>
        <c:if test="${!isLoggedIn}">
            <p class="text-danger">Vui lòng đăng nhập để xem thông tin cá nhân!</p>
            <div class="text-center">
                <a href="login.jsp" class="btn btn-primary">Đăng nhập</a>
            </div>
        </c:if>
    </div>

    <footer class="footer">
        <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>