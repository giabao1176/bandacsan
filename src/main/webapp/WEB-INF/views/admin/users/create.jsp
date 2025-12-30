<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container mt-5">
    <h2>Thêm người dùng mới</h2>
    <form action="${pageContext.request.contextPath}/admin/users/create" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" name="username" id="username" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" name="email" id="email" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" id="password" required>
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Vai trò</label>
            <select class="form-select" name="role" id="role">
                <option value="CUSTOMER">CUSTOMER</option>
                <option value="ADMIN">ADMIN</option>
                <option value="VENDOR">VENDOR</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy</a>
    </form>
</div>
<jsp:include page="/WEB-INF/common/footer.jsp" />

