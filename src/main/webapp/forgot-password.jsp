<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quên mật khẩu | UTE Shop</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap + Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    body {
      background: linear-gradient(135deg, #74b9ff, #a29bfe);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .card {
      border: none;
      border-radius: 1rem;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
      transition: transform 0.2s ease;
    }
    .card:hover {
      transform: translateY(-4px);
    }
    .form-control:focus {
      border-color: #6c5ce7;
      box-shadow: 0 0 0 0.2rem rgba(108,92,231,0.25);
    }
  </style>
</head>

<body>
  <div class="container" style="max-width: 480px;">
    <div class="card p-4 bg-white">
      <div class="text-center mb-4">
        <i class="bi bi-lock-fill text-primary" style="font-size: 3rem;"></i>
        <h3 class="fw-bold mt-2">Quên mật khẩu</h3>
        <p class="text-muted small">Nhập email đã đăng ký để nhận mã khôi phục mật khẩu.</p>
      </div>

      <!-- Hiển thị thông báo -->
      <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
          <i class="bi bi-exclamation-triangle me-2"></i>${error}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      </c:if>

      <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
          <i class="bi bi-check-circle me-2"></i>${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      </c:if>

      <!-- Form nhập email -->
      <form method="post" action="${pageContext.request.contextPath}/forgot">
        <div class="mb-3">
          <label for="email" class="form-label fw-semibold">Email đã đăng ký</label>
          <input type="email" id="email" name="email" class="form-control" required
                 placeholder="nhập email của bạn..." value="${prefillEmail}">
        </div>
        <button type="submit" class="btn btn-primary w-100">
          <i class="bi bi-envelope-fill me-1"></i> Gửi mã xác nhận
        </button>
      </form>

      <!-- Link điều hướng -->
      <div class="text-center mt-4">
        <p class="small mb-1">Đã có mã xác nhận?</p>
        <a href="${pageContext.request.contextPath}/reset" class="text-decoration-none">
          <i class="bi bi-key me-1"></i> Đặt lại mật khẩu
        </a>
      </div>
    </div>

    <!-- Footer nhỏ -->
    <div class="text-center text-white mt-4 small">
      &copy; <script>document.write(new Date().getFullYear())</script> UTE Shop. All rights reserved.
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
