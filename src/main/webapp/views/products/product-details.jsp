<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="vi_VN"/>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="imgFile" value="${empty imgFile ? 'noimage.jpg' : imgFile}" />
<c:url var="imgSrc" value="/img"><c:param name="f" value="${imgFile}" /></c:url>

<div class="container">
  <a href="${ctx}/trangchu" class="btn btn-link mt-3">&larr; Quay lại</a>

  <div class="product-card bg-white rounded-4 shadow-sm p-4 mt-3">
    <div class="row g-4 align-items-center">

      <!-- Ảnh sản phẩm -->
      <div class="col-md-5 text-center">
        <img src="${imgSrc}" alt="${product.name}" class="img-fluid rounded-3 shadow-sm" style="max-height:400px;object-fit:cover;">
        <c:if test="${imgFile eq 'noimage.jpg'}">
          <div class="text-muted small mt-2">Chưa có ảnh sản phẩm</div>
        </c:if>
      </div>

      <!-- Thông tin -->
      <div class="col-md-7">
        <h2 class="fw-bold mb-3"><c:out value="${product.name}"/></h2>
        <p class="text-danger fw-bold fs-4 mb-2">
          <fmt:formatNumber value="${product.prices}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
        </p>

        <span class="badge text-bg-light text-dark">Tình trạng: đang cập nhật</span>

        <p class="text-muted mt-3 mb-4">Sản phẩm độc quyền UTE Shop — số lượng có hạn.</p>

        <form action="${ctx}/user/cart/add" method="post" class="mt-3">
          <input type="hidden" name="productId" value="${product.id}">
          <div class="input-group mb-3" style="max-width: 220px;">
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
