<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Cửa hàng mỹ phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card-img-top {
      height: 220px;
      object-fit: cover;          /* Cắt đều ảnh, không méo */
      border-bottom: 1px solid #f0f0f0;
    }
    .card-title {
      font-size: 1rem;
      min-height: 2.5em;          /* đảm bảo chiều cao tiêu đề đồng đều */
    }
  </style>
</head>
<body class="bg-body-tertiary">

  <div class="container py-4">
    <div class="text-center mb-4">
      <h1 class="fw-bold">Cửa hàng mỹ phẩm</h1>
      <p class="text-muted">Khám phá những sản phẩm mới nhất</p>
    </div>

    <div class="row g-4">
      <c:forEach var="p" items="${products}">
        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
          <div class="card h-100 shadow-sm border-0">
            <!-- Ảnh sản phẩm -->
            <img src="${pageContext.request.contextPath}/assets/img/products/${imgById[p.id]}"
     				alt="${p.name}" class="card-img-top" style="height:220px;object-fit:cover;">


            <div class="card-body text-center">
              <h6 class="card-title text-truncate" title="${p.name}">
                ${p.name}
              </h6>
              <p class="fw-bold text-danger mb-2">
                <fmt:formatNumber value="${p.prices}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
              </p>
              <a href="#" class="btn btn-outline-primary btn-sm">
                <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
              </a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
