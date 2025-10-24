<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary d-flex align-items-center justify-content-center vh-100">

  <div class="card shadow-lg border-0" style="max-width: 380px; width: 100%;">
    <div class="card-body p-4">
      <h2 class="text-center mb-4">Đăng nhập</h2>

      <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger text-center">${requestScope.error}</div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/login" novalidate>
        <div class="mb-3">
          <label class="form-label">Tên đăng nhập</label>
          <input type="text" name="username" class="form-control" required
                 value="${cookie.username.value}" placeholder="Nhập tên đăng nhập...">
        </div>

        <div class="mb-3">
          <label class="form-label">Mật khẩu</label>
          <div class="input-group">
            <input type="password" id="password" name="password" class="form-control" required 
            	value="${cookie.password.value}" placeholder="Nhập mật khẩu...">
            <button type="button" class="btn btn-outline-secondary" onclick="togglePw(this)">Hiện</button>
          </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-3">
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="remember" name="remember"
              <c:if test="${not empty cookie.rememberUser.value}">checked</c:if>>
            <label class="form-check-label" for="remember">Nhớ tôi</label>
          </div>
          <a href="${pageContext.request.contextPath}/forgot" class="text-decoration-none small">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
      </form>

      <div class="text-center mt-3">
        <span class="text-muted small">Chưa có tài khoản?</span>
        <a href="${pageContext.request.contextPath}/register" class="small text-decoration-none fw-semibold">
          Đăng ký ngay
        </a>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    function togglePw(btn) {
      const pw = document.getElementById('password');
      const isHidden = pw.type === 'password';
      pw.type = isHidden ? 'text' : 'password';
      btn.textContent = isHidden ? 'Ẩn' : 'Hiện';
    }
  </script>
</body>
</html>
