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
    <title>Shop Nước Hoa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f5f5 0%, #d3d3d3 100%);
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .product-card {
            transition: transform 0.3s;
            background: #ffffff;
            border: 2px solid #ccc;
        }

        .product-card:hover {
            transform: scale(1.05);
            border-color: #d4af37;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .card-img-top {
            height: 350px;
            object-fit: cover;
            width: 100%;
        }

        .card-title {
            color: #d4af37;
        }

        .card-text {
            color: #666;
        }

        .card-text strong {
            color: #333;
        }

        #carouselExample {
            max-width: 90%;
            margin: 1rem auto;
            padding: 1rem 0;
        }

        .carousel-inner {
            display: flex;
            align-items: center;
        }

        .carousel-item img {
            max-width: 100%;
            height: 550px;
            object-fit: cover;
            width: 100%;
            border-radius: 8px;
        }

        .footer {
            background: linear-gradient(90deg, #e0e0e0, #c0c0c0);
            color: #333;
            text-align: center;
            padding: 20px 0;
            margin-top: 10px;
            position: relative;
            bottom: 0;
            width: 100%;
            box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.1);
        }

        .category-buttons {
            text-align: center;
            margin-bottom: 20px;
        }

        .category-btn {
            margin: 0 10px;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .category-btn.active {
            background: linear-gradient(45deg, #d4af37, #c0a062);
            color: #fff;
        }

        .no-products {
            text-align: center;
            color: #666;
            font-style: italic;
        }

        /* CSS cho bong bóng chat */
        .chat-bubble {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #d4af37, #c0a062);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: all 0.3s;
            z-index: 1000;
        }

        .chat-bubble:hover {
            transform: scale(1.1);
        }

        .chat-box {
            position: fixed;
            bottom: 90px;
            right: 20px;
            width: 300px;
            height: 400px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            display: none;
            flex-direction: column;
            overflow: hidden;
            z-index: 1000;
        }

        .chat-header {
            background: linear-gradient(45deg, #d4af37, #c0a062);
            color: #fff;
            padding: 10px;
            text-align: center;
            font-weight: bold;
        }

        .chat-body {
            flex: 1;
            padding: 10px;
            overflow-y: auto;
            background: #f9f9f9;
        }

        .message {
            margin: 5px 0;
            padding: 8px;
            border-radius: 5px;
            max-width: 80%;
        }

        .user-message {
            background: #d4af37;
            color: #fff;
            align-self: flex-end;
            margin-left: auto;
        }

        .bot-message {
            background: #e0e0e0;
            color: #333;
            align-self: flex-start;
        }

        .chat-footer {
            padding: 10px;
            border-top: 1px solid #ddd;
            display: flex;
        }

        .chat-footer input {
            flex: 1;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
            outline: none;
        }

        .chat-footer button {
            padding: 5px 10px;
            background: linear-gradient(45deg, #d4af37, #c0a062);
            color: #fff;
            border: none;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }

        .chat-footer button:hover {
            background: linear-gradient(45deg, #c0a062, #d4af37);
        }
    </style>
</head>

<body>
    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="${pageContext.request.contextPath}/img/banner_welcome.png" class="d-block w-100" alt="Banner 1">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/img/Blue-And-White-Modern-New-Product-Facebook-Ad-1024x536.png" class="d-block w-100" alt="Banner 3">
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/img/476498250_1622121185087076_4096243358621469653_n.png" class="d-block w-100" alt="Banner 2">
            </div>
        </div>
        <button class="carousel-control-prev" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <div class="container mt-5">
        <h2 class="text-center mb-4">Top 3 Sản Phẩm Bán Chạy Nhất (Danh mục ${selectedCategoryId == 1 ? 'Men' : selectedCategoryId == 2 ? 'Women' : 'Kid'})</h2>
        
        <div class="category-buttons">
            <a href="home?categoryId=1" class="btn category-btn ${selectedCategoryId == 1 ? 'active' : ''}">Men</a>
            <a href="home?categoryId=2" class="btn category-btn ${selectedCategoryId == 2 ? 'active' : ''}">Women</a>
            <a href="home?categoryId=3" class="btn category-btn ${selectedCategoryId == 3 ? 'active' : ''}">Kid</a>
        </div>

        <div class="row">
            <c:choose>
                <c:when test="${not empty topProductList}">
                    <c:forEach var="product" items="${topProductList}">
                        <div class="col-md-4 mb-4 d-flex align-items-stretch">
                            <div class="card w-100 product-card">
                                <img src="${pageContext.request.contextPath}/${product.image}" class="card-img-top img-fluid" alt="${product.name}">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${product.name}</h5>
                                    <p class="card-text flex-grow-1">${product.description}</p>
                                    <p class="card-text"><strong>Giá: </strong><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"/> VNĐ</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <p class="no-products">Hiện chưa có sản phẩm nào trong danh mục này.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Bong bóng chat -->
    <div class="chat-bubble" id="chatBubble">
        <i class="fas fa-robot fa-2x"></i>
    </div>

    <!-- Khung chat -->
    <div class="chat-box" id="chatBox">
        <div class="chat-header">Hỗ trợ khách hàng</div>
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

    <footer class="footer">
        <p>© 2025 Perfume Store. Copyright nhung chu be dan.</p>
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
                        appendMessage("bot", "Chào mừng bạn tới với Perfume Shop của chúng tôi!");
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

            window.sendMessage = function() {
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

            document.getElementById("chatInput").addEventListener("keypress", function(e) {
                if (e.key === "Enter") {
                    sendMessage();
                }
            });
        });
    </script>
</body>
</html>