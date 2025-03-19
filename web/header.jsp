<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="customer" value="${sessionScope.session_Login}"/>
<c:set var="isLoggedIn" value="${customer != null}"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    .new-header {
        background: linear-gradient(90deg, #f5f5f5, #d3d3d3);
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1000;
        transition: all 0.3s ease;
    }

    .new-header:hover {
        background: linear-gradient(90deg, #e0e0e0, #c0c0c0);
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
    }

    .new-logo {
        font-size: 28px;
        font-weight: 700;
        color: #333;
        text-transform: uppercase;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .new-logo i {
        font-size: 32px;
        color: #d4af37; /* V�ng nh?t sang tr?ng */
        transition: color 0.3s ease;
    }

    .new-logo:hover i {
        color: #c0a062; /* V�ng ??m h?n khi hover */
    }

    .new-nav-menu {
        display: flex;
        align-items: center;
        gap: 30px;
    }

    .new-nav-menu a {
        color: #333;
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
        background-color: rgba(212, 175, 55, 0.1); /* V�ng nh?t trong su?t */
        color: #d4af37; /* V�ng sang tr?ng */
        transform: translateY(-2px);
    }

    .new-nav-menu i {
        font-size: 18px;
        transition: color 0.3s ease;
    }

    .new-nav-menu a:hover i {
        color: #d4af37;
    }

    .new-cart-badge {
        font-size: 0.7rem;
        position: absolute;
        top: 2px;
        right: 5px;
        background: #dc3545; /* ?? cho badge */
        color: white;
        padding: 2px 6px;
        border-radius: 50%;
        transition: transform 0.3s ease;
    }

    .new-nav-menu a:hover .new-cart-badge {
        transform: scale(1.1);
    }

    .new-search-bar {
        position: relative;
        display: flex;
        align-items: center;
    }

    .new-search-bar input {
        padding: 8px 40px 8px 15px;
        border: 2px solid #ccc;
        border-radius: 20px;
        background-color: #ffffff;
        color: #333;
        font-size: 14px;
        width: 200px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }

    .new-search-bar input:focus {
        outline: none;
        border-color: #d4af37; /* V�ng nh?t khi focus */
        box-shadow: 0 4px 8px rgba(212, 175, 55, 0.2);
        width: 250px;
    }

    .new-search-bar i {
        position: absolute;
        right: 15px;
        color: #666;
        font-size: 16px;
        cursor: pointer;
        transition: color 0.3s ease;
    }

    .new-search-bar i:hover {
        color: #d4af37;
    }

    .new-search-error {
        color: #dc3545;
        font-size: 14px;
        display: none;
        margin-top: 5px;
        transition: opacity 0.3s ease;
    }

    .new-search-error.show {
        display: block;
        opacity: 1;
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

    /* ??y n?i dung xu?ng ?? kh�ng b? header che */
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
            <input type="text" placeholder="T�m ki?m..." id="newSearchInput" name="search">
            <i class="fas fa-search" onclick="performNewSearch()"></i>
            <div class="new-search-error" id="newSearchError">Vui l�ng nh?p t? kh�a t�m ki?m!</div>
        </div>
        <a href="home"><i class="fas fa-home"></i> Home</a>
        <a href="product"><i class="fas fa-box-open"></i> Products</a>
        <c:if test="${isLoggedIn}">
            <a href="sendEmail"><i class="fas fa-envelope"></i> Contact</a>
            <a href="cart.jsp" class="position-relative">
                <i class="fas fa-shopping-cart"></i> Cart
                <span class="new-cart-badge">${sessionScope.cartSize != null ? sessionScope.cartSize : 0}</span>
            </a>
            <a href="profile"><i class="fas fa-user"></i> ${customer.name}</a>
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
            errorDiv.classList.add('show');
        } else {
            errorDiv.classList.remove('show');
            window.location.href = 'search?query=' + encodeURIComponent(searchValue);
        }
    }

    document.getElementById('newSearchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            performNewSearch();
        }
    });
</script>