<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Giỏ hàng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    .product-img {
      width: 64px; height: 64px; object-fit: cover; border-radius: .5rem;
    }
    .qty-input { width: 80px; text-align: center; }
    .table > :not(caption) > * > * { vertical-align: middle; }
  </style>
</head>
<body class="bg-body-tertiary">
<div class="container py-4">
  <h1 class="h4 mb-4">Giỏ hàng của bạn</h1>

  <c:if test="${not empty message}">
    <div class="alert alert-info">${message}</div>
  </c:if>

  <c:choose>
    <c:when test="${empty cart || empty cart.items}">
      <div class="alert alert-warning">Giỏ hàng đang trống. <a href="${pageContext.request.contextPath}/home">Tiếp tục mua sắm</a></div>
    </c:when>
    <c:otherwise>
      <div class="card shadow-sm">
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
              <thead class="table-light">
                <tr>
                  <th style="width: 60%">Sản phẩm</th>
                  <th class="text-end">Đơn giá</th>
                  <th class="text-center">Số lượng</th>
                  <th class="text-end">Thành tiền</th>
                  <th class="text-center">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:set var="grandTotal" value="0" scope="page" />
                <c:forEach var="item" items="${cart.items}">
                  <tr>
                    <td>
                      <div class="d-flex align-items-center gap-3">
                        <c:set var="fileName" value="${empty imgById[item.product.id] ? 'Áo thể chất.png' : imgById[item.product.id]}"/>
						<img class="product-img" src="${pageContext.request.contextPath}/assets/img/products/${fileName}" alt="Ảnh">

                        <div>
                          <div class="fw-medium"><c:out value="${item.product.name}" /></div>
                        </div>
                      </div>
                    </td>

                    <td class="text-end">
                      <fmt:formatNumber value="${item.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                    </td>

                    <td class="text-center">
                      <form action="${pageContext.request.contextPath}/user/cart/update" method="post" class="d-inline-flex align-items-center gap-2">
                        <input type="hidden" name="itemId" value="${item.id}" />
                        <input class="form-control form-control-sm qty-input" type="number" name="quantity" min="1" value="${item.quantity}" />
                        <button class="btn btn-sm btn-outline-primary" type="submit">Cập nhật</button>
                      </form>
                    </td>

                    <td class="text-end">
                      <fmt:formatNumber value="${item.subtotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                    </td>

                    <td class="text-center">
                      <form action="${pageContext.request.contextPath}/user/cart/remove" method="post" onsubmit="return confirm('Xóa sản phẩm khỏi giỏ?');">
                        <input type="hidden" name="itemId" value="${item.id}" />
                        <button class="btn btn-sm btn-outline-danger" type="submit">Xóa</button>
                      </form>
                    </td>
                  </tr>

                  <!-- Cộng dồn tổng -->
                  <c:set var="grandTotal" value="${grandTotal + item.subtotal}" scope="page" />
                </c:forEach>
              </tbody>
              <tfoot>
                <tr>
                  <th colspan="3" class="text-end">Tổng cộng:</th>
                  <th class="text-end">
                    <fmt:formatNumber value="${grandTotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                  </th>
                  <th></th>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
      </div>

      <div class="d-flex justify-content-between mt-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">Tiếp tục mua sắm</a>

        <form action="${pageContext.request.contextPath}/user/checkout" method="post">
          <button class="btn btn-primary" type="submit">Thanh toán</button>
        </form>
      </div>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>
