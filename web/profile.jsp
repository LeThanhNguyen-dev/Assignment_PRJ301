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
    <style>
        .profile-container {
            max-width: 800px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .profile-info {
            margin-bottom: 15px;
        }
        .profile-info label {
            font-weight: bold;
            margin-right: 10px;
            min-width: 120px;
            display: inline-block;
        }
        .order-history {
            margin-top: 40px;
        }
        .order-history h5 {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: #343a40;
        }
        .table {
            font-size: 0.95rem;
        }
        .table th, .table td {
            vertical-align: middle;
        }

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .container {
            flex-grow: 1;
        }
        .footer {
            margin-top: 20px;
            padding-top: 20px;
            position: relative;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container profile-container">
        <h2 class="text-center mb-4">Thông Tin Cá Nhân</h2>
        <c:if test="${isLoggedIn}">
            <div class="profile-info">
                <label>Tên đăng nhập:</label> ${customer.username}
            </div>
            <div class="profile-info">
                <label>Họ và tên:</label> ${customer.name}
            </div>
            <div class="profile-info">
                <label>Số điện thoại:</label> ${customer.phone}
            </div>
            <div class="profile-info">
                <label>Email:</label> ${customer.email}
            </div>
            <div class="profile-info">
                <label>Địa chỉ:</label> ${customer.address}
            </div>
            <div class="text-center mt-4">
                <a href="editProfile.jsp" class="btn btn-warning">Chỉnh sửa thông tin</a>
                <a href="home" class="btn btn-primary">Quay lại</a>
            </div>
            <p class="text-success mt-3">${requestScope.message}</p>

            <div class="order-history">
                <h5>Lịch Sử Đơn Hàng</h5>
                <c:choose>
                    <c:when test="${not empty requestScope.orderList}">
                        <table class="table table-bordered table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>Mã đơn hàng</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${requestScope.orderList}">
                                    <tr>
                                        <td>${order.id}</td>
                                        <td>${order.orderDate}</td>
                                        <td>${order.total} VNĐ</td>
                                        <td>${order.status}</td>
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
        </c:if>
        <c:if test="${!isLoggedIn}">
            <p class="text-center text-danger">Vui lòng đăng nhập để xem thông tin cá nhân!</p>
            <div class="text-center">
                <a href="login.jsp" class="btn btn-primary">Đăng nhập</a>
            </div>
        </c:if>
    </div>

    <footer class="bg-dark text-white text-center py-3">
        <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>