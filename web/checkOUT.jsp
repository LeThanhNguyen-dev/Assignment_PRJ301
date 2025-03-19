
<%@ page import="model.Customer, model.Product, java.text.DecimalFormat, java.util.Map" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding-top: 80px; /* ??y n?i dung xu?ng ?? tránh b? header che */
        }

        .checkout-container {
            max-width: 800px;
            margin: 40px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .checkout-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
        }

        .checkout-header {
            text-align: center;
            font-weight: 700;
            color: #333;
            font-size: 28px;
            margin-bottom: 25px;
            text-transform: uppercase;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .checkout-header i {
            color: #d4af37;
            font-size: 28px;
            transition: color 0.3s ease;
        }

        .checkout-header:hover i {
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

        .form-control, .form-select {
            background: #f5f5f5;
            color: #333;
            border: 2px solid #ccc;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .form-control:focus, .form-select:focus {
            border-color: #d4af37;
            box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
            outline: none;
        }

        textarea.form-control {
            resize: none;
            min-height: 100px;
        }

        .text-end {
            text-align: right;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 15px;
            margin-top: 30px;
        }

        .text-end h4 {
            font-weight: 600;
            font-size: 22px;
            color: #333;
            margin: 0;
        }

        .text-end h4 span {
            color: #d4af37;
        }

        .btn-success {
            background: linear-gradient(45deg, #d4af37, #c0a062);
            color: #333;
            font-weight: 500;
            width: 100%;
            max-width: 200px;
            padding: 12px;
            font-size: 18px;
            border-radius: 8px;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            background: linear-gradient(45deg, #c0a062, #d4af37);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container checkout-container">
        <h2 class="checkout-header"><i class="fas fa-shopping-bag"></i> Checkout</h2>

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

            DecimalFormat df = new DecimalFormat("#,### VN?");
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