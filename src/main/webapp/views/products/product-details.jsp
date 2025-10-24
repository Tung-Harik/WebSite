<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title><c:out value="${product.name}"/></title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background-color: #f8f9fa; }
    .product-card {
      background: #fff;
      border-radius: 15px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      padding: 2rem;
      margin-top: 2rem;
    }
    .product-img {
      max-height: 400px;
      width: 100%;
      object-fit: cover;
      border-radius: 12px;
    }
    .price {
      color: #dc3545;
      font-weight: 600;
      font-size: 1.5rem;
    }
    .badge-stock { font-size: 0.9rem; }
    .btn-primary {
      background-color: #007bff;
      border: none;
      padding: 10px 20px;
      border-radius: 8px;
    }
    .btn-primary:hover { background-color: #0056b3; }
  </style>
</head>

<body>
<fmt:setLocale value="vi_VN"/>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<div class="container">
  <a href="${ctx}/home" class="btn btn-link mt-3">&larr; Quay lại</a>

  <div class="product-card">
    <div class="row g-4 align-items-center">

      <!-- Ảnh sản phẩm -->
      <div class="col-md-5 text-center">
        <c:choose>
          <c:when test="${not empty imageName}">
            <img src="${ctx}/assets/img/products/${imageName}" alt="${product.name}" class="product-img shadow-sm">
          </c:when>
          <c:otherwise>
            <img src="${ctx}/assets/img/placeholder/no-image.png" alt="Chưa có ảnh" class="product-img shadow-sm">
            <div class="text-muted small mt-2">Chưa có ảnh sản phẩm</div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- Thông tin sản phẩm -->
      <div class="col-md-7">
        <h2 class="fw-bold mb-3"><c:out value="${product.name}"/></h2>

        <p class="price mb-2">
          <fmt:formatNumber value="${product.prices}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
        </p>

        <span class="badge text-bg-light text-dark badge-stock">Tình trạng: đang cập nhật</span>

        <p class="text-muted mt-3 mb-4">
          Sản phẩm độc quyền UTE Shop — số lượng có hạn.
        </p>

        <form action="${ctx}/user/cart/add" method="post" class="mt-3">
          <input type="hidden" name="productId" value="${product.id}">
          <div class="input-group mb-3" style="max-width: 200px;">
            <input type="number" name="quantity" class="form-control" value="1" min="1">
            <button type="submit" class="btn btn-primary">Thêm vào giỏ</button>
          </div>
        </form>

        <hr class="my-4">
        <ul class="list-unstyled small text-muted mb-0">
          <li>• Giao nhanh toàn quốc</li>
          <li>• Đổi trả trong 7 ngày nếu lỗi nhà sản xuất</li>
          <li>• Hỗ trợ tư vấn 24/7</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
