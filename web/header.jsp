<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    .new-header {
        background: linear-gradient(45deg, #9c1010, #570808);
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1000;
        transition: all 0.3s ease;
    }

    .new-header:hover {
        background: linear-gradient(45deg, #570808, #9c1010);
    }

    .new-logo {
        font-size: 28px;
        font-weight: 700;
        color: #ffffff;
        text-transform: uppercase;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .new-logo i {
        font-size: 32px;
        color: #ffd700;
    }

    .new-nav-menu {
        display: flex;
        align-items: center;
        gap: 30px;
    }

    .new-nav-menu a {
        color: #ffffff;
        text-decoration: none;
        font-size: 16px;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 15px;
        border-radius: 5px;
        transition: all 0.3s ease;
        position: relative;
    }

    .new-nav-menu a:hover {
        background-color: rgba(255, 255, 255, 0.1);
        color: #ffd700;
    }

    .new-nav-menu i {
        font-size: 18px;
    }

    .new-cart-badge {
        font-size: 0.7rem;
        position: absolute;
        top: 2px;
        right: 5px;
        background: #dc3545;
        color: white;
        padding: 2px 6px;
        border-radius: 50%;
    }

    .new-search-bar {
        position: relative;
        display: flex;
        align-items: center;
    }

    .new-search-bar input {
        padding: 8px 40px 8px 15px;
        border: 2px solid #4d4d4d;
        border-radius: 20px;
        background-color: #2a2a2a;
        color: #ffffff;
        font-size: 14px;
        width: 200px;
        transition: all 0.3s ease;
    }

    .new-search-bar input:focus {
        outline: none;
        border-color: #9c1010;
        box-shadow: 0 0 5px rgba(156, 16, 16, 0.5);
        width: 250px;
    }

    .new-search-bar i {
        position: absolute;
        right: 15px;
        color: #9c1010;
        font-size: 16px;
        cursor: pointer;
    }

    .new-search-bar i:hover {
        color: #ffd700;
    }

    .new-search-error {
        color: #dc3545;
        font-size: 14px;
        display: none;
        margin-top: 5px;
    }

    @media (max-width: 768px) {
        .new-nav-menu {
            gap: 15px;
        }
        .new-search-bar input {
            width: 150px;
        }
        .new-search-bar input:focus {
            width: 180px;
        }
        .new-logo {
            font-size: 22px;
        }
    }

    /* ??y n?i dung xu?ng ?? không b? header che */
    body {
        padding-top: 80px;
    }
</style>

<header class="new-header">
    <div class="new-logo">
        <i class="fas fa-spray-can"></i>
        Perfume Store
    </div>
    <div class="new-nav-menu">
        <div class="new-search-bar">
            <input type="text" placeholder="Tìm ki?m..." id="newSearchInput" name="search">
            <i class="fas fa-search" onclick="performNewSearch()"></i>
            <div class="new-search-error" id="newSearchError">Vui lòng nh?p t? khóa tìm ki?m!</div>
        </div>
        <a href="home"><i class="fas fa-home"></i> Home</a>
        <a href="product"><i class="fas fa-box-open"></i> Products</a>
        <c:if test="${isLoggedIn}">
            <a href="sendEmail"><i class="fas fa-envelope"></i> Contact</a>
            <a href="cart.jsp">
                <i class="fas fa-shopping-cart"></i> Cart
                <span class="new-cart-badge">${sessionScope.cartSize != null ? sessionScope.cartSize : 0}</span>
            </a>
            <a href="profile.jsp"><i class="fas fa-user"></i> ${customer.name}</a>
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </c:if>
        <c:if test="${!isLoggedIn}">
            <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
        </c:if>
    </div>
</header>

<script>
    function performNewSearch() {
        const searchValue = document.getElementById('newSearchInput').value;
        const errorDiv = document.getElementById('newSearchError');

        if (!searchValue.trim()) {
            errorDiv.style.display = 'block';
        } else {
            errorDiv.style.display = 'none';
            window.location.href = 'search?query=' + encodeURIComponent(searchValue);
        }
    }

    document.getElementById('newSearchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            performNewSearch();
        }
    });
</script>