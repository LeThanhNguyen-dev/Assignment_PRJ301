<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
  // Xóa giỏ hàng trong session
    session.removeAttribute("cart"); // Xóa danh sách sản phẩm
    session.setAttribute("cartSize", 0); // Đặt số lượng về 0
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1a1a1a 0%, #333333 100%);
            color: #ffffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .confirmation-container {
            max-width: 600px;
            background: #222;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(255, 215, 0, 0.3);
            border: 2px solid rgba(255, 215, 0, 0.8);
        }

        .confirmation-icon {
            font-size: 80px;
            color: #ffd700;
            text-shadow: 0 0 15px rgba(255, 215, 0, 0.8);
            animation: popUp 0.6s ease-in-out;
        }

        @keyframes popUp {
            0% { transform: scale(0); opacity: 0; }
            80% { transform: scale(1.2); opacity: 1; }
            100% { transform: scale(1); }
        }

        h1 {
            font-size: 26px;
            font-weight: bold;
            color: #ffd700;
            margin-top: 15px;
        }

        p {
            font-size: 18px;
            color: #ccc;
            margin-top: 10px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #ffd700, #ccac00);
            color: #000;
            font-weight: bold;
            padding: 12px 20px;
            font-size: 18px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #ffdf00, #e6b800);
            box-shadow: 0 0 15px rgba(255, 215, 0, 0.8);
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="confirmation-icon">✔️</div>
        <h1 class="mt-4">Order Placed Successfully!</h1>
        <p class="mt-3">Thank you for your purchase. Your order has been confirmed.</p>
        <a href="home" class="btn btn-primary mt-4">Back to Home</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Cập nhật số lượng giỏ hàng về 0
        let cartBadge = document.getElementById("cart-badge");
        if (cartBadge) {
            cartBadge.textContent = "0";
        }
    });
    </script>

</body>
</html>
