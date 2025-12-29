<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px 0;
        }
        .register-container {
            max-width: 550px;
            width: 100%;
            padding: 20px;
        }
        .register-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        .register-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .register-header h2 {
            margin: 0;
            font-weight: 600;
            font-size: 28px;
        }
        .register-header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
            font-size: 14px;
        }
        .register-body {
            padding: 40px 30px;
        }
        .form-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            padding: 10px 15px;
            font-size: 14px;
            transition: all 0.3s;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-register {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            font-size: 16px;
            color: white;
            width: 100%;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(79, 172, 254, 0.3);
            color: white;
        }
        .alert-danger {
            border-radius: 10px;
            border: none;
            background-color: #fee;
            color: #c33;
            padding: 12px 15px;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
        .mb-3 {
            margin-bottom: 1rem !important;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-card">
            <div class="register-header">
                <h2><i class="bi bi-person-plus"></i> Đăng ký tài khoản</h2>
                <p>Tham gia cùng chúng tôi để khám phá đặc sản quê hương</p>
            </div>
            <div class="register-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-danger" role="alert">
                        <i class="bi bi-exclamation-triangle"></i> ${message}
                    </div>
                </c:if>

                <form action="<c:url value='/register'/>" method="post">
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-person"></i> Tài khoản *
                        </label>
                        <input class="form-control" type="text" name="username" required 
                               placeholder="Nhập tên đăng nhập" autofocus/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-lock"></i> Mật khẩu *
                        </label>
                        <input class="form-control" type="password" name="password" required 
                               placeholder="Nhập mật khẩu"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-envelope"></i> Email *
                        </label>
                        <input class="form-control" type="email" name="email" required 
                               placeholder="Nhập địa chỉ email"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-phone"></i> Số điện thoại
                        </label>
                        <input class="form-control" type="text" name="phone" 
                               placeholder="Nhập số điện thoại"/>
                    </div>

                    <button type="submit" class="btn btn-register">
                        <i class="bi bi-check-circle"></i> Đăng ký
                    </button>
                </form>

                <div class="login-link">
                    <span>Đã có tài khoản? </span>
                    <a href="<c:url value='/login'/>">
                        <i class="bi bi-box-arrow-in-right"></i> Đăng nhập ngay
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
