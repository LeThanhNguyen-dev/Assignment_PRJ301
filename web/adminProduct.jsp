<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý sản phẩm</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

            h2.page-title {
                color: #333;
                font-weight: 700;
                text-align: center;
                margin-bottom: 30px;
                text-transform: uppercase;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            h2.page-title i {
                color: #d4af37;
                font-size: 28px;
                transition: color 0.3s ease;
            }

            h2.page-title:hover i {
                color: #c0a062;
            }

            .form-container {
                background: #ffffff;
                border: 2px solid #ccc;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                margin-bottom: 30px;
            }

            .form-container .mb-3 {
                margin-bottom: 20px;
            }

            .form-container label {
                color: #333;
                font-weight: 500;
                font-size: 16px;
            }

            .form-container input {
                border: 2px solid #ccc;
                border-radius: 8px;
                background-color: #f5f5f5;
                color: #333;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .form-container input:focus {
                border-color: #d4af37;
                box-shadow: 0 0 5px rgba(212, 175, 55, 0.3);
            }

            .form-container .btn-primary {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                border: none;
                color: #333;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .form-container .btn-primary:hover {
                background: linear-gradient(45deg, #c0a062, #d4af37);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            }

            .form-container .btn-secondary {
                background: linear-gradient(45deg, #e0e0e0, #c0c0c0);
                border: none;
                color: #333;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .form-container .btn-secondary:hover {
                background: linear-gradient(45deg, #c0c0c0, #e0e0e0);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            }

            .table-container {
                background: #ffffff;
                border: 2px solid #ccc;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            }

            .table {
                width: 100%;
                border-collapse: collapse;
            }

            .table thead {
                background: linear-gradient(45deg, #d4af37, #c0a062);
                color: #333;
            }

            .table th, .table td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #ccc;
            }

            .table tbody tr:hover {
                background-color: #f5f5f5;
            }

            .table .btn-warning {
                background: linear-gradient(45deg, #f39c12, #e67e22);
                border: none;
                color: #333;
                padding: 8px 15px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .table .btn-warning:hover {
                background: linear-gradient(45deg, #e67e22, #f39c12);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(243, 156, 18, 0.4);
            }

            .table .btn-danger {
                background: linear-gradient(45deg, #ff4d4d, #e63946);
                border: none;
                color: #fff;
                padding: 8px 15px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .table .btn-danger:hover {
                background: linear-gradient(45deg, #e63946, #ff4d4d);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 77, 77, 0.4);
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
                .main-content {
                    padding: 15px;
                }
                .form-container, .table-container {
                    padding: 15px;
                }
                .table th, .table td {
                    padding: 8px;
                    font-size: 14px;
                }
                .table .btn-warning, .table .btn-danger {
                    padding: 6px 10px;
                    font-size: 14px;
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
                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <div class="main-content">
            <h2 class="page-title"><i class="fas fa-box"></i> Quản lý sản phẩm</h2>

            <!-- Form thêm/sửa sản phẩm -->
            <div class="form-container">
                <form action="adminProduct" method="post" class="mb-4">
                    <input type="hidden" name="action" value="${product != null ? 'update' : 'add'}">
                    <input type="hidden" name="id" value="${product != null ? product.id : ''}">
                    <div class="mb-3">
                        <label>Tên sản phẩm:</label>
                        <input type="text" name="name" class="form-control" value="${product != null ? product.name : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Mô tả:</label>
                        <input type="text" name="description" class="form-control" value="${product != null ? product.description : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Hình ảnh:</label>
                        <input type="text" name="image" class="form-control" value="${product != null ? product.image : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Giá:</label>
                        <input type="number" step="0.01" name="price" class="form-control" value="${product != null ? product.price : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Danh mục (Category ID):</label>
                        <input type="number" name="categoryId" class="form-control" value="${product != null ? product.categoryId : ''}" required>
                    </div>
                    <div class="d-flex gap-3">
                        <button type="submit" class="btn btn-primary">${product != null ? 'Cập nhật' : 'Thêm mới'}</button>
                        <a href="adminProduct" class="btn btn-secondary">Hủy</a>
                    </div>
                </form>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="table-container">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Mô tả</th>
                            <th>Hình ảnh</th>
                            <th>Giá</th>
                            <th>Danh mục</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.name}</td>
                                <td>${product.description}</td>
                                <td>${product.image}</td>
                                <td>${product.price}</td>
                                <td>${product.categoryId}</td>
                                <td>
                                    <a href="adminProduct?action=edit&id=${product.id}" class="btn btn-warning btn-sm">Sửa</a>
                                    <a href="adminProduct?action=delete&id=${product.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>