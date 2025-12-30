<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa danh mục - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />

<div class="container mt-5">
    <h2><i class="bi bi-pencil-square"></i> Chỉnh sửa danh mục</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty category}">
        <form action="<c:url value='/admin/categories/save'/>" method="post">
            <input type="hidden" name="id" value="${category.id}" />
            <div class="mb-3">
                <label for="nameVi" class="form-label">Tên (Tiếng Việt) <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="nameVi" name="nameVi" value="${category.nameVi}" required />
            </div>
            <div class="mb-3">
                <label for="nameEn" class="form-label">Tên (Tiếng Anh)</label>
                <input type="text" class="form-control" id="nameEn" name="nameEn" value="${category.nameEn}" />
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-save"></i> Lưu
                </button>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary">
                    <i class="bi bi-x-circle"></i> Hủy
                </a>
            </div>
        </form>
    </c:if>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
