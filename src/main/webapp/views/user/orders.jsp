<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đơn hàng của tôi</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">

<div class="container py-4">
  <h2 class="h4 mb-4 text-center">ĐƠN HÀNG CỦA BẠN</h2>

  <c:choose>
    <c:when test="${empty orders}">
      <div class="alert alert-info text-center">
        Bạn chưa có đơn hàng nào.
        <a href="${pageContext.request.contextPath}/home" class="alert-link">Tiếp tục mua sắm</a>
      </div>
    </c:when>

    <c:otherwise>
      <table class="table table-hover align-middle shadow-sm bg-white rounded">
        <thead class="table-light">
          <tr class="text-center">
            <th>Mã HD</th>
            <th>Ngày lập</th>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Tổng tiền</th>
            <th>Ghi chú</th>
            <th></th>
          </tr>
        </thead>

        <tbody>
          <c:forEach var="o" items="${orders}">
            <tr class="text-center">
              <td>${o.id}</td>
              <td><fmt:formatDate value="${o.ngayLap}" pattern="dd/MM/yyyy HH:mm" /></td>
              <td>${o.product.name}</td>
              <td>${o.soLuong}</td>
              <td><fmt:formatNumber value="${o.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
              <td>
                <fmt:formatNumber value="${o.soLuong * o.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
              </td>
              <td>${o.ghiChu}</td>
              <td>
                <a class="btn btn-sm btn-outline-primary"
                   href="${pageContext.request.contextPath}/user/orders/detail?id=${o.id}">
                   Chi tiết
                </a>
              </td>
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
