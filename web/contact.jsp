<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Customer" %>
<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>

<c:set var="productList" value="${requestScope.productList}"/>
<c:set var="cart" value="${sessionScope.cart}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên Hệ | Perfume Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding-top: 80px; /* Đẩy nội dung xuống để tránh bị header che */
            display: flex;
            flex-direction: column;
        }

        .containers {
            width: 80%;
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            flex-grow: 1;
        }

        .containers:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #333;
            font-weight: 700;
            text-align: center;
            margin-bottom: 25px;
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

        .contact-info {
            text-align: center;
            margin-bottom: 30px;
            padding: 15px;
            background: #f5f5f5;
            border-radius: 10px;
        }

        .contact-info p {
            margin: 5px 0;
            color: #666;
            font-size: 1rem;
        }

        .contact-info strong {
            color: #333;
            font-weight: 500;
        }

        .contact-form {
            max-width: 600px;
            margin: 0 auto;
        }

        .contact-form h3 {
            color: #333;
            font-weight: 600;
            text-align: center;
            margin-bottom: 20px;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .contact-form h3 i {
            color: #d4af37;
            transition: color 0.3s ease;
        }

        .contact-form h3:hover i {
            color: #c0a062;
        }

        .contact-form label {
            display: block;
            margin: 10px 0 5px;
            color: #333;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .contact-form input, 
        .contact-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            background: #f5f5f5;
            border: 2px solid #ccc;
            border-radius: 8px;
            color: #333;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .contact-form input:focus, 
        .contact-form textarea:focus {
            border-color: #d4af37;
            box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
            outline: none;
        }

        .contact-form textarea {
            resize: none;
            min-height: 120px;
        }

        .contact-form button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, #d4af37, #c0a062);
            color: #333;
            font-weight: 500;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .contact-form button:hover {
            background: linear-gradient(45deg, #c0a062, #d4af37);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
        }

        .contact-form button i {
            font-size: 1rem;
        }

        iframe {
            width: 100%;
            height: 300px;
            border: 0;
            border-radius: 10px;
            margin-top: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .footer {
            background: linear-gradient(90deg, #e0e0e0, #c0c0c0);
            color: #333;
            text-align: center;
            padding: 20px 0;
            margin-top: 40px;
            width: 100%;
            box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.1);
        }

        .message-status {
            text-align: center;
            margin-top: 10px;
            font-size: 0.9rem;
            color: #28a745; /* Màu xanh cho thông báo thành công */
        }
    </style>
</head>
<body>
    <div class="containers">
        <h2><i class="fas fa-envelope"></i> Liên Hệ</h2>
        <div class="contact-info">
            <p><strong>Địa chỉ:</strong> 344 Nguyễn Duy Hiệu, Thành Phố Hội An</p>
            <p><strong>Điện thoại:</strong> 0796555878</p>
            <p><strong>Email:</strong> nhungchubedan@gmail.com</p>
        </div>

        <div class="contact-form">
            <h3><i class="fas fa-comment-dots"></i> Gửi Tin Nhắn</h3>
            <form action="sendEmail" method="post">
                <label for="name">Họ và Tên:</label>
                <input type="text" id="name" name="name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="message">Nội dung:</label>
                <textarea id="message" name="message" rows="5" required></textarea>

                <button type="submit"><i class="fas fa-paper-plane"></i> Gửi</button>
                <p class="message-status">${requestScope.messageStatus}</p>
            </form>
        </div>

        <h3><i class="fas fa-map-marker-alt"></i> Bản Đồ</h3>
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3837.5903579205033!2d108.33225087591964!3d15.87811314452433!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31420dd5cf609957%3A0x5e46b5d87efcfd01!2zMzQ0IE5ndXnhu4VuIER1eSBIaeG7h3UsIEPhuqdtIENow6J1LCBI4buZaSBBbiwgUXXhuqNuZyBOYW1sIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1741750390698!5m2!1svi!2s" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>