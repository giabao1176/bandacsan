<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhà bán hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-shop"></i> Quản lý Nhà bán hàng</h1>
    
    <!-- Stats Card -->
    <div class="row mb-4">
        <div class="col-md-12 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-shop"></i> Tổng số nhà bán hàng</h5>
                    <h3 class="mb-0">${not empty vendors ? fn:length(vendors) : 0}</h3>
                    <small>Tổng số nhà bán hàng trong hệ thống</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-shop"></i> Danh sách nhà bán hàng</h5>
                    <a href="<c:url value='/admin/vendors/create'/>" class="btn btn-outline-info">
                        <i class="bi bi-plus-circle"></i> Thêm mới
                    </a>
                </div>
                <div class="card-body">
                    <!-- Thông báo thành công -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle"></i> ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Thông báo lỗi -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Bảng danh sách -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                            <tr>
                                <th width="5%">ID</th>
                                <th width="25%">Tên cửa hàng</th>
                                <th width="15%">Username</th>
                                <th width="20%">Email</th>
                                <th width="15%">Địa chỉ</th>
                                <th width="10%">Số điện thoại</th>
                                <th width="10%">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty vendors}">
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                            <h4 class="mt-3 text-muted">Chưa có dữ liệu</h4>
                                            <p class="text-muted">Bắt đầu quản lý hệ thống bằng cách thêm dữ liệu mới.</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${vendors}" var="v">
                                        <tr>
                                            <td>${v.id}</td>
                                            <td><strong><c:out value="${v.storeName != null ? v.storeName : '-'}"/></strong></td>
                                            <td><c:out value="${v.username != null ? v.username : '-'}"/></td>
                                            <td><c:out value="${v.userEmail != null ? v.userEmail : '-'}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty v.address}">
                                                        ${v.address}
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty v.phone}">
                                                        ${v.phone}
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="<c:url value='/admin/vendors/edit/${v.id}'/>"
                                                   class="btn btn-sm btn-outline-warning">
                                                    <i class="bi bi-pencil"></i> Sửa
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="confirmDelete(${v.id}, '${v.storeName}')">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- Form xóa ẩn -->
<form id="deleteForm" method="post" action="<c:url value='/admin/vendors/delete'/>">
    <input type="hidden" name="id" id="deleteId">
</form>

<script>
    function confirmDelete(id, name) {
        if (confirm('Bạn có chắc chắn muốn xóa nhà bán hàng "' + name + '"?\n\nLưu ý: Thao tác này không thể hoàn tác!')) {
            document.getElementById('deleteId').value = id;
            document.getElementById('deleteForm').submit();
        }
    }
</script>
</div>
<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>