<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh mục Sản phẩm - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-tags"></i> Danh mục Sản phẩm</h1>
    
    <!-- Stats Card -->
    <div class="row mb-4">
        <div class="col-md-12 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-tags"></i> Tổng số danh mục</h5>
                    <h3 class="mb-0">${not empty categories ? fn:length(categories) : 0}</h3>
                    <small>Tổng số danh mục trong hệ thống</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-tags"></i> Danh sách danh mục</h5>
                    <a href="<c:url value='/user/home'/>" class="btn btn-outline-primary">
                        <i class="bi bi-house"></i> Về trang chủ
                    </a>
                </div>
                <div class="card-body">
                    <!-- Bảng danh sách -->
                    <c:choose>
                        <c:when test="${empty categories}">
                            <div class="text-center text-muted py-5">
                                <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                <h4 class="mt-3 text-muted">Chưa có danh mục</h4>
                                <p class="text-muted">Chưa có danh mục nào trong hệ thống.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <c:forEach var="category" items="${categories}">
                                    <div class="col-md-4 col-lg-3 mb-4">
                                        <a href="<c:url value='/user/products?categoryId=${category.id}'/>" class="text-decoration-none">
                                            <div class="card category-card border-0 shadow-sm h-100" style="transition: transform 0.3s, box-shadow 0.3s; cursor: pointer;">
                                                <div class="card-body text-center p-4">
                                                    <div class="category-icon mb-3" style="font-size: 3rem; color: #198754;">
                                                        <i class="bi bi-tag-fill"></i>
                                                    </div>
                                                    <h5 class="card-title mb-2 text-dark fw-bold">
                                                        ${category.nameVi != null ? category.nameVi : 'Danh mục'}
                                                    </h5>
                                                    <c:if test="${not empty category.nameEn}">
                                                        <p class="text-muted small mb-0">${category.nameEn}</p>
                                                    </c:if>
                                                    <div class="mt-3">
                                                        <span class="badge bg-primary">
                                                            <i class="bi bi-arrow-right"></i> Xem sản phẩm
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .category-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.15) !important;
    }
</style>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
