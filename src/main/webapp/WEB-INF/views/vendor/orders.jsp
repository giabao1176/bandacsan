<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng - Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-cart-check"></i> Quản lý Đơn hàng</h1>
    
    <!-- Stats Card -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-cart"></i> Tổng đơn hàng</h5>
                    <h3 class="mb-0">${not empty orders ? fn:length(orders) : 0}</h3>
                    <small>Tổng số đơn hàng</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-check-circle"></i> Đã giao</h5>
                    <h3 class="mb-0">0</h3>
                    <small>Đơn hàng đã giao</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-clock"></i> Đang xử lý</h5>
                    <h3 class="mb-0">0</h3>
                    <small>Đơn hàng đang xử lý</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-cash-coin"></i> Tổng doanh thu</h5>
                    <h3 class="mb-0">0 VNĐ</h3>
                    <small>Tổng doanh thu</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-cart-check"></i> Danh sách đơn hàng</h5>
                </div>
                <div class="card-body">
                    <!-- Bảng danh sách -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                            <tr>
                                <th width="5%">ID</th>
                                <th width="20%">Khách hàng</th>
                                <th width="15%">Tổng tiền</th>
                                <th width="15%">Trạng thái</th>
                                <th width="20%">Ngày đặt</th>
                                <th width="25%">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                            <h4 class="mt-3 text-muted">Chưa có đơn hàng</h4>
                                            <p class="text-muted">Chưa có đơn hàng nào trong hệ thống.</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td>${order.id}</td>
                                            <td><strong>${order.user.username}</strong></td>
                                            <td>${order.totalAmount} VNĐ</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'PENDING'}">
                                                        <span class="badge bg-warning">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'PROCESSING'}">
                                                        <span class="badge bg-info">Đang xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'SHIPPING'}">
                                                        <span class="badge bg-primary">Đang giao</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'DELIVERED'}">
                                                        <span class="badge bg-success">Đã giao</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'CANCELLED'}">
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>-</td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-eye"></i> Xem chi tiết
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

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
