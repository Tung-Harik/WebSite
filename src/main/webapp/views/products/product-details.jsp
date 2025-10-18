<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>${product.name}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-body-tertiary">
<div class="container py-4">
  <a href="${pageContext.request.contextPath}/home" class="btn btn-link">&larr; Quay lại</a>

  <div class="row mt-3">
    <div class="col-md-5 text-center">
      <img src="${pageContext.request.contextPath}/assets/img/products/${imageName}"
           alt="${product.name}" class="img-fluid rounded shadow-sm" style="max-height:400px;object-fit:cover;">
    </div>

    <div class="col-md-7">
      <h2 class="fw-bold mb-3">${product.name}</h2>
      <p class="h5 text-danger mb-4">
        <fmt:formatNumber value="${product.prices}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
      </p>
      <p class="text-muted">Sản phẩm độc quyền UTE Shop — số lượng có hạn.</p>

      <form action="${pageContext.request.contextPath}/user/cart/add" method="post" class="mt-4">
        <input type="hidden" name="productId" value="${product.id}">
        <div class="input-group mb-3" style="max-width:200px;">
          <input type="number" name="quantity" class="form-control" value="1" min="1">
          <button type="submit" class="btn btn-primary">Thêm vào giỏ</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
