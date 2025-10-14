<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý Users</title>
  <!-- Bootstrap (CDN) -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">
  <style>
    body { padding: 24px; }
    .table td { vertical-align: middle; }
    .required::after { content: " *"; color: #dc3545; }
    .masked { letter-spacing: 3px; }
  </style>
</head>
<body>
  <div class="container">
    <h1 class="mb-3">Chỉnh sửa thông tin</h1>

    <!-- Alerts -->
    <c:if test="${not empty requestScope.message}">
      <div class="alert alert-success">${requestScope.message}</div>
    </c:if>
    <c:if test="${not empty requestScope.error}">
      <div class="alert alert-danger">${requestScope.error}</div>
    </c:if>

    <!-- FORM: Create / Update -->
    <div class="card mb-4">
      <div class="card-body">
        <form action="${pageContext.request.contextPath}/user/profile" method="post" class="row g-3 needs-validation" novalidate>
          <!-- action hidden -->
          <input type="hidden" name="action"
                 value="<c:out value='${empty editUser ? "create" : "update"}'/>">
          <!-- id khi update -->
          <c:if test="${not empty editUser}">
            <input type="hidden" name="id" value="${editUser.id}"/>
          </c:if>

          <div class="col-md-4">
            <label class="form-label required">Username</label>
            <input type="text" name="username" maxlength="50" required
                   value="${editUser.username}" class="form-control" placeholder="vd: baomai"/>
            <div class="invalid-feedback">Username là bắt buộc (≤ 50 ký tự)</div>
          </div>

          <div class="col-md-4">
            <label class="form-label required">Password</label>
            <input type="password" name="password" maxlength="50" 
                   class="form-control" placeholder="mật khẩu"
                   <c:if test="${empty editUser}">required</c:if> />
            <div class="form-text">
              <c:choose>
                <c:when test="${not empty editUser}">Để trống nếu không đổi mật khẩu</c:when>
                <c:otherwise>Nhập mật khẩu (≤ 50 ký tự)</c:otherwise>
              </c:choose>
            </div>
          </div>

          <div class="col-md-4">
            <label class="form-label">Họ tên</label>
            <input type="text" name="fullname" maxlength="50"
                   value="${editUser.fullname}" class="form-control" placeholder="Họ tên (tối đa 50)"/>
          </div>

          <div class="col-md-4">
            <label class="form-label required">Địa chỉ</label>
            <input type="text" name="diaChi" maxlength="50" required
                   value="${editUser.diaChi}" class="form-control" placeholder="Địa chỉ"/>
            <div class="invalid-feedback">Địa chỉ là bắt buộc</div>
          </div>

          <div class="col-md-4">
            <label class="form-label required">SĐT</label>
            <input type="text" name="sdt" maxlength="50" required
                   value="${editUser.sdt}" class="form-control" placeholder="Số điện thoại"/>
            <div class="invalid-feedback">SĐT là bắt buộc</div>
          </div>

          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input type="email" name="email" maxlength="50"
                   value="${editUser.email}" class="form-control" placeholder="vd: you@example.com"/>
          </div>

          <div class="col-12 d-flex gap-2">
            <button type="submit" class="btn btn-primary">Lưu</button>

            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
              Làm mới
            </a>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script>
    // Bootstrap client-side validation
    (() => {
      const forms = document.querySelectorAll('.needs-validation');
      Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
          if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
          }
          form.classList.add('was-validated');
        }, false);
      });
    })();
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
