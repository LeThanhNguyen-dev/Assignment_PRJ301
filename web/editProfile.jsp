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
    <title>Chỉnh Sửa Thông Tin | Perfume Store</title>
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

        .edit-container {
            max-width: 600px;
            margin: 40px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            flex-grow: 1;
        }

        .edit-container:hover {
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

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: 500;
            color: #333;
            font-size: 16px;
        }

        .form-control {
            background: #f5f5f5;
            color: #333;
            border: 2px solid #ccc;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .form-control:focus {
            border-color: #d4af37;
            box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
            outline: none;
        }

        .form-control[readonly] {
            background: #e0e0e0;
            color: #666;
            cursor: not-allowed;
        }

        textarea.form-control {
            resize: none;
            min-height: 100px;
        }

        .btn-success {
            background: linear-gradient(45deg, #d4af37, #c0a062);
            color: #333;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            background: linear-gradient(45deg, #c0a062, #d4af37);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            color: #333;
        }

        .btn-secondary {
            background: linear-gradient(45deg, #e0e0e0, #c0c0c0);
            color: #333;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: linear-gradient(45deg, #c0c0c0, #e0e0e0);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
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

        .text-danger {
            color: #dc3545;
            text-align: center;
            margin-top: 15px;
        }

        .text-success {
            color: #28a745;
            text-align: center;
            margin-top: 15px;
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
    <div class="container edit-container">
        <h2><i class="fas fa-user-edit"></i> Chỉnh Sửa Thông Tin Cá Nhân</h2>
        
        <c:if test="${isLoggedIn}">
            <form action="updateProfile" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" class="form-control" id="username" name="username" value="${customer.username}" readonly>
                </div>
                <div class="form-group">
                    <label for="name">Họ và tên:</label>
                    <input type="text" class="form-control" id="name" name="name" value="${customer.name}" required>
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại:</label>
                    <input type="tel" class="form-control" id="phone" name="phone" value="${customer.phone}" pattern="[0-9]{10}" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" value="${customer.email}" required>
                </div>
                <div class="form-group">
                    <label for="address">Địa chỉ:</label>
                    <textarea class="form-control" id="address" name="address" rows="3" required>${customer.address}</textarea>
                </div>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success">Cập nhật</button>
                    <a href="profile.jsp" class="btn btn-secondary">Quay lại</a>
                </div>
            </form>
            <p class="text-danger mt-3">${requestScope.error}</p>
            <p class="text-success mt-3">${requestScope.message}</p>
        </c:if>
        
        <c:if test="${!isLoggedIn}">
            <p class="text-center text-danger">Vui lòng đăng nhập để chỉnh sửa thông tin!</p>
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