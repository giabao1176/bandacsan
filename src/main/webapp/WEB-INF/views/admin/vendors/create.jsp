<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm nhà bán hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />

<div class="container mt-5">
    <h2><i class="bi bi-plus-circle"></i> Thêm nhà bán hàng</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <div class="alert alert-info" role="alert">
        <i class="bi bi-info-circle"></i> <strong>Lưu ý:</strong> Khi tạo shop cho user, role của user sẽ tự động được cập nhật thành <strong>VENDOR</strong> để có thể quản lý shop.
    </div>
    
    <form action="<c:url value='/admin/vendors/create'/>" method="post">
        <div class="mb-3">
            <label for="userId" class="form-label">Người dùng <span class="text-danger">*</span></label>
            <select class="form-select" id="userId" name="userId" required>
                <option value="">-- Chọn người dùng --</option>
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}">${user.username} - ${user.email}</option>
                </c:forEach>
            </select>
        </div>
        
        <div class="mb-3">
            <label for="storeName" class="form-label">Tên cửa hàng <span class="text-danger">*</span></label>
            <input type="text" class="form-control" id="storeName" name="storeName" required />
        </div>
        
        <div class="mb-3">
            <label for="descriptionVi" class="form-label">Mô tả (Tiếng Việt)</label>
            <textarea class="form-control" id="descriptionVi" name="descriptionVi" rows="3"></textarea>
        </div>
        
        <div class="mb-3">
            <label for="descriptionEn" class="form-label">Mô tả (Tiếng Anh)</label>
            <textarea class="form-control" id="descriptionEn" name="descriptionEn" rows="3"></textarea>
        </div>
        
        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text" class="form-control" id="address" name="address" />
        </div>
        
        <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" id="phone" name="phone" />
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
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

