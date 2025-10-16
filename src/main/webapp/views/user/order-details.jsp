<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chi tiết đơn hàng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">

<div class="container py-4">
  <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-link">&larr; Quay lại</a>
  <h2 class="h4 mb-3 text-center">Chi tiết đơn hàng #${order.id}</h2>

  <div class="card shadow-sm border-0">
    <div class="card-body">
      <p><strong>Ngày lập:</strong> <fmt:formatDate value="${order.ngayLap}" pattern="dd/MM/yyyy HH:mm"/></p>
      <p><strong>Sản phẩm:</strong> ${order.product.name}</p>
      <p><strong>Số lượng:</strong> ${order.soLuong}</p>
      <p><strong>Đơn giá:</strong>
        <fmt:formatNumber value="${order.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
      </p>
      <p><strong>Tổng tiền:</strong>
        <fmt:formatNumber value="${order.soLuong * order.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
      </p>
      <c:if test="${not empty order.ghiChu}">
        <p><strong>Ghi chú:</strong> ${order.ghiChu}</p>
      </c:if>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
