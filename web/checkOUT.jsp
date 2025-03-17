<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Customer, model.Product, java.text.DecimalFormat, java.util.Map" %>

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
                max-width: 800px;
                margin: auto;
                background: #222;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(255, 215, 0, 0.3);
                border: 2px solid rgba(255, 215, 0, 0.8);
            }

            .checkout-header {
                text-align: center;
                font-weight: 600;
                color: #ffd700;
                font-size: 28px;
                margin-bottom: 25px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                font-weight: 500;
                color: #ffd700;
                font-size: 16px;
            }

            .form-control, .form-select {
                background: #333;
                color: #fff;
                border: 1px solid #ffd700;
                padding: 10px;
                border-radius: 5px;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: #ffa500;
                box-shadow: 0 0 10px rgba(255, 165, 0, 0.7);
            }

            textarea.form-control {
                resize: none;
                min-height: 100px;
            }

            .text-end h4 {
                font-weight: 600;
                font-size: 22px;
                color: #ffd700;
            }

            .text-end h4 span {
                color: #ff4d4d;
            }

            .btn-success {
                background: linear-gradient(45deg, #ffd700, #ccac00);
                color: #000;
                font-weight: bold;
                width: 100%;
                padding: 12px;
                font-size: 18px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .btn-success:hover {
                background: linear-gradient(45deg, #ffdf00, #e6b800);
                box-shadow: 0 0 15px rgba(255, 215, 0, 0.8);
                transform: scale(1.05);
            }


        </style>
    </head>
    <body>
        <div class="container checkout-container">
            <h2 class="checkout-header">🛍️ Checkout</h2>

            <%
                Customer customer = (Customer) session.getAttribute("loggedInCustomer");
                Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");
                double cartTotal = 0;

                if (cart != null) {
                    for (Map.Entry<Product, Integer> entry : cart.entrySet()) {
                        Product product = entry.getKey();
                        int quantity = entry.getValue();
                        cartTotal += product.getPrice() * quantity;
                    }
                }

                DecimalFormat df = new DecimalFormat("#,### VNĐ");
                String formattedTotal = df.format(cartTotal);
            %>

            <form action="CheckoutServlet" method="post">
                <div class="mb-3 form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" 
                           value="<%= (customer != null) ? customer.getName() : "" %>" required>
                </div>

                <div class="mb-3 form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" 
                           value="<%= (customer != null) ? customer.getEmail() : "" %>" required>
                </div>

                <div class="mb-3 form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" name="phone" 
                           value="<%= (customer != null) ? customer.getPhone() : "" %>" required>
                </div>

                <div class="mb-3 form-group">
                    <label for="address">Shipping Address</label>
                    <textarea class="form-control" id="address" name="address" required><%= (customer != null) ? customer.getAddress() : "" %></textarea>
                </div>

                <div class="mb-3 form-group">
                    <label for="paymentMethod">Payment Method</label>
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
    </body>
</html>
