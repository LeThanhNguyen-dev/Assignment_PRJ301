<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 50px;
        }
        .checkout-container {
            max-width: 800px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .form-group label {
            font-weight: bold;
        }
        .checkout-header {
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container checkout-container">
        <h2 class="checkout-header">🛍️ Checkout</h2>

        <form action="CheckoutServlet" method="post">
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Shipping Address</label>
                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label for="paymentMethod" class="form-label">Payment Method</label>
                <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                    <option value="credit_card">Credit Card</option>
                    <option value="cod">Cash on Delivery</option>
                    <option value="paypal">PayPal</option>
                </select>
            </div>

            <div class="text-end mt-4">
                <h4>Total: <span class="text-danger">${cartTotal} VNĐ</span></h4>
                <button type="submit" class="btn btn-success btn-lg mt-3">Confirm Order</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
