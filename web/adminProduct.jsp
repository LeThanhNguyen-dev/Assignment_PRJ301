<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    
    <div class="container mt-5">
        <h2>Quản lý sản phẩm</h2>

        <!-- Form thêm/sửa sản phẩm -->
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
            <button type="submit" class="btn btn-primary">${product != null ? 'Cập nhật' : 'Thêm mới'}</button>
            <a href="adminProduct" class="btn btn-secondary">Hủy</a>
        </form>

        <!-- Danh sách sản phẩm -->
        <table class
		
		="table table-bordered">
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>