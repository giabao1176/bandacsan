<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="bg-dark text-light py-5 mt-5">
    <div class="container">
        <div class="row">
            <!-- Thông tin công ty -->
            <div class="col-md-4 mb-4">
                <h5 class="mb-3">
                    <i class="bi bi-shop"></i> Đặc Sản Quê Hương
                </h5>
                <p class="text-muted">
                    Website quảng bá và kinh doanh đặc sản quê hương Việt Nam. 
                    Chúng tôi mang đến những món ăn đậm đà bản sắc dân tộc.
                </p>
            </div>

            <!-- Liên kết nhanh -->
            <div class="col-md-2 mb-4">
                <h6 class="mb-3">Liên kết nhanh</h6>
                <ul class="list-unstyled">
                    <li class="mb-2">
                        <a href="<c:url value='/'/>" class="text-decoration-none text-muted">
                            <i class="bi bi-house"></i> Trang chủ
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="<c:url value='/user/products'/>" class="text-decoration-none text-muted">
                            <i class="bi bi-box-seam"></i> Sản phẩm
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="<c:url value='/user/categories'/>" class="text-decoration-none text-muted">
                            <i class="bi bi-tags"></i> Danh mục
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Liên hệ -->
            <div class="col-md-3 mb-4">
                <h6 class="mb-3">Liên hệ</h6>
                <ul class="list-unstyled text-muted">
                    <li class="mb-2">
                        <i class="bi bi-envelope"></i> Email: info@dacsanquehuong.com
                    </li>
                    <li class="mb-2">
                        <i class="bi bi-telephone"></i> Hotline: 1900-xxxx
                    </li>
                    <li class="mb-2">
                        <i class="bi bi-geo-alt"></i> Địa chỉ: Việt Nam
                    </li>
                </ul>
            </div>

            <!-- Mạng xã hội -->
            <div class="col-md-3 mb-4">
                <h6 class="mb-3">Theo dõi chúng tôi</h6>
                <div class="d-flex gap-3">
                    <a href="#" class="text-light text-decoration-none" title="Facebook">
                        <i class="bi bi-facebook" style="font-size: 1.5rem;"></i>
                    </a>
                    <a href="#" class="text-light text-decoration-none" title="Instagram">
                        <i class="bi bi-instagram" style="font-size: 1.5rem;"></i>
                    </a>
                    <a href="#" class="text-light text-decoration-none" title="YouTube">
                        <i class="bi bi-youtube" style="font-size: 1.5rem;"></i>
                    </a>
                    <a href="#" class="text-light text-decoration-none" title="Zalo">
                        <i class="bi bi-chat-dots" style="font-size: 1.5rem;"></i>
                    </a>
                </div>
            </div>
        </div>

        <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">

        <!-- Copyright -->
        <div class="row">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0 text-muted">
                    &copy; <%= java.time.Year.now() %> Đặc Sản Quê Hương. Tất cả quyền được bảo lưu.
                </p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <p class="mb-0 text-muted">
                    <i class="bi bi-person-badge"></i> Sinh viên: <strong>23110101 - Đặng Gia Huy</strong>
                </p>
            </div>
        </div>
    </div>
</footer>
