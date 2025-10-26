<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đơn hàng hôm nay</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">

<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="h4 mb-0">ĐƠN HÀNG NGÀY HÔM NAY</h2>
    <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-outline-secondary btn-sm">← Trang chủ admin</a>
  </div>

  <c:choose>
    <c:when test="${empty orders}">
      <div class="alert alert-info text-center">
        Chưa có đơn hàng nào được đặt hôm nay.
      </div>
    </c:when>
    <c:otherwise>
      <table class="table table-hover align-middle shadow-sm bg-white rounded">
        <thead class="table-light text-center">
          <tr>
            <th>Ngày lập</th>
            <th>ID người dùng</th>
            <th>Tên người dùng</th>
            <th>Địa chỉ</th>
            <th>SĐT</th>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Tổng tiền</th>
            <th>Ghi chú</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="o" items="${orders}">
            <tr class="text-center">
              <td><fmt:formatDate value="${o.ngayLap}" pattern="dd/MM/yyyy HH:mm"/></td>
              <td>${o.nguoiDungID}</td>
              <td>${o.user.fullname}</td>
			  <td>${o.user.diaChi}</td>
			  <td>${o.user.sdt}</td>
              <td>${o.product.name}</td>
              <td>${o.soLuong}</td>
              <td><fmt:formatNumber value="${o.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
              <td><fmt:formatNumber value="${o.soLuong * o.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
              <td>${o.ghiChu}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
