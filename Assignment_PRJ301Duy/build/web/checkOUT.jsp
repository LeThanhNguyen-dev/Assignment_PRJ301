<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Customer, model.CartItem, java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Checkout</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #1a1a1a 0%, #333333 100%);
                color: #ffffff;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                padding-top: 70px;
            }

            .checkout-container {
                max-width: 900px;
                margin: 0 auto;
                background: #1f1f1f;
                padding: 40px;
                border: 1px solid #ffd700;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
                transition: transform 0.3s ease;
            }

            .checkout-container:hover {
                transform: translateY(-5px);
            }

            .checkout-header {
                color: #ffd700;
                font-weight: 600;
                text-align: center;
                margin-bottom: 30px;
                text-transform: uppercase;
            }

            .form-group label {
                color: #ffd700;
                font-weight: 500;
                margin-bottom: 8px;
                font-size: 1.1rem;
            }

            .form-control, .form-select {
                background: #2a2a2a;
                border: 2px solid #4d4d4d;
                color: #ffffff;
                border-radius: 8px;
                padding: 12px;
                font-size: 1rem;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: #ffd700;
                box-shadow: 0 0 5px rgba(255, 215, 0, 0.3);
                outline: none;
            }

            .form-control::placeholder {
                color: #b3b3b3;
            }

            textarea.form-control {
                resize: vertical;
                min-height: 100px;
            }

            .text-end h4 {
                color: #ffd700;
                font-weight: 600;
                margin-top: 30px;
            }

            .text-end h4 span {
                color: #ff4d4d;
            }

            .btn-success {
                background: linear-gradient(45deg, #ffd700, #ccac00);
                border: none;
                color: #1a1a1a;
                font-weight: 500;
                padding: 12px 25px;
                border-radius: 8px;
                transition: all 0.3s ease;
                width: 100%;
                margin-top: 20px;
            }

            .btn-success:hover {
                background: linear-gradient(45deg, #ccac00, #ffd700);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
            }
        </style>
    </head>
    <body>
        <div class="container checkout-container">
            <h2 class="checkout-header">🛍️ Checkout</h2>

            <%
                // Lấy thông tin khách hàng từ session (sau khi họ đã đăng nhập)
                Customer customer = (Customer) session.getAttribute("loggedInCustomer");

                // Lấy giỏ hàng mới nhất từ session
                Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

                // Tính tổng giá trị giỏ hàng
                double cartTotal = 0;
                if (cart != null) {
                    for (CartItem item : cart.values()) {
                        cartTotal += item.getTotalPrice();
                    }
                }
            %>

            <%
                DecimalFormat df = new DecimalFormat("#,### VNĐ");
                String formattedTotal = df.format(cartTotal);
            %>

            <form action="CheckoutServlet" method="post">
                <div class="mb-3 form-group">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" 
                           value="<%= (customer != null) ? customer.getName() : "" %>" required>
                </div>

                <div class="mb-3 form-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" 
                           value="<%= (customer != null) ? customer.getEmail() : "" %>" required>
                </div>

                <div class="mb-3 form-group">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" name="phone" 
                           value="<%= (customer != null) ? customer.getPhone() : "" %>" required>
                </div>

                <div class="mb-3 form-group">
                    <label for="address" class="form-label">Shipping Address</label>
                    <textarea class="form-control" id="address" name="address" rows="3" required><%= (customer != null) ? customer.getAddress() : "" %></textarea>
                </div>

                <div class="mb-3 form-group">
                    <label for="paymentMethod" class="form-label">Payment Method</label>
                    <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                        <option value="credit_card">Credit Card</option>
                        <option value="cod">Cash on Delivery</option>
                        <option value="paypal">PayPal</option>
                    </select>
                </div>

                <div class="text-end">
                    <h4>Total: <span><%= formattedTotal %></span></h4>
                    
                    <button type="submit" class="btn btn-success">Confirm Order</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
