<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  
<header class="bg-primary text-white py-3">
  <div class="container">
    <div class="row align-items-center g-4">
      <!-- Cột trái -->
      <div class="col-lg-8">
        <h1 class="h2 mb-2">
          Xin chào, Shipper <span class="fw-bold">${sessionScope.account.fullname}</span>!
        </h1>
        <p class="mb-0 opacity-75">
          Dưới đây là bảng điều khiển vận chuyển hôm nay của bạn.
        </p>
      </div>

      <!-- Cột phải -->
      <div class="col-lg-4 text-lg-end">
        <!-- Nhóm hai nút đầu tiên cùng hàng -->
        <div class="d-flex flex-wrap justify-content-lg-end gap-2">
          <a href="${pageContext.request.contextPath}/shipper/profile"
             class="btn btn-outline-light">
            <i class="bi bi-person-gear me-1"></i> Hồ sơ cá nhân
          </a>

          <a href="${pageContext.request.contextPath}/shipper/home"
             class="btn btn-light fw-semibold">
            <i class="bi bi-house-door me-1"></i> Trang chủ
          </a>
        </div>

        <!-- Nút đăng xuất nằm dưới, nổi bật -->
        <div class="mt-3">
          <a href="${pageContext.request.contextPath}/logout"
             class="btn btn-danger w-20 fw-semibold shadow-sm">
            <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
          </a>
        </div>
      </div>
    </div>
  </div>
</header>
