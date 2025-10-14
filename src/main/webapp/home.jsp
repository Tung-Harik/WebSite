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
      height: 200px;
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
  
  <%-- ===== Thanh phân trang & chọn size ===== --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="page"       value="${empty requestScope.page ? 1 : requestScope.page}"/>
<c:set var="size"       value="${empty requestScope.size ? 8 : requestScope.size}"/>
<c:set var="totalPages" value="${empty requestScope.totalPages ? 1 : requestScope.totalPages}"/>

<div class="d-flex flex-column flex-md-row align-items-center justify-content-between mt-4 gap-3">
  <!-- Bộ chọn size -->
  <form class="d-flex align-items-center gap-2" method="get" action="${pageContext.request.contextPath}/home">
    <input type="hidden" name="page" value="1"/>
    <label for="sizeSelect" class="text-muted">Sản phẩm/trang:</label>
    <select id="sizeSelect" name="size" class="form-select form-select-sm" style="width: auto"
            onchange="this.form.submit()">
      <option value="4"  ${size == 4  ? 'selected' : ''}>4</option>
      <option value="8"  ${size == 8  ? 'selected' : ''}>8</option>
      <option value="12" ${size == 12 ? 'selected' : ''}>12</option>
      <option value="16" ${size == 16 ? 'selected' : ''}>16</option>
      <option value="24" ${size == 24 ? 'selected' : ''}>24</option>
    </select>
  </form>

  <!-- Phân trang -->
  <nav aria-label="Product pagination">
    <ul class="pagination mb-0">
      <%-- Prev --%>
      <li class="page-item ${page <= 1 ? 'disabled' : ''}">
        <a class="page-link"
           href="<c:url value='/home'>
                    <c:param name='page' value='${page-1}'/>
                    <c:param name='size' value='${size}'/>
                 </c:url>">Prev</a>
      </li>

      <%-- Tính cửa sổ hiển thị số trang (window 5 trang quanh current) --%>
      <c:set var="start" value="${page - 2}"/>
      <c:if test="${start < 1}">
        <c:set var="start" value="1"/>
      </c:if>
      <c:set var="end" value="${page + 2}"/>
      <c:if test="${end > totalPages}">
        <c:set var="end" value="${totalPages}"/>
      </c:if>

      <%-- Nếu start > 1: hiển thị nút '1' + dấu '...' --%>
      <c:if test="${start > 1}">
        <li class="page-item">
          <a class="page-link"
             href="<c:url value='/home'>
                      <c:param name='page' value='1'/>
                      <c:param name='size' value='${size}'/>
                   </c:url>">1</a>
        </li>
        <li class="page-item disabled"><span class="page-link">…</span></li>
      </c:if>

      <%-- Các trang từ start..end --%>
      <c:forEach var="i" begin="${start}" end="${end}">
        <li class="page-item ${i == page ? 'active' : ''}">
          <a class="page-link"
             href="<c:url value='/home'>
                      <c:param name='page' value='${i}'/>
                      <c:param name='size' value='${size}'/>
                   </c:url>">${i}</a>
        </li>
      </c:forEach>

      <%-- Nếu end < totalPages: hiển thị '...' + nút cuối --%>
      <c:if test="${end < totalPages}">
        <li class="page-item disabled"><span class="page-link">…</span></li>
        <li class="page-item">
          <a class="page-link"
             href="<c:url value='/home'>
                      <c:param name='page' value='${totalPages}'/>
                      <c:param name='size' value='${size}'/>
                   </c:url>">${totalPages}</a>
        </li>
      </c:if>

      <%-- Next --%>
      <li class="page-item ${page >= totalPages ? 'disabled' : ''}">
        <a class="page-link"
           href="<c:url value='/home'>
                    <c:param name='page' value='${page+1}'/>
                    <c:param name='size' value='${size}'/>
                 </c:url>">Next</a>
      </li>
    </ul>
  </nav>
</div>
  

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
