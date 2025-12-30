<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/common/header.jsp" />

<div class="container-fluid py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow">
                <div class="card-header bg-warning text-dark">
                    <h3 class="mb-0">
                        <i class="fas fa-user-edit"></i> Chỉnh sửa Người dùng
                    </h3>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/admin/users/save">
                        <input type="hidden" name="id" value="${user.id}" />

                        <div class="mb-3">
                            <label for="username" class="form-label">
                                <i class="fas fa-user"></i> Username
                            </label>
                            <input type="text" id="username" name="username" class="form-control" value="${user.username}" readonly />
                            <small class="form-text text-muted">Username không thể thay đổi</small>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">
                                <i class="fas fa-lock"></i> Mật khẩu mới
                            </label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Để trống nếu không đổi mật khẩu" />
                            <small class="form-text text-muted">Chỉ nhập nếu muốn thay đổi mật khẩu (tối thiểu 6 ký tự)</small>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" id="email" name="email" class="form-control" value="${user.email}" required />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="role" class="form-label">Vai trò</label>
                                <select id="role" name="role" class="form-select">
                                    <option value="CUSTOMER" ${user.role == 'CUSTOMER' ? 'selected' : ''}>CUSTOMER</option>
                                    <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                                    <option value="VENDOR" ${user.role == 'VENDOR' ? 'selected' : ''}>VENDOR</option>
                                </select>
                            </div>
                        </div>

                        <hr>

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                            <div>
                                <button type="button" class="btn btn-danger me-2" onclick="confirmDelete('${user.username}')">
                                    <i class="fas fa-trash"></i> Xóa người dùng
                                </button>
                                <button type="submit" class="btn btn-warning">
                                    <i class="fas fa-save"></i> Cập nhật
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Form xóa ẩn -->
<form id="deleteForm" method="post" action="${pageContext.request.contextPath}/admin/users/delete">
    <input type="hidden" name="username" id="deleteUsername">
</form>

<script>
    function confirmDelete(username) {
        if (confirm('Bạn có chắc chắn muốn xóa người dùng "' + username + '"?\n\nLưu ý: Thao tác này không thể hoàn tác và sẽ xóa tất cả dữ liệu liên quan!')) {
            document.getElementById('deleteUsername').value = username;
            document.getElementById('deleteForm').submit();
        }
    }

    var pwd = document.getElementById('password');
    if (pwd) {
        pwd.addEventListener('input', function() {
            if (this.value.length > 0 && this.value.length < 6) {
                this.setCustomValidity('Mật khẩu phải có ít nhất 6 ký tự');
            } else {
                this.setCustomValidity('');
            }
        });
    }
</script>

<jsp:include page="/WEB-INF/common/footer.jsp" />