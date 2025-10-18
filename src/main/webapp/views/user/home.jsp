<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Trang người dùng</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap + Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">

  <!-- Header hero -->
  <header class="bg-primary text-white py-5">
    <div class="container">
      <div class="row align-items-center g-4">
        <div class="col-lg-8">
          <h1 class="h2 mb-2">Chào mừng trở lại, <span class="fw-bold">${sessionScope.account.fullname}</span>!</h1>
          <p class="mb-0 opacity-75">Đây là trang tổng quan nhanh cho tài khoản của bạn.</p>
        </div>
        <div class="col-lg-4 text-lg-end">
          <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-light">
            <i class="bi bi-gear me-1"></i> Thiết lập tài khoản
          </a>
        </div>
      </div>
    </div>
  </header>

  <!-- Main content -->
  <main class="container my-4 my-md-5">

    <!-- Alerts (tùy chọn) -->
    <c:if test="${not empty requestScope.success}">
      <div class="alert alert-success"><i class="bi bi-check-circle me-2"></i>${requestScope.success}</div>
    </c:if>
    <c:if test="${not empty requestScope.error}">
      <div class="alert alert-danger"><i class="bi bi-x-circle me-2"></i>${requestScope.error}</div>
    </c:if>

    <!-- Quick stats -->
    <section class="row g-4 mb-4">
      <div class="col-12 col-md-4">
        <div class="card h-100">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Đơn hàng của tôi</div>
              <div class="fs-4 fw-semibold">${requestScope.stats.orderCount}</div>
            </div>
            <div class="display-6 text-primary"><i class="bi bi-receipt"></i></div>
          </div>
          <div class="card-footer bg-transparent border-0 pt-0">
            <a href="${pageContext.request.contextPath}/user/orders" class="small text-decoration-none">Xem chi tiết →</a>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-4">
        <div class="card h-100">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Sản phẩm đã lưu</div>
              <div class="fs-4 fw-semibold">${requestScope.stats.savedCount}</div>
            </div>
            <div class="display-6 text-primary"><i class="bi bi-heart"></i></div>
          </div>
          <div class="card-footer bg-transparent border-0 pt-0">
            <a href="${pageContext.request.contextPath}/favorites" class="small text-decoration-none">Xem danh sách →</a>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-4">
        <div class="card h-100">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Điểm tích lũy</div>
              <div class="fs-4 fw-semibold">${requestScope.stats.points}</div>
            </div>
            <div class="display-6 text-primary"><i class="bi bi-stars"></i></div>
          </div>
          <div class="card-footer bg-transparent border-0 pt-0">
            <a href="${pageContext.request.contextPath}/rewards" class="small text-decoration-none">Ưu đãi của bạn →</a>
          </div>
        </div>
      </div>
    </section>

    <!-- Two columns: Profile + Recent list -->
    <section class="row g-4">
      <!-- Profile card -->
      <div class="col-lg-4">
        <div class="card h-100">
          <div class="card-header bg-white">
            <h5 class="mb-0">Hồ sơ của bạn</h5>
          </div>
          <div class="card-body">
            <div class="d-flex align-items-center gap-3">
              <div class="rounded-circle bg-secondary-subtle d-flex align-items-center justify-content-center" style="width:64px;height:64px;">
                <i class="bi bi-person fs-3 text-secondary"></i>
              </div>
              <div>
                <div class="fw-semibold">${sessionScope.currentUser.fullname}</div>
                <div class="text-muted small">${sessionScope.currentUser.email}</div>
              </div>
            </div>
            <hr>
            <div class="small">
              <div class="d-flex justify-content-between py-1"><span>Tên đăng nhập</span><span class="text-muted">${sessionScope.account.username}</span></div>
              <div class="d-flex justify-content-between py-1"><span>Email</span><span class="text-muted">${sessionScope.account.email}</span></div>
              <div class="d-flex justify-content-between py-1"><span>SĐT</span><span class="text-muted">${sessionScope.account.sdt}</span></div>
            </div>
          </div>
          <div class="card-footer bg-white">
            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-outline-primary w-100">
              <i class="bi bi-pencil-square me-1"></i> Cập nhật hồ sơ
            </a>
          </div>
        </div>
      </div>

      <!-- Recent items -->
      <div class="col-lg-8">
        <div class="card h-100">
          <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Hoạt động gần đây</h5>
            <a href="${pageContext.request.contextPath}/activities" class="small text-decoration-none">Xem tất cả</a>
          </div>

          <div class="card-body p-0">
            <c:choose>
              <c:when test="${not empty requestScope.recentItems}">
                <div class="list-group list-group-flush">
                  <c:forEach var="it" items="${requestScope.recentItems}">
                    <div class="list-group-item d-flex justify-content-between align-items-center">
                      <div class="me-3">
                        <div class="fw-semibold">${it.title}</div>
                        <div class="small text-muted">${it.description}</div>
                      </div>
                      <div class="text-end small text-muted">${it.timeAgo}</div>
                    </div>
                  </c:forEach>
                </div>
              </c:when>
              <c:otherwise>
                <div class="p-4 text-center text-muted">
                  Chưa có hoạt động nào gần đây.
                </div>
              </c:otherwise>
            </c:choose>
          </div>
          <div class="card-footer bg-white">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
              <i class="bi bi-bag-plus me-1"></i> Bắt đầu mua sắm
            </a>
          </div>
        </div>
      </div>
    </section>
  </main>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
