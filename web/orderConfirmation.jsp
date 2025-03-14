<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .confirmation-container {
            background: #fff;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        .confirmation-icon {
            font-size: 80px;
            color: #28a745;
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="confirmation-icon">✔️</div>
        <h1 class="mt-4">Order Placed Successfully!</h1>
        <p class="mt-3">Thank you for your purchase. Your order has been confirmed.</p>
        <a href="home.jsp" class="btn btn-primary mt-4">Back to Home</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
