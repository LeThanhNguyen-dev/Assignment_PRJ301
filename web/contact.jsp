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
    <style>
        .containers {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .contact-info {
            text-align: center;
            margin-bottom: 20px;
        }

        .contact-form {
            max-width: 600px;
            margin: 0 auto;
        }

        .contact-form label {
            display: block;
            margin: 10px 0 5px;
        }

        .contact-form input, 
        .contact-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .contact-form button {
            width: 101%;
            padding: 10px;
            background: #333;
            color: white;
            cursor: pointer;
            border: white solid 2px;
            border-radius: 3px;
        }

        iframe {
            width: 100%;
            height: 300px;
            border: 0;
        }
        .footer {
            margin-top: 100px;
            padding-top: 20px;
            position: relative;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="containers">
        <h2>Liên Hệ</h2>
        <div class="contact-info">
            <p><strong>Địa chỉ:</strong> 344 Nguyễn Duy Hiệu, thành phố Hội An</p>
            <p><strong>Điện thoại:</strong> 0796555878</p>
            <p><strong>Email:</strong> nhungchubedan@gmail.com</p>
        </div>

        <div class="contact-form">
            <h3>Gửi Tin Nhắn</h3>
            <form action="sendEmail" method="post">
                <label for="name">Họ và Tên:</label>
                <input type="text" id="name" name="name" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>

                <label for="message">Nội dung:</label>
                <textarea id="message" name="message" rows="5" required></textarea>

                <button type="submit">Gửi</button>
                <p>${requestScope.messageStatus}</p>
            </form>
        </div>

        <h3>Bản Đồ</h3>
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3837.5903579205033!2d108.33225087591964!3d15.87811314452433!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31420dd5cf609957%3A0x5e46b5d87efcfd01!2zMzQ0IE5ndXnhu4VuIER1eSBIaeG7h3UsIEPhuqdtIENow6J1LCBI4buZaSBBbiwgUXXhuqNuZyBOYW1sIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1741750390698!5m2!1svi!2s" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 footer">
        <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>