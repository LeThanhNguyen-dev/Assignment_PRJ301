<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Kiểm tra trạng thái từ request
    String status = request.getParameter("status");

    if ("fail".equalsIgnoreCase(status)) {
        // Giữ nguyên giỏ hàng nếu thất bại
        session.setAttribute("cartItemCount", session.getAttribute("cartItemCount"));
    } else {
        // Xóa giỏ hàng và set cartItemCount về 0 nếu thành công
        session.removeAttribute("cart");
        session.setAttribute("cartItemCount", 0); // Đồng bộ với header.jsp
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title><%= "failed".equalsIgnoreCase(status) ? "Order Failed" : "Order Confirmation" %></title>
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
                box-shadow: 0 10px 30px rgba(255, 0, 0, 0.3);
                border: 2px solid <%= "fail".equalsIgnoreCase(status) ? "rgba(255, 0, 0, 0.8)" : "rgba(255, 215, 0, 0.8)" %>;
            }

            .confirmation-icon {
                font-size: 80px;
                text-shadow: 0 0 15px rgba(255, 215, 0, 0.8);
                animation: popUp 0.6s ease-in-out;
            }

            @keyframes popUp {
                0% {
                    transform: scale(0);
                    opacity: 0;
                }
                80% {
                    transform: scale(1.2);
                    opacity: 1;
                }
                100% {
                    transform: scale(1);
                }
            }

            h1 {
                font-size: 26px;
                font-weight: bold;
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

            .fail {
                color: #ff4d4d;
                text-shadow: 0 0 15px rgba(255, 0, 0, 0.8);
            }

            .success {
                color: #00ffea;
                text-shadow: 0 0 10px rgba(0, 255, 234, 0.8);
            }

            .fail-btn {
                background: linear-gradient(45deg, #ff4d4d, #cc0000);
            }

            .fail-btn:hover {
                background: linear-gradient(45deg, #ff6666, #e60000);
                box-shadow: 0 0 15px rgba(255, 0, 0, 0.8);
            }
        </style>
    </head>
    <body>
        <div class="confirmation-container">
            <% if ("failed".equalsIgnoreCase(status)) { %>
            <div class="confirmation-icon fail">❌</div>
            <h1 class="mt-4 fail">Order Failed!</h1>
            <p class="mt-3">Something went wrong. Please try again.</p>
            <a href="checkOut.jsp" class="btn btn-primary fail-btn mt-4">Try Again</a>
            <% } else { %>
            <div class="confirmation-icon success">✔️</div>
            <h1 class="mt-4 success">Order Placed Successfully!</h1>
            <p class="mt-3">Thank you for your purchase. Your order has been confirmed.</p>
            <a href="home" class="btn btn-primary mt-4">Back to Home</a>
            <% } %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
       
    </body>
</html>
