<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary px-4">
    <a class="navbar-brand fw-bold" href="<c:url value='/'/>">🌾 Đặc Sản</a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav" aria-controls="#navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <!-- Left Menu -->
        <ul class="navbar-nav me-auto">
            <li class="nav-item"><a class="nav-link" href="<c:url value='/'/>">🏠 Trang chủ</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/user/products'/>">🛍 Sản phẩm</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/user/categories'/>">📂 Danh mục</a></li>
            <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'ADMIN'}">
                <li class="nav-item"><a class="nav-link" href="<c:url value='/admin/home'/>">⚙ Quản trị</a></li>
            </c:if>
            <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'VENDOR'}">
                <li class="nav-item"><a class="nav-link" href="<c:url value='/vendor/dashboard'/>">🏬 Shop</a></li>
            </c:if>
        </ul>

        <!-- Right User Info -->
        <ul class="navbar-nav">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            👤 ${sessionScope.user.username}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="<c:url value='/profile'/>">Thông tin cá nhân</a></li>
                            <c:if test="${sessionScope.user.role == 'VENDOR'}">
                                <li><a class="dropdown-item" href="<c:url value='/vendor/dashboard'/>">Quản lý shop</a></li>
                            </c:if>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>">🚪 Đăng xuất</a></li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item"><a class="btn btn-light" href="<c:url value='/login'/>">🔐 Đăng nhập</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

