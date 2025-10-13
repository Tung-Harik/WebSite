<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký tài khoản</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary d-flex align-items-center justify-content-center vh-100">

  <div class="card shadow-lg border-0" style="max-width: 560px; width: 100%;">
    <div class="card-body p-4">
      <h2 class="text-center mb-3">Đăng ký tài khoản</h2>

      <!-- thông báo lỗi/thành công -->
      <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger text-center">${requestScope.error}</div>
      </c:if>
      <c:if test="${not empty requestScope.success}">
        <div class="alert alert-success text-center">${requestScope.success}</div>
      </c:if>

      <!-- Đăng ký -->
      <form method="post" action="${pageContext.request.contextPath}/register" novalidate>
        <!-- username -->
        <div class="mb-3">
          <label for="username" class="form-label">Tên đăng nhập *</label>
          <input type="text" id="username" name="username" class="form-control"
                 required maxlength="50" placeholder="Nhập tên đăng nhập">
        </div>

        <!-- password -->
        <div class="mb-3">
          <label for="password" class="form-label">Mật khẩu *</label>
          <div class="input-group">
            <input type="password" id="password" name="password" class="form-control"
                   required maxlength="50" placeholder="Nhập mật khẩu">
            <button type="button" class="btn btn-outline-secondary" onclick="togglePw(this)">Hiện</button>
          </div>
        </div>

        <!-- fullname -->
        <div class="mb-3">
          <label for="fullname" class="form-label">Họ và tên</label>
          <input type="text" id="fullname" name="fullname" class="form-control"
                 maxlength="50" placeholder="Nguyễn Văn A">
        </div>

        <!-- DiaChi + SDT -->
        <div class="row">
          <div class="col-md-8 mb-3">
            <label for="diachi" class="form-label">Địa chỉ *</label>
            <input type="text" id="diachi" name="diachi" class="form-control"
                   required maxlength="50" placeholder="Số nhà, đường, quận/huyện">
          </div>
          <div class="col-md-4 mb-3">
            <label for="sdt" class="form-label">SĐT *</label>
            <input type="tel" id="sdt" name="sdt" class="form-control"
                   required maxlength="50" placeholder="0xxxxxxxxx"
                   pattern="^[0-9+\-\s]{8,15}$"
                   title="Chỉ số, dấu +, -, khoảng trắng (8–15 ký tự)">
          </div>
        </div>

        <!-- email -->
        <div class="mb-3">
          <label for="email" class="form-label">Email</label>
          <input type="email" id="email" name="email" class="form-control"
                 maxlength="50" placeholder="name@example.com">
        </div>

        <button type="submit" class="btn btn-primary w-100">Tạo tài khoản</button>

        <div class="text-center mt-3">
          <span class="text-muted small">Đã có tài khoản?</span>
          <a href="${pageContext.request.contextPath}/login" class="small text-decoration-none fw-semibold">Đăng nhập</a>
        </div>
      </form>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    function togglePw(btn){
      const pw = document.getElementById('password');
      const show = pw.type === 'password';
      pw.type = show ? 'text' : 'password';
      btn.textContent = show ? 'Ẩn' : 'Hiện';
    }
  </script>
</body>
</html>
