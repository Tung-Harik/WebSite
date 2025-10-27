<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%-- Title cho decorator --%>
<% request.setAttribute("title", "Trang chủ - UTE Shop"); %>

<div class="my-4 p-4 rounded-3 d-flex flex-column align-items-center justify-content-center text-center"
     style="background:linear-gradient(135deg,#f3e7e9 0%, #e3eeff 100%); min-height:200px;">
  <h1 class="display-6 mb-2 fw-bold">Cửa hàng bán sản phẩm của UTE</h1>
  <p class="lead mb-0">Khám phá các sản phẩm mới nhất.</p>
</div>


<c:choose>
  <c:when test="${empty products}">
    <div class="border border-2 border-dashed rounded p-5 text-center text-muted">
      Không tìm thấy sản phẩm phù hợp.
    </div>
  </c:when>
  <c:otherwise>
    <div class="row g-3">
      <c:forEach var="p" items="${products}">
        <c:set var="imgFile" value="${empty imgById[p.id] ? 'noimage.jpg' : imgById[p.id]}"/>
        <c:url var="imgSrc" value="/img"><c:param name="f" value="${imgFile}" /></c:url>

        <div class="col-6 col-md-4 col-lg-3">
          <div class="card h-100 border-0 shadow-sm">
            <img src="${imgSrc}" class="card-img-top" style="height:220px;object-fit:cover;" alt="${fn:escapeXml(p.name)}"/>
            <div class="card-body text-center d-flex flex-column">
              <h6 class="mb-1 text-truncate" title="${p.name}">${p.name}</h6>
              <p class="fw-bold text-danger mb-2">
                <fmt:formatNumber value="${p.prices}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
              </p>
              <div class="mt-auto d-grid gap-2">
                <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/product/detail?id=${p.id}">Xem chi tiết</a>
                <form action="${pageContext.request.contextPath}/user/cart/add" method="post">
                  <input type="hidden" name="productId" value="${p.id}" />
                  <input type="hidden" name="quantity" value="1" />
                  <button class="btn btn-outline-primary btn-sm" type="submit">Thêm vào giỏ</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:otherwise>
</c:choose>

<%-- ================== PHÂN TRANG + CHỌN SIZE ================== --%>
<c:set var="page"       value="${empty requestScope.page ? 1 : requestScope.page}"/>
<c:set var="size"       value="${empty requestScope.size ? 8 : requestScope.size}"/>
<c:set var="totalPages" value="${empty requestScope.totalPages ? 1 : requestScope.totalPages}"/>
<c:set var="listPath"   value="${empty requestScope.listPath ? '/trangchu' : requestScope.listPath}"/>

<c:url var="listUrl" value="${listPath}"/>

<div class="d-flex flex-column flex-md-row align-items-center justify-content-between mt-4 gap-3">

  <%-- Chọn số sản phẩm/trang --%>
  <form class="d-flex align-items-center gap-2" method="get" action="${listUrl}">
    <input type="hidden" name="page" value="1"/>
    <label for="sizeSelect" class="text-muted">Sản phẩm/trang:</label>
    <select id="sizeSelect" name="size" class="form-select form-select-sm" style="width:auto"
            onchange="this.form.submit()">
      <option value="4"  ${size == 4  ? 'selected' : ''}>4</option>
      <option value="8"  ${size == 8  ? 'selected' : ''}>8</option>
      <option value="12" ${size == 12 ? 'selected' : ''}>12</option>
      <option value="16" ${size == 16 ? 'selected' : ''}>16</option>
      <option value="24" ${size == 24 ? 'selected' : ''}>24</option>
    </select>
  </form>

  <%-- Thanh trang --%>
  <nav aria-label="Product pagination">
    <ul class="pagination mb-0">

      <%-- Prev --%>
      <c:url var="prevUrl" value="${listPath}">
        <c:param name="page" value="${page-1}"/>
        <c:param name="size" value="${size}"/>
      </c:url>
      <li class="page-item ${page <= 1 ? 'disabled' : ''}">
        <a class="page-link" href="${prevUrl}">Prev</a>
      </li>

      <%-- Tính cửa sổ trang --%>
      <c:set var="start" value="${page - 2}"/><c:if test="${start < 1}"><c:set var="start" value="1"/></c:if>
      <c:set var="end" value="${page + 2}"/><c:if test="${end > totalPages}"><c:set var="end" value="${totalPages}"/></c:if>

      <%-- Nếu start > 1: hiện 1 + … --%>
      <c:if test="${start > 1}">
        <c:url var="firstUrl" value="${listPath}">
          <c:param name="page" value="1"/><c:param name="size" value="${size}"/>
        </c:url>
        <li class="page-item"><a class="page-link" href="${firstUrl}">1</a></li>
        <li class="page-item disabled"><span class="page-link">…</span></li>
      </c:if>

      <%-- Dải trang --%>
      <c:forEach var="i" begin="${start}" end="${end}">
        <c:url var="pageIUrl" value="${listPath}">
          <c:param name="page" value="${i}"/><c:param name="size" value="${size}"/>
        </c:url>
        <li class="page-item ${i == page ? 'active' : ''}">
          <a class="page-link" href="${pageIUrl}">${i}</a>
        </li>
      </c:forEach>

      <%-- Nếu end < totalPages: … + trang cuối --%>
      <c:if test="${end < totalPages}">
        <li class="page-item disabled"><span class="page-link">…</span></li>
        <c:url var="lastUrl" value="${listPath}">
          <c:param name="page" value="${totalPages}"/><c:param name="size" value="${size}"/>
        </c:url>
        <li class="page-item"><a class="page-link" href="${lastUrl}">${totalPages}</a></li>
      </c:if>

      <%-- Next --%>
      <c:url var="nextUrl" value="${listPath}">
        <c:param name="page" value="${page+1}"/><c:param name="size" value="${size}"/>
      </c:url>
      <li class="page-item ${page >= totalPages ? 'disabled' : ''}">
        <a class="page-link" href="${nextUrl}">Next</a>
      </li>

    </ul>
  </nav>
</div>
