<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Đặc sản Việt Nam - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp"/>

<!-- Hero Section -->
<div class="hero-section mb-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 20px; padding: 60px 40px; color: white; text-align: center; margin-top: 30px;">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8 mx-auto">
                <i class="bi bi-journal-text display-4 mb-3 animate__animated animate__bounceIn"></i>
                <h1 class="display-4 fw-bold mb-3 animate__animated animate__fadeInUp">
                    <c:choose>
                        <c:when test="${isMyBlogs}">Bài viết của tôi</c:when>
                        <c:otherwise>Blog Đặc sản Việt Nam</c:otherwise>
                    </c:choose>
                </h1>
                <p class="lead mb-4 animate__animated animate__fadeInUp animate__delay-1s">
                    Khám phá những câu chuyện thú vị về đặc sản quê hương và văn hóa ẩm thực Việt Nam
                </p>
                <c:if test="${not empty sessionScope.user}">
                    <div class="d-flex justify-content-center gap-3 animate__animated animate__fadeInUp animate__delay-2s">
                        <a href="<c:url value='/user/blogs/create'/>" class="btn btn-light btn-lg pulse">
                            <i class="bi bi-plus-circle"></i> Viết bài mới
                        </a>
                        <c:if test="${!isMyBlogs}">
                            <a href="<c:url value='/user/blogs/my-blogs'/>" class="btn btn-outline-light btn-lg">
                                <i class="bi bi-person"></i> Bài viết của tôi
                            </a>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="container page-transition">

    <!-- Search Bar -->
    <div class="card mb-4 search-container shadow-sm animate__animated animate__fadeInUp">
        <div class="card-body">
            <form method="GET" action="<c:url value='/user/blogs'/>" class="row g-3">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text bg-primary text-white">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" name="search" class="form-control"
                               placeholder="Tìm kiếm bài viết theo tiêu đề hoặc nội dung..."
                               value="${searchKeyword}">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary flex-fill">
                            <i class="bi bi-search"></i> Tìm kiếm
                        </button>
                        <c:if test="${not empty searchKeyword}">
                            <a href="<c:url value='/user/blogs'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle"></i>
                            </a>
                        </c:if>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show animate__animated animate__slideInRight" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__slideInRight" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Blog List -->
    <c:choose>
        <c:when test="${empty blogs}">
            <div class="card text-center py-5 animate__animated animate__fadeInUp">
                <div class="card-body">
                    <i class="bi bi-journal-x display-1 text-muted mb-4"></i>
                    <h4 class="text-muted mb-3">
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">
                                Không tìm thấy bài viết nào phù hợp với "<strong>${searchKeyword}</strong>"
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${isMyBlogs}">Bạn chưa có bài viết nào</c:when>
                                    <c:otherwise>Chưa có bài viết nào</c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </h4>
                    <p class="text-muted mb-4">
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">Hãy thử tìm với từ khóa khác</c:when>
                            <c:otherwise>Hãy là người đầu tiên chia sẻ kiến thức về đặc sản Việt Nam</c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${not empty sessionScope.user and empty searchKeyword}">
                        <a href="<c:url value='/user/blogs/create'/>" class="btn btn-primary btn-lg">
                            <i class="bi bi-plus-circle me-2"></i>
                            <c:choose>
                                <c:when test="${isMyBlogs}">Viết bài viết đầu tiên</c:when>
                                <c:otherwise>Tạo bài viết mới</c:otherwise>
                            </c:choose>
                        </a>
                    </c:if>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach var="blog" items="${blogs}" varStatus="status">
                    <div class="col-lg-6 col-xl-4">
                        <article class="blog-card-modern h-100 animate__animated animate__fadeInUp"
                                 style="animation-delay: ${status.index * 0.1}s;">
                            <c:if test="${not empty blog.imageUrl}">
                                <div class="blog-image-wrapper">
                                    <img src="${blog.imageUrl}" class="blog-card-image" alt="${blog.titleVi}">
                                    <div class="blog-image-overlay">
                                        <a href="<c:url value='/user/blogs/${blog.id}'/>" class="btn btn-light btn-sm">
                                            <i class="bi bi-arrow-right me-1"></i>Đọc thêm
                                        </a>
                                    </div>
                                    <div class="blog-badge">
                                        <i class="bi bi-bookmark-fill"></i>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${empty blog.imageUrl}">
                                <div class="blog-image-wrapper bg-gradient-primary d-flex align-items-center justify-content-center" style="height: 200px;">
                                    <i class="bi bi-journal-text text-white" style="font-size: 4rem; opacity: 0.3;"></i>
                                </div>
                            </c:if>
                            
                            <div class="blog-card-content">
                                <div class="blog-meta mb-2">
                                    <span class="blog-author">
                                        <i class="bi bi-person-circle me-1"></i>
                                        ${blog.authorName}
                                    </span>
                                    <span class="blog-date">
                                        <i class="bi bi-calendar3 me-1"></i>
                                        ${blog.formattedCreatedAt}
                                    </span>
                                </div>
                                
                                <h3 class="blog-title">
                                    <a href="<c:url value='/user/blogs/${blog.id}'/>" class="text-decoration-none">
                                        ${blog.titleVi}
                                    </a>
                                </h3>
                                
                                <p class="blog-excerpt">${blog.summaryVi}</p>
                                
                                <div class="blog-footer">
                                    <c:if test="${not empty blog.products}">
                                        <span class="blog-tag">
                                            <i class="bi bi-tag-fill me-1"></i>
                                            ${blog.products.size()} sản phẩm
                                        </span>
                                    </c:if>
                                    
                                    <c:if test="${sessionScope.user.id == blog.authorId}">
                                        <div class="blog-actions ms-auto">
                                            <a href="<c:url value='/user/blogs/edit/${blog.id}'/>" 
                                               class="btn btn-sm btn-outline-primary" 
                                               title="Chỉnh sửa">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <button type="button" 
                                                    class="btn btn-sm btn-outline-danger"
                                                    onclick="deleteBlog(${blog.id}, '${blog.titleVi}')"
                                                    title="Xóa">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </article>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
/* Hero Section */
.hero-section {
    position: relative;
    overflow: hidden;
}

.hero-section::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
    background-size: 50px 50px;
    animation: float 20s infinite linear;
}

@keyframes float {
    0% { transform: translate(-50%, -50%) rotate(0deg); }
    100% { transform: translate(-50%, -50%) rotate(360deg); }
}

/* Modern Blog Cards */
.blog-card-modern {
    background: white;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 5px 25px rgba(0,0,0,0.08);
    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    display: flex;
    flex-direction: column;
    border: 1px solid rgba(0,0,0,0.05);
}

.blog-card-modern:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
    border-color: rgba(102, 126, 234, 0.3);
}

.blog-image-wrapper {
    position: relative;
    overflow: hidden;
    height: 220px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.blog-card-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.blog-card-modern:hover .blog-card-image {
    transform: scale(1.15);
}

.blog-image-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(to bottom, transparent 0%, rgba(0,0,0,0.7) 100%);
    display: flex;
    align-items: flex-end;
    justify-content: center;
    padding: 20px;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.blog-card-modern:hover .blog-image-overlay {
    opacity: 1;
}

.blog-badge {
    position: absolute;
    top: 15px;
    right: 15px;
    width: 40px;
    height: 40px;
    background: rgba(255,255,255,0.95);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #667eea;
    font-size: 1.2rem;
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    transition: transform 0.3s ease;
}

.blog-card-modern:hover .blog-badge {
    transform: scale(1.1) rotate(15deg);
}

.blog-card-content {
    padding: 25px;
    flex: 1;
    display: flex;
    flex-direction: column;
}

.blog-meta {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
    font-size: 0.85rem;
    color: #6c757d;
}

.blog-author, .blog-date {
    display: flex;
    align-items: center;
}

.blog-author i, .blog-date i {
    color: #667eea;
}

.blog-title {
    font-size: 1.35rem;
    font-weight: 700;
    margin: 15px 0;
    line-height: 1.4;
}

.blog-title a {
    color: #2c3e50;
    transition: color 0.3s ease;
}

.blog-title a:hover {
    color: #667eea;
}

.blog-excerpt {
    color: #6c757d;
    font-size: 0.95rem;
    line-height: 1.7;
    margin-bottom: 20px;
    flex: 1;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.blog-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding-top: 15px;
    border-top: 1px solid rgba(0,0,0,0.08);
}

.blog-tag {
    display: inline-flex;
    align-items: center;
    padding: 6px 12px;
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
    color: #667eea;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 500;
}

.blog-actions {
    display: flex;
    gap: 8px;
}

.blog-actions .btn {
    width: 36px;
    height: 36px;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.blog-actions .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

/* Badge */
.badge {
    font-size: 0.75rem;
    padding: 0.375rem 0.75rem;
}

/* Button Improvements */
.btn {
    font-weight: 500;
    letter-spacing: 0.5px;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.btn-primary:hover {
    background: linear-gradient(135deg, #5a67d8 0%, #764ba2 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

/* Search Container */
.search-container {
    border-radius: 15px;
    border: none;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
}

/* Empty State */
.card h4 {
    font-weight: 600;
    color: #6c757d;
}

/* Pulse Animation */
.pulse {
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

/* Responsive Improvements */
@media (max-width: 768px) {
    .hero-section {
        padding: 40px 20px;
        margin-top: 20px;
    }

    .hero-section .display-4 {
        font-size: 2rem;
    }

    .blog-card-modern {
        margin-bottom: 1.5rem;
    }
    
    .blog-image-wrapper {
        height: 180px;
    }
    
    .blog-title {
        font-size: 1.15rem;
    }
    
    .blog-card-content {
        padding: 20px;
    }
}
</style>

<script>
// Delete blog confirmation
function deleteBlog(blogId, title) {
    if (confirm('Bạn có chắc muốn xóa bài viết "' + title + '"?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '<c:url value="/user/blogs/delete/"/>' + blogId;

        // Add CSRF token if needed
        const csrfInput = document.createElement('input');
        csrfInput.type = 'hidden';
        csrfInput.name = '${_csrf.parameterName}';
        csrfInput.value = '${_csrf.token}';
        form.appendChild(csrfInput);

        document.body.appendChild(form);
        form.submit();
    }
}
</script>

<jsp:include page="/WEB-INF/common/footer.jsp"/>
<jsp:include page="/WEB-INF/common/Toast.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
