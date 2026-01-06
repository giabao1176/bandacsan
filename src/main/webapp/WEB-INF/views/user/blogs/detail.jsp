<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${blog.titleVi} - Blog Đặc sản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp"/>

<!-- Hero Section with Blog Title -->
<div class="blog-hero-section mb-5">
    <div class="hero-background"></div>
    <div class="hero-pattern"></div>
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-10 mx-auto">
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb justify-content-center bg-white bg-opacity-20 backdrop-blur p-2 rounded-pill">
                        <li class="breadcrumb-item">
                            <a href="<c:url value='/user/blogs'/>" class="text-white text-decoration-none">
                                <i class="bi bi-house-door me-1"></i>Blog
                            </a>
                        </li>
                        <li class="breadcrumb-item active text-white-50">
                            <i class="bi bi-chevron-right me-1"></i>${blog.titleVi}
                        </li>
                    </ol>
                </nav>
                <div class="hero-content text-center">
                    <h1 class="blog-hero-title animate__animated animate__fadeInUp">${blog.titleVi}</h1>
                    <p class="blog-hero-subtitle animate__animated animate__fadeInUp animate__delay-1s">${blog.summaryVi}</p>
                    <div class="blog-hero-meta animate__animated animate__fadeInUp animate__delay-2s">
                        <div class="meta-item">
                            <div class="meta-icon">
                                <i class="bi bi-person-circle"></i>
                            </div>
                            <div class="meta-content">
                                <span class="meta-label">Tác giả</span>
                                <span class="meta-value">${blog.authorName}</span>
                            </div>
                        </div>
                        <div class="meta-item">
                            <div class="meta-icon">
                                <i class="bi bi-calendar3"></i>
                            </div>
                            <div class="meta-content">
                                <span class="meta-label">Ngày đăng</span>
                                <span class="meta-value">${blog.formattedCreatedAt}</span>
                            </div>
                        </div>
                        <c:if test="${blog.updatedAt != null and blog.updatedAt != blog.createdAt}">
                            <div class="meta-item">
                                <div class="meta-icon">
                                    <i class="bi bi-pencil-square"></i>
                                </div>
                                <div class="meta-content">
                                    <span class="meta-label">Cập nhật</span>
                                    <span class="meta-value">${blog.formattedUpdatedAt}</span>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container page-transition">
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

    <div class="row">
        <!-- Main Content -->
        <div class="col-lg-8">
            <article class="blog-post animate__animated animate__fadeInUp">
                <!-- Blog Image -->
                <c:if test="${not empty blog.imageUrl}">
                    <div class="blog-featured-image mb-5">
                        <div class="image-frame">
                            <img src="${blog.imageUrl}" class="img-fluid" alt="${blog.titleVi}">
                            <div class="image-shine"></div>
                        </div>
                    </div>
                </c:if>

                <!-- Blog Content -->
                <div class="blog-content-wrapper mb-5">
                    <article class="blog-article">
                        <div class="article-content">
                            ${blog.contentVi}
                        </div>
                    </article>
                </div>
            </article>

            <!-- Related Products -->
            <c:if test="${not empty blog.products}">
                <div class="related-products-section mb-5">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="bi bi-tag-fill"></i>
                        </div>
                        <div>
                            <h3 class="section-title">Sản phẩm liên quan</h3>
                            <p class="section-subtitle">${blog.products.size()} sản phẩm được đề cập trong bài viết</p>
                        </div>
                    </div>
                    <div class="products-grid">
                        <c:forEach var="product" items="${blog.products}">
                            <div class="product-card-modern">
                                <div class="product-image-container">
                                    <c:if test="${not empty product.imageUrls && product.imageUrls.size() > 0}">
                                        <img src="${product.imageUrls[0]}" alt="${product.nameVi}" class="product-image">
                                    </c:if>
                                    <c:if test="${empty product.imageUrls || product.imageUrls.size() == 0}">
                                        <div class="product-image-placeholder">
                                            <i class="bi bi-image"></i>
                                        </div>
                                    </c:if>
                                    <div class="product-overlay">
                                        <a href="<c:url value='/user/products/${product.id}'/>" class="btn btn-light btn-sm">
                                            <i class="bi bi-eye me-1"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                                <div class="product-info">
                                    <h6 class="product-name">
                                        <a href="<c:url value='/user/products/${product.id}'/>" class="text-decoration-none">
                                            ${product.nameVi}
                                        </a>
                                    </h6>
                                    <div class="product-meta">
                                        <c:if test="${not empty product.categories}">
                                            <c:forEach var="category" items="${product.categories}" begin="0" end="0">
                                                <span class="product-category">${category}</span>
                                            </c:forEach>
                                        </c:if>
                                        <span class="product-price">
                                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Author Info -->
            <div class="card mb-4 shadow-sm animate__animated animate__fadeInRight animate__delay-1s">
                <div class="card-header bg-gradient-primary text-white">
                    <h6 class="mb-0">
                        <i class="bi bi-person-circle-fill me-2"></i>
                        Tác giả bài viết
                    </h6>
                </div>
                <div class="card-body text-center">
                    <div class="author-avatar mb-3">
                        <i class="bi bi-person-circle display-4 text-primary"></i>
                    </div>
                    <h6 class="fw-bold mb-2">${blog.authorName}</h6>
                    <p class="text-muted small mb-3">Người viết blog</p>

                    <c:if test="${sessionScope.user.id == blog.authorId}">
                        <div class="d-grid gap-2">
                            <a href="<c:url value='/user/blogs/edit/${blog.id}'/>" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-pencil-square me-1"></i>Chỉnh sửa bài viết
                            </a>
                            <button type="button" class="btn btn-outline-danger btn-sm"
                                    onclick="deleteBlog(${blog.id}, '${blog.titleVi}')">
                                <i class="bi bi-trash me-1"></i>Xóa bài viết
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Blog Stats -->
            <div class="card mb-4 shadow-sm animate__animated animate__fadeInRight animate__delay-2s">
                <div class="card-header bg-success text-white">
                    <h6 class="mb-0">
                        <i class="bi bi-bar-chart-line-fill me-2"></i>
                        Thống kê bài viết
                    </h6>
                </div>
                <div class="card-body">
                    <div class="stats-item d-flex align-items-center mb-3">
                        <i class="bi bi-calendar-event text-primary me-3 fs-5"></i>
                        <div>
                            <div class="fw-bold">
                                ${blog.formattedCreatedAt}
                            </div>
                            <small class="text-muted">Ngày đăng</small>
                        </div>
                    </div>
                    <div class="stats-item d-flex align-items-center mb-3">
                        <i class="bi bi-eye text-success me-3 fs-5"></i>
                        <div>
                            <div class="fw-bold">Chưa có</div>
                            <small class="text-muted">Lượt xem</small>
                        </div>
                    </div>
                    <div class="stats-item d-flex align-items-center">
                        <i class="bi bi-tag text-warning me-3 fs-5"></i>
                        <div>
                            <div class="fw-bold">${blog.products.size()}</div>
                            <small class="text-muted">Sản phẩm liên quan</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Navigation -->
            <div class="card shadow-sm animate__animated animate__fadeInRight animate__delay-3s">
                <div class="card-header bg-info text-white">
                    <h6 class="mb-0">
                        <i class="bi bi-compass-fill me-2"></i>
                        Điều hướng
                    </h6>
                </div>
                <div class="card-body d-grid gap-2">
                    <a href="<c:url value='/user/blogs'/>" class="btn btn-outline-primary">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại Blog
                    </a>
                    <c:if test="${not empty sessionScope.user}">
                        <a href="<c:url value='/user/blogs/create'/>" class="btn btn-primary">
                            <i class="bi bi-plus-circle me-2"></i>Viết bài mới
                        </a>
                        <a href="<c:url value='/user/blogs/my-blogs'/>" class="btn btn-outline-secondary">
                            <i class="bi bi-person me-2"></i>Bài viết của tôi
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
/* Modern Hero Section */
.blog-hero-section {
    position: relative;
    overflow: hidden;
    border-radius: 25px;
    padding: 100px 40px;
    margin-top: 30px;
    color: white;
    text-align: center;
    min-height: 400px;
    display: flex;
    align-items: center;
}

.hero-background {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    z-index: 1;
}

.hero-pattern {
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.15) 2px, transparent 2px);
    background-size: 40px 40px;
    animation: float 20s infinite linear;
    z-index: 2;
    opacity: 0.6;
}

@keyframes float {
    0% { transform: translate(-50%, -50%) rotate(0deg); }
    100% { transform: translate(-50%, -50%) rotate(360deg); }
}

.hero-content {
    position: relative;
    z-index: 3;
}

.blog-hero-title {
    font-size: 3.5rem;
    font-weight: 800;
    margin-bottom: 20px;
    line-height: 1.2;
    text-shadow: 0 4px 20px rgba(0,0,0,0.2);
    letter-spacing: -0.5px;
}

.blog-hero-subtitle {
    font-size: 1.35rem;
    margin-bottom: 40px;
    opacity: 0.95;
    line-height: 1.6;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
}

.blog-hero-meta {
    display: flex;
    justify-content: center;
    gap: 40px;
    flex-wrap: wrap;
    margin-top: 30px;
}

.meta-item {
    display: flex;
    align-items: center;
    gap: 12px;
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(10px);
    padding: 12px 20px;
    border-radius: 15px;
    border: 1px solid rgba(255,255,255,0.2);
    transition: all 0.3s ease;
}

.meta-item:hover {
    background: rgba(255,255,255,0.25);
    transform: translateY(-3px);
}

.meta-icon {
    width: 45px;
    height: 45px;
    background: rgba(255,255,255,0.2);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.3rem;
}

.meta-content {
    display: flex;
    flex-direction: column;
    text-align: left;
}

.meta-label {
    font-size: 0.75rem;
    opacity: 0.8;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.meta-value {
    font-size: 0.95rem;
    font-weight: 600;
}

.backdrop-blur {
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
}

/* Featured Image */
.blog-featured-image {
    margin-bottom: 50px;
}

.image-frame {
    position: relative;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 20px 60px rgba(0,0,0,0.15);
    background: #f8f9fa;
}

.image-frame img {
    width: 100%;
    max-height: 550px;
    object-fit: cover;
    display: block;
}

.image-shine {
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    transition: left 0.6s ease;
}

.image-frame:hover .image-shine {
    left: 100%;
}

/* Article Content */
.blog-content-wrapper {
    margin-bottom: 50px;
}

.blog-article {
    background: white;
    border-radius: 20px;
    padding: 50px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.08);
    border: 1px solid rgba(0,0,0,0.05);
}

.article-content {
    max-width: 100%;
}

/* Related Products Section */
.related-products-section {
    margin-bottom: 50px;
}

.section-header {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 3px solid #667eea;
}

.section-icon {
    width: 60px;
    height: 60px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.8rem;
    box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
}

.section-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: #2c3e50;
    margin: 0;
}

.section-subtitle {
    color: #6c757d;
    margin: 5px 0 0 0;
    font-size: 0.95rem;
}

.products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 25px;
}

.product-card-modern {
    background: white;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    transition: all 0.4s ease;
    border: 1px solid rgba(0,0,0,0.05);
}

.product-card-modern:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
    border-color: rgba(102, 126, 234, 0.3);
}

.product-image-container {
    position: relative;
    height: 200px;
    overflow: hidden;
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
}

.product-image, .product-image-placeholder {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.product-image-placeholder {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 3rem;
    color: #adb5bd;
}

.product-card-modern:hover .product-image {
    transform: scale(1.15);
}

.product-overlay {
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

.product-card-modern:hover .product-overlay {
    opacity: 1;
}

.product-info {
    padding: 20px;
}

.product-name {
    font-size: 1.1rem;
    font-weight: 600;
    margin-bottom: 12px;
}

.product-name a {
    color: #2c3e50;
    transition: color 0.3s ease;
}

.product-name a:hover {
    color: #667eea;
}

.product-meta {
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 10px;
}

.product-category {
    display: inline-block;
    padding: 4px 12px;
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
    color: #667eea;
    border-radius: 12px;
    font-size: 0.8rem;
    font-weight: 500;
}

.product-price {
    color: #28a745;
    font-weight: 700;
    font-size: 1.1rem;
}

/* Blog Content */
.article-content {
    line-height: 1.9;
    font-size: 1.1rem;
    color: #2c3e50;
}

.article-content img {
    max-width: 100%;
    height: auto;
    border-radius: 15px;
    margin: 2.5rem 0;
    box-shadow: 0 8px 25px rgba(0,0,0,0.12);
    transition: transform 0.3s ease;
}

.article-content img:hover {
    transform: scale(1.02);
}

.article-content p {
    margin-bottom: 1.8rem;
    font-size: 1.1rem;
    line-height: 1.9;
}

.article-content h1,
.article-content h2,
.article-content h3,
.article-content h4,
.article-content h5,
.article-content h6 {
    color: #2c3e50;
    margin-top: 3rem;
    margin-bottom: 1.5rem;
    font-weight: 700;
    line-height: 1.3;
}

.article-content h1 { 
    font-size: 2.5rem; 
    border-bottom: 4px solid #667eea; 
    padding-bottom: 0.75rem;
    position: relative;
}

.article-content h1::after {
    content: '';
    position: absolute;
    bottom: -4px;
    left: 0;
    width: 100px;
    height: 4px;
    background: linear-gradient(90deg, #667eea, #764ba2);
}

.article-content h2 { 
    font-size: 2rem; 
    border-bottom: 3px solid #667eea; 
    padding-bottom: 0.5rem;
}

.article-content h3 { 
    font-size: 1.75rem; 
    color: #667eea;
    border-left: 4px solid #667eea;
    padding-left: 1rem;
}

.article-content h4 { 
    font-size: 1.5rem; 
    color: #764ba2; 
}

.article-content h5 { 
    font-size: 1.25rem; 
    color: #5a67d8; 
}

.article-content h6 { 
    font-size: 1.1rem; 
    color: #6b46c1; 
}

.article-content blockquote {
    border-left: 5px solid #667eea;
    padding: 2rem 2rem 2rem 3rem;
    margin: 2.5rem 0;
    font-style: italic;
    color: #555;
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
    border-radius: 0 15px 15px 0;
    position: relative;
    font-size: 1.15rem;
    line-height: 1.8;
}

.article-content blockquote::before {
    content: '"';
    font-size: 5rem;
    color: #667eea;
    position: absolute;
    top: -10px;
    left: 15px;
    opacity: 0.2;
    font-family: Georgia, serif;
}

.article-content ul, .article-content ol {
    padding-left: 2.5rem;
    margin-bottom: 2rem;
}

.article-content li {
    margin-bottom: 0.75rem;
    line-height: 1.8;
}

.article-content code {
    background: rgba(102, 126, 234, 0.12);
    padding: 0.3rem 0.6rem;
    border-radius: 6px;
    font-family: 'Monaco', 'Menlo', 'Courier New', monospace;
    font-size: 0.9em;
    color: #667eea;
    font-weight: 500;
}

.article-content pre {
    background: #2d3748;
    color: #e2e8f0;
    padding: 2rem;
    border-radius: 12px;
    border-left: 5px solid #667eea;
    overflow-x: auto;
    margin: 2rem 0;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.article-content pre code {
    background: transparent;
    color: inherit;
    padding: 0;
}

.article-content table {
    width: 100%;
    border-collapse: collapse;
    margin: 2rem 0;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    border-radius: 12px;
    overflow: hidden;
}

.article-content th,
.article-content td {
    padding: 1rem;
    text-align: left;
    border-bottom: 1px solid rgba(0,0,0,0.08);
}

.article-content th {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.9rem;
    letter-spacing: 0.5px;
}

.article-content tr:nth-child(even) {
    background: rgba(102, 126, 234, 0.03);
}

.article-content tr:hover {
    background: rgba(102, 126, 234, 0.08);
    transition: background 0.3s ease;
}

/* Sidebar Cards */
.card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    transition: transform 0.3s ease;
}

.card:hover {
    transform: translateY(-2px);
}

.card-header {
    border-radius: 15px 15px 0 0 !important;
    border: none;
    font-weight: 600;
}

.bg-gradient-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

/* Author Avatar */
.author-avatar {
    position: relative;
}

.author-avatar::after {
    content: '';
    position: absolute;
    bottom: -5px;
    left: 50%;
    transform: translateX(-50%);
    width: 60px;
    height: 3px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    border-radius: 2px;
}

/* Stats Items */
.stats-item {
    padding: 0.75rem 0;
    border-bottom: 1px solid rgba(0,0,0,0.05);
}

.stats-item:last-child {
    border-bottom: none;
}


/* Responsive */
@media (max-width: 768px) {
    .blog-hero-section {
        padding: 60px 20px;
        margin-top: 20px;
        min-height: 300px;
    }

    .blog-hero-title {
        font-size: 2rem;
    }
    
    .blog-hero-subtitle {
        font-size: 1.1rem;
    }
    
    .blog-hero-meta {
        gap: 15px;
    }
    
    .meta-item {
        padding: 10px 15px;
    }
    
    .meta-icon {
        width: 35px;
        height: 35px;
        font-size: 1rem;
    }

    .blog-article {
        padding: 30px 20px;
    }
    
    .article-content h1 { font-size: 1.75rem; }
    .article-content h2 { font-size: 1.5rem; }
    .article-content h3 { font-size: 1.25rem; }
    
    .products-grid {
        grid-template-columns: 1fr;
    }
    
    .section-header {
        flex-direction: column;
        align-items: flex-start;
    }
}

/* Animations */
@keyframes slideInRight {
    from {
        opacity: 0;
        transform: translateX(100%);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.animate__slideInRight {
    animation: slideInRight 0.5s ease-out;
}
</style>

<script>
// Delete blog confirmation
function deleteBlog(blogId, title) {
    if (confirm('Bạn có chắc muốn xóa bài viết "' + title + '"?\n\nHành động này không thể hoàn tác.')) {
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

// Smooth scroll for anchor links
document.addEventListener('DOMContentLoaded', function() {
    // Add smooth scrolling to all anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add fade-in animation to content sections
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all content sections
    document.querySelectorAll('.article-content h1, .article-content h2, .article-content h3, .article-content blockquote').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
});
</script>

<jsp:include page="/WEB-INF/common/footer.jsp"/>
<jsp:include page="/WEB-INF/common/Toast.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
