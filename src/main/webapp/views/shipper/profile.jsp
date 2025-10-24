<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Hồ sơ Shipper</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<header class="bg-primary text-white py-4">
  <div class="container">
    <h1 class="h3 mb-1">Hồ sơ Shipper</h1>
    <div class="opacity-75">Xin chào, <strong>${sessionScope.account.fullname}</strong></div>
  </div>
</header>

<main class="container my-4 my-md-5">

  <!-- Flash message -->
  <c:if test="${not empty sessionScope.success}">
    <div class="alert alert-success"><i class="bi bi-check-circle me-2"></i>${sessionScope.success}</div>
    <c:remove var="success" scope="session"/>
  </c:if>
  <c:if test="${not empty sessionScope.error}">
    <div class="alert alert-danger"><i class="bi bi-x-circle me-2"></i>${sessionScope.error}</div>
    <c:remove var="error" scope="session"/>
  </c:if>

  <div class="row g-4">
    <!-- Cập nhật thông tin cơ bản -->
    <div class="col-lg-6">
      <div class="card border-0 shadow-sm h-100">
        <div class="card-header bg-white"><h5 class="mb-0">Thông tin cá nhân</h5></div>
        <div class="card-body">
          <form action="${ctx}/shipper/profile" method="post" class="row g-3">
            <input type="hidden" name="action" value="update">

            <div class="col-12">
              <label class="form-label">Họ và tên</label>
              <input type="text" name="fullname" class="form-control" required
                     value="${account.fullname}">
            </div>

            <div class="col-12">
              <label class="form-label">Email</label>
              <input type="email" name="email" class="form-control" required
                     value="${account.email}">
            </div>

            <div class="col-md-6">
              <label class="form-label">Số điện thoại</label>
              <input type="text" name="sdt" class="form-control" required
                     value="${account.sdt}" placeholder="0xxxxxxxxx hoặc +84xxxxxxxxx">
            </div>

            <div class="col-md-6">
              <label class="form-label">Tên đăng nhập</label>
              <input type="text" class="form-control" value="${account.username}" disabled>
            </div>

            <div class="col-12">
              <label class="form-label">Địa chỉ</label>
              <input type="text" name="diaChi" class="form-control" required
                     value="${account.diaChi}">
            </div>

            <div class="col-12">
              <button class="btn btn-primary"><i class="bi bi-save me-1"></i> Lưu thay đổi</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Đổi mật khẩu -->
    <div class="col-lg-6">
      <div class="card border-0 shadow-sm h-100">
        <div class="card-header bg-white"><h5 class="mb-0">Đổi mật khẩu</h5></div>
        <div class="card-body">
          <form action="${ctx}/shipper/profile" method="post" class="row g-3">
            <input type="hidden" name="action" value="password">

            <div class="col-12">
              <label class="form-label">Mật khẩu hiện tại</label>
              <input type="password" name="currentPassword" class="form-control" required>
            </div>

            <div class="col-md-6">
              <label class="form-label">Mật khẩu mới</label>
              <input type="password" name="newPassword" class="form-control" minlength="8" required>
            </div>

            <div class="col-md-6">
              <label class="form-label">Xác nhận mật khẩu</label>
              <input type="password" name="confirmPassword" class="form-control" minlength="8" required>
            </div>

            <div class="col-12">
              <button class="btn btn-outline-primary"><i class="bi bi-key me-1"></i> Đổi mật khẩu</button>
            </div>
          </form>
        </div>
      </div>
    </div>

  </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
