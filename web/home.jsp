<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="header.jsp" %>

<c:set var="topProductList" value="${requestScope.topProductList}"/>
<c:set var="selectedCategoryId" value="${requestScope.selectedCategoryId}"/>

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


            #carouselExample {
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                padding: 1rem 0;
            }

            .carousel-item img {
                width: 100%;
                height: auto;
                max-height: 550px;
                object-fit: contain;
                border-radius: 8px;
            }

            .carousel-item img:hover {
                transform: scale(1.05);
            }

            /* Container chính */
            .container {
                max-width: 1200px;
                padding: 40px 15px;
            }

            /* Tiêu đề */
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

            /* Nút danh mục */
            .category-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-bottom: 40px;
            }

            .category-btn {
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

            /* Thẻ sản phẩm */
            .product-card {
                background: #fff;
                border: none;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
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

            /* Footer */
            .footer {
                background: #2c3e50;
                color: #ecf0f1;
                padding: 30px 0;
                text-align: center;
                font-size: 0.9rem;
                margin-top: 50px;
            }

            .footer a {
                color: #d4af37;
                text-decoration: none;
            }

            /* Chat bubble */
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
                <a href="home?categoryId=1" class="category-btn ${selectedCategoryId == 1 ? 'active' : ''}">Men</a>
                <a href="home?categoryId=2" class="category-btn ${selectedCategoryId == 2 ? 'active' : ''}">Women</a>
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
            <p>&copy; 2025 Perfume Elegance. All rights reserved. <a href="#">Nhung Chu Be Dan</a></p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const chatBubble = document.getElementById("chatBubble");
                        const chatBox = document.getElementById("chatBox");
                        const chatBody = document.getElementById("chatBody");
                        let isFirstOpen = true;

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
                                fetch("${pageContext.request.contextPath}/chat?prompt=" + encodeURIComponent(message), {
                                    method: "GET"
                                })
                                        .then(response => response.text())
                                        .then(data => {
                                            appendMessage("bot", data);
                                        })
                                        .catch(error => {
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