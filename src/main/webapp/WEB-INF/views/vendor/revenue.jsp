<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê Doanh thu - Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-cash-coin"></i> Thống kê Doanh thu</h1>
    
    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-cash-stack"></i> Tổng doanh thu</h5>
                    <h3 class="mb-0">0 VNĐ</h3>
                    <small>Tổng doanh thu tất cả thời gian</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-calendar-month"></i> Doanh thu tháng này</h5>
                    <h3 class="mb-0">0 VNĐ</h3>
                    <small>Doanh thu trong tháng hiện tại</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-calendar-week"></i> Doanh thu tuần này</h5>
                    <h3 class="mb-0">0 VNĐ</h3>
                    <small>Doanh thu trong tuần hiện tại</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-cart-check"></i> Tổng đơn hàng</h5>
                    <h3 class="mb-0">0</h3>
                    <small>Tổng số đơn hàng đã bán</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-bar-chart"></i> Lịch sử doanh thu</h5>
                    <div>
                        <select class="form-select form-select-sm" style="width: auto; display: inline-block;">
                            <option>Tháng này</option>
                            <option>Tháng trước</option>
                            <option>3 tháng gần nhất</option>
                            <option>Tất cả</option>
                        </select>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Bảng lịch sử -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                            <tr>
                                <th width="10%">ID</th>
                                <th width="20%">Ngày</th>
                                <th width="20%">Số đơn hàng</th>
                                <th width="25%">Doanh thu</th>
                                <th width="25%">Ghi chú</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">
                                    <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                    <h4 class="mt-3 text-muted">Chưa có dữ liệu</h4>
                                    <p class="text-muted">Chưa có dữ liệu doanh thu.</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Biểu đồ (placeholder) -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-graph-up"></i> Biểu đồ doanh thu</h5>
                </div>
                <div class="card-body">
                    <div class="text-center py-5 text-muted">
                        <i class="bi bi-bar-chart" style="font-size: 4rem; color: #ccc;"></i>
                        <p class="mt-3">Biểu đồ doanh thu sẽ được hiển thị ở đây</p>
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
