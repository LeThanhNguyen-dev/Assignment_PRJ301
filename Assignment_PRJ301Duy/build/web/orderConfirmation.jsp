<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Supprimer les produits du panier après la confirmation de commande
    session.removeAttribute("cartItems"); // Supprimer le panier
    session.setAttribute("cartSize", 0); // Réinitialiser le compteur à 0
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
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }

        .confirmation-container {
            background: #1f1f1f;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            border: 1px solid #ffd700;
            transition: transform 0.3s ease;
        }

        .confirmation-container:hover {
            transform: translateY(-5px);
        }

        .confirmation-icon {
            font-size: 80px;
            color: #ffd700;
            margin-bottom: 20px;
        }

        h1 {
            color: #ffd700;
            font-weight: 600;
            text-transform: uppercase;
        }

        p {
            color: #b3b3b3;
            font-size: 1.2rem;
        }

        .btn-primary {
            background: linear-gradient(45deg, #ffd700, #ccac00);
            border: none;
            color: #1a1a1a;
            font-weight: 500;
            padding: 12px 25px;
            border-radius: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #ccac00, #ffd700);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <div class="confirmation-icon">✔️</div>
        <h1>Order Placed Successfully!</h1>
        <p>Thank you for your purchase. Your order has been confirmed.</p>
        <a href="home" class="btn btn-primary mt-4">Back to Home</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            let cartBadge = document.getElementById('cart-badge');
            if (cartBadge) {
                cartBadge.textContent = "0";
            }
        });
    </script>
</body>
</html>
