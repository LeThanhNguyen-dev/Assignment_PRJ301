<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="header.jsp" %>

<c:set var="topProductList" value="${requestScope.topProductList}"/>
<c:set var="selectedCategoryId" value="${requestScope.selectedCategoryId}"/>
<c:set var="customerId" value="${sessionScope.customerId}"/> <!-- Lấy customerId từ session -->

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Perfume Elegance - Trang Chủ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background: #f8f9fa;
                color: #2c3e50;
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
            }

            /* Carousel nổi bật */
            #carouselExample {
                width: 100%;
                margin: 100px auto 0;
                padding: 0;
                position: relative;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            }

            .carousel-inner {
                background: linear-gradient(135deg, #f9e9c9 0%, #d4af37 100%);
            }

            .carousel-item img {
                width: 100%;
                height: 600px;
                object-fit: cover;
                border-radius: 0;
                transition: opacity 0.5s ease;
            }

            .carousel-item {
                position: relative;
            }

            .carousel-item::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.2);
                z-index: 1;
            }

            .carousel-control-prev, .carousel-control-next {
                z-index: 2;
            }

            .container {
                max-width: 1200px;
                padding: 40px 15px;
            }

            .section-title {
                font-size: 2rem;
                font-weight: 700;
                color: #2c3e50;
                text-align: center;
                margin-bottom: 30px;
                position: relative;
            }

            .section-title::after {
                content: '';
                width: 60px;
                height: 3px;
                background: #d4af37;
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
            }

            /* Style cho nút Khám Phá Ngay */
            .explore-btn {
                display: block;
                padding: 14px 30px;
                font-size: 1.2rem;
                font-weight: 600;
                text-transform: uppercase;
                border: none;
                border-radius: 50px;
                background: linear-gradient(45deg, #d4af37, #c0a062);
                color: #fff;
                text-decoration: none;
                transition: all 0.4s ease;
                box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
                position: relative;
                overflow: hidden;
                margin: 20px auto;
                width: fit-content;
                text-align: center;
            }

            .explore-btn:hover {
                background: linear-gradient(45deg, #c0a062, #d4af37);
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(212, 175, 55, 0.5);
                color: #fff;
            }

            .explore-btn::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                transform: translate(-50%, -50%);
                transition: width 0.6s ease, height 0.6s ease;
            }

            .explore-btn:hover::before {
                width: 300px;
                height: 300px;
            }

            .explore-btn i {
                margin-left: 8px;
                font-size: 1.1rem;
            }

            .category-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-bottom: 40px;
            }

            .category-btn {
                text-decoration: none;
                padding: 12px 25px;
                font-size: 1rem;
                font-weight: 600;
                text-transform: uppercase;
                border: 2px solid #d4af37;
                border-radius: 30px;
                background: #fff;
                color: #d4af37;
                transition: all 0.3s ease;
            }

            .category-btn:hover, .category-btn.active {
                background: #d4af37;
                color: #fff;
                box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
            }

            .product-card {
                background: #fff;
                border: none;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                min-height: 450px;
                display: flex;
                flex-direction: column;
            }

            .product-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
            }

            .card-img-top {
                height: 300px;
                object-fit: cover;
                width: 100%;
                transition: transform 0.3s ease;
            }

            .product-card:hover .card-img-top {
                transform: scale(1.05);
            }

            .card-body {
                padding: 20px;
                text-align: center;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .card-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 10px;
            }

            .card-text {
                font-size: 0.9rem;
                color: #7f8c8d;
                margin-bottom: 15px;
                flex-grow: 1;
            }

            .price {
                font-size: 1.1rem;
                font-weight: 700;
                color: #d4af37;
            }

            .no-products {
                text-align: center;
                color: #7f8c8d;
                font-style: italic;
                font-size: 1.1rem;
                margin: 20px 0;
            }

            .perfume-intro {
                background: linear-gradient(135deg, #f9e9c9 0%, #ffffff 100%);
                padding: 50px 0;
                margin: 40px 0;
                border-radius: 15px;
                box-shadow: 0 8px 25px rgba(212, 175, 55, 0.2);
                position: relative;
                overflow: hidden;
            }

            .perfume-intro::before {
                content: '';
                position: absolute;
                top: -50px;
                left: -50px;
                width: 150px;
                height: 150px;
                background: rgba(212, 175, 55, 0.2);
                border-radius: 50%;
                z-index: 0;
            }

            .perfume-intro::after {
                content: '';
                position: absolute;
                bottom: -50px;
                right: -50px;
                width: 150px;
                height: 150px;
                background: rgba(212, 175, 55, 0.2);
                border-radius: 50%;
                z-index: 0;
            }

            .intro-content {
                position: relative;
                z-index: 1;
                opacity: 0;
                transform: translateY(30px);
                animation: fadeInUp 1s ease forwards;
            }

            .intro-content h3 {
                font-size: 2rem;
                color: #2c3e50;
                margin-bottom: 20px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .intro-content p {
                font-size: 1.1rem;
                color: #5c6b73;
                line-height: 1.8;
                font-style: italic;
            }

            @keyframes fadeInUp {
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .footer {
                background: #2c3e50;
                color: #ecf0f1;
                padding: 10px 0;
                text-align: center;
                font-size: 0.9rem;
                margin-top: 30px;
            }

            .footer .container {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 15px;
            }

            .footer-column {
                flex: 1;
                min-width: 40px;
            }

            .footer-column h4 {
                font-size: 1.2rem;
                color: #d4af37;
                margin-bottom: 10px;
            }

            .footer-column p, .footer-column a {
                color: #ecf0f1;
                text-decoration: none;
                font-size: 0.85rem;
                line-height: 1.6;
            }

            .footer-column a:hover {
                color: #d4af37;
            }

            .footer-column .social-links a {
                margin: 0 8px;
                font-size: 1.1rem;
            }

            /* CSS cho Chat */
            .chat-bubble {
                position: fixed;
                bottom: 30px;
                right: 30px;
                width: 60px;
                height: 60px;
                background: #d4af37;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease;
                z-index: 1000;
            }

            .chat-bubble:hover {
                transform: scale(1.1);
            }

            .chat-box {
                position: fixed;
                bottom: 100px;
                right: 30px;
                width: 320px;
                height: 420px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
                display: none;
                flex-direction: column;
                overflow: hidden;
                z-index: 1000;
            }

            .chat-header {
                background: #d4af37;
                color: #fff;
                padding: 12px;
                text-align: center;
                font-weight: 600;
                font-size: 1rem;
            }

            .chat-body {
                flex: 1;
                padding: 15px;
                overflow-y: auto;
                background: #f8f9fa;
            }

            .message {
                margin: 8px 0;
                padding: 10px;
                border-radius: 8px;
                max-width: 80%;
                font-size: 0.9rem;
            }

            .user-message {
                background: #d4af37;
                color: #fff;
                align-self: flex-end;
                margin-left: auto;
            }

            .bot-message {
                background: #ecf0f1;
                color: #2c3e50;
                align-self: flex-start;
            }

            .chat-footer {
                padding: 10px;
                border-top: 1px solid #ddd;
                display: flex;
                background: #fff;
            }

            .chat-footer input {
                flex: 1;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 5px 0 0 5px;
                outline: none;
                font-size: 0.9rem;
            }

            .chat-footer button {
                padding: 8px 15px;
                background: #d4af37;
                color: #fff;
                border: none;
                border-radius: 0 5px 5px 0;
                cursor: pointer;
                font-size: 0.9rem;
                transition: background 0.3s ease;
            }

            .chat-footer button:hover {
                background: #c0a062;
            }
        </style>
    </head>
    <body>
        <!-- Carousel -->
        <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/img/Poster1.png" class="d-block w-100" alt="Banner 1">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/Poster2.png" class="d-block w-100" alt="Banner 2">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/img/Poster3.png" class="d-block w-100" alt="Banner 3">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <!-- Nội dung chính -->
        <div class="container">
            <h2 class="section-title">Top 3 Sản Phẩm Nổi Bật - ${selectedCategoryId == 1 ? 'Men' : selectedCategoryId == 2 ? 'Women' : 'Kid'}</h2>

            <!-- Nút danh mục -->
            <div class="category-buttons">
                <a href="home?categoryId=1" class="category-btn ${selectedCategoryId == 1 ? 'active' : ''}">Man</a>
                <a href="home?categoryId=2" class="category-btn ${selectedCategoryId == 2 ? 'active' : ''}">Woman</a>
                <a href="home?categoryId=3" class="category-btn ${selectedCategoryId == 3 ? 'active' : ''}">Kid</a>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="row">
                <c:choose>
                    <c:when test="${not empty topProductList}">
                        <c:forEach var="product" items="${topProductList}">
                            <div class="col-md-4 mb-4">
                                <div class="product-card">
                                    <img src="${pageContext.request.contextPath}/${product.image}" class="card-img-top" alt="${product.name}">
                                    <div class="card-body">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text">${product.description}</p>
                                        <p class="price">
                                            $<fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <p class="no-products">${requestScope.noSalesData != null ? requestScope.noSalesData : 'Hiện chưa có sản phẩm nào trong danh mục này.'}</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Nút Khám Phá Ngay (Di chuyển xuống dưới danh sách sản phẩm) -->
            <a href="${pageContext.request.contextPath}/product" class="explore-btn">
                Khám Phá Ngay <i class="fas fa-arrow-right"></i>
            </a>

            <!-- Section giới thiệu nước hoa -->
            <div class="perfume-intro">
                <div class="container">
                    <div class="intro-content">
                        <h3 class="section-title">Nước Hoa Là Gì?</h3>
                        <p>
                            Nước hoa là một hỗn hợp tinh tế của các tinh dầu thơm, hợp chất tạo hương và dung môi, được sử dụng để mang lại mùi hương dễ chịu cho cơ thể, quần áo hoặc không gian sống. Từ xa xưa, nước hoa đã được xem như biểu tượng của sự sang trọng và cá tính.
                        </p>
                        <h3 class="section-title">Công Dụng Của Nước Hoa</h3>
                        <p>
                            Nước hoa không chỉ giúp bạn tỏa hương thơm quyến rũ mà còn thể hiện phong cách riêng, tăng sự tự tin và tạo ấn tượng lâu dài. Ngoài ra, một số mùi hương còn có khả năng thư giãn tinh thần, giảm căng thẳng và khơi gợi cảm xúc tích cực.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chat Bubble -->
        <div class="chat-bubble" id="chatBubble">
            <i class="fas fa-robot fa-2x"></i>
        </div>

        <!-- Chat Box -->
        <div class="chat-box" id="chatBox">
            <div class="chat-header">Trợ Lý Ảo - Perfume Elegance</div>
            <div class="chat-body" id="chatBody">
                <c:forEach var="message" items="${sessionScope.chatHistory}">
                    <div class="message ${message[0] == 'user' ? 'user-message' : 'bot-message'}">
                        ${message[1]}
                    </div>
                </c:forEach>
            </div>
            <div class="chat-footer">
                <input type="text" id="chatInput" placeholder="Nhập tin nhắn...">
                <button onclick="sendMessage()">Gửi</button>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="footer-column">
                    <h4>Về Perfume Elegance</h4>
                    <p>Chúng tôi mang đến những mùi hương tinh tế, đẳng cấp từ các thương hiệu nổi tiếng thế giới.</p>
                </div>
                <div class="footer-column">
                    <h4>Liên Hệ</h4>
                    <p>Email: support@perfumeelegance.com</p>
                    <p>Hotline: 0909 123 456</p>
                    <p>Địa chỉ: 123 Đường Thơm Ngát, TP. HCM</p>
                </div>
                <div class="footer-column">
                    <h4>Theo Dõi Chúng Tôi</h4>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
            <p style="margin-top: 1px;">© 2025 Perfume Elegance. All rights reserved. <a href="#">Nhung Chu Be Dan</a></p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const chatBubble = document.getElementById("chatBubble");
                        const chatBox = document.getElementById("chatBox");
                        const chatBody = document.getElementById("chatBody");
                        let isFirstOpen = true;
                        const customerId = ${customerId != null ? customerId : 'null'}; // Lấy customerId từ session

                        // Debug: Kiểm tra customerId ngay khi tải trang
                        console.log("Customer ID from session:", customerId);

                        chatBubble.addEventListener("click", function () {
                            if (chatBox.style.display === "none" || chatBox.style.display === "") {
                                chatBox.style.display = "flex";
                                if (isFirstOpen && chatBody.children.length === 0) {
                                    appendMessage("bot", "Chào mừng bạn đến với Perfume Elegance! Tôi có thể giúp gì cho bạn?");
                                    isFirstOpen = false;
                                }
                                scrollToBottom();
                            } else {
                                chatBox.style.display = "none";
                            }
                        });

                        function scrollToBottom() {
                            chatBody.scrollTop = chatBody.scrollHeight;
                        }

                        window.sendMessage = function () {
                            const input = document.getElementById("chatInput");
                            const message = input.value.trim();
                            if (message) {
                                appendMessage("user", message);
                                let url = "${pageContext.request.contextPath}/chat?prompt=" + encodeURIComponent(message);
                                if (customerId !== null) {
                                    url += "&customerId=" + customerId; // Thêm customerId vào request nếu có
                                }
                                console.log("Sending request to:", url); // Debug: Kiểm tra URL gửi đi
                                fetch(url, {
                                    method: "GET"
                                })
                                        .then(response => response.text())
                                        .then(data => {
                                            console.log("Response from server:", data); // Debug: Kiểm tra phản hồi
                                            appendMessage("bot", data);
                                        })
                                        .catch(error => {
                                            console.error("Error:", error);
                                            appendMessage("bot", "Lỗi: " + error.message);
                                        });
                                input.value = "";
                                scrollToBottom();
                            }
                        };

                        function appendMessage(sender, text) {
                            const messageDiv = document.createElement("div");
                            messageDiv.className = "message " + (sender === "user" ? "user-message" : "bot-message");
                            messageDiv.textContent = text;
                            chatBody.appendChild(messageDiv);
                            scrollToBottom();
                        }

                        document.getElementById("chatInput").addEventListener("keypress", function (e) {
                            if (e.key === "Enter") {
                                sendMessage();
                            }
                        });
                    });
        </script>
    </body>
</html>