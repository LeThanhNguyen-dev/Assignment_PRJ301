<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý voucher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
            min-height: 100vh;
            padding-top: 20px;
            display: flex;
            flex-direction: column;
        }

        .container {
            padding: 20px;
            flex-grow: 1;
        }

        h2 {
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

        h2 i {
            color: #d4af37;
            font-size: 28px;
            transition: color 0.3s ease;
        }

        h2:hover i {
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

        /* Style cho thông báo lỗi */
        .alert-error {
            background: #ff4d4d;
            color: #fff;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        /* Style cho thông báo thành công */
        .alert-success {
            background: #28a745;
            color: #fff;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 768px) {
            .container {
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
    <div class="container mt-5">
        <h2><i class="fas fa-ticket-alt"></i> Quản lý voucher</h2>

        <!-- Hiển thị thông báo thành công nếu có -->
        <c:if test="${not empty success}">
            <div class="alert-success">
                ${success}
            </div>
        </c:if>

        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty error}">
            <div class="alert-error">
                ${error}
            </div>
        </c:if>

        <!-- Form thêm/sửa voucher -->
        <div class="form-container">
            <form action="adminVouchers" method="post" class="mb-4">
                <input type="hidden" name="action" value="${voucher != null ? 'update' : 'add'}">
                <input type="hidden" name="id" value="${voucher != null ? voucher.id : ''}">
                <div class="mb-3">
                    <label>Mã voucher:</label>
                    <input type="text" name="code" class="form-control" value="${voucher != null ? voucher.code : ''}" required>
                </div>
                <div class="mb-3">
                    <label>Giảm giá (%):</label>
                    <input type="number" step="0.01" name="discount" class="form-control" value="${voucher != null ? voucher.discount : ''}" required>
                </div>
                <div class="mb-3">
                    <label>Ngày hết hạn:</label>
                    <input type="date" name="expiryDate" class="form-control" value="${voucher != null ? voucher.expiryDate : ''}" required>
                </div>
                <div class="d-flex gap-3">
                    <button type="submit" class="btn btn-primary">${voucher != null ? 'Cập nhật' : 'Thêm mới'}</button>
                    <a href="${pageContext.request.contextPath}/adminVouchers" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
        </div>

        <!-- Danh sách voucher -->
        <div class="table-container">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Mã voucher</th>
                        <th>Giảm giá (%)</th>
                        <th>Ngày hết hạn</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="voucher" items="${vouchers}">
                        <tr>
                            <td>${voucher.id}</td>
                            <td>${voucher.code}</td>
                            <td>${voucher.discount}</td>
                            <td>${voucher.expiryDate}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/adminVouchers?action=edit&id=${voucher.id}" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="${pageContext.request.contextPath}/adminVouchers?action=delete&id=${voucher.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa voucher này?')">Xóa</a>
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