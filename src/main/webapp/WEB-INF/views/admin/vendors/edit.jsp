<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa nhà bán hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />

<div class="container mt-5">
    <h2><i class="bi bi-pencil-square"></i> Chỉnh sửa nhà bán hàng</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty vendor}">
        <form action="<c:url value='/admin/vendors/save'/>" method="post">
            <input type="hidden" name="id" value="${vendor.id}" />
            
            <div class="mb-3">
                <label for="userId" class="form-label">Người dùng <span class="text-danger">*</span></label>
                <select class="form-select" id="userId" name="userId" required>
                    <option value="">-- Chọn người dùng --</option>
                    <c:forEach var="user" items="${users}">
                        <option value="${user.id}" ${userId == user.id ? 'selected' : ''}>
                            ${user.username} - ${user.email}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="storeName" class="form-label">Tên cửa hàng <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="storeName" name="storeName" value="${vendor.storeName}" required />
            </div>
            
            <div class="mb-3">
                <label for="descriptionVi" class="form-label">Mô tả (Tiếng Việt)</label>
                <textarea class="form-control" id="descriptionVi" name="descriptionVi" rows="3">${vendor.descriptionVi}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="descriptionEn" class="form-label">Mô tả (Tiếng Anh)</label>
                <textarea class="form-control" id="descriptionEn" name="descriptionEn" rows="3">${vendor.descriptionEn}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="address" name="address" value="${vendor.address}" />
            </div>
            
            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" id="phone" name="phone" value="${vendor.phone}" />
            </div>
            
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-save"></i> Lưu
                </button>
                <a href="<c:url value='/admin/vendors'/>" class="btn btn-secondary">
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

