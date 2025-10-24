<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Đơn hàng cần giao</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Bootstrap + Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

  <style>
    body { background-color: #f8f9fa; }
    .card { border: 0; box-shadow: 0 0 15px rgba(0,0,0,.06); }
    .table thead th { white-space: nowrap; }
    .product-col { min-width: 220px; }
    .addr-col { min-width: 260px; }
    .actions-col { min-width: 240px; }
  </style>
</head>
<body>
<fmt:setLocale value="vi_VN" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<header>
  <div class="container">
 	 <h1 class="h3 mb-1">Đơn hàng cần giao</h1>
  </div>
</header>

<main class="container my-4 my-md-5">

  <!-- Thông báo -->
  <c:if test="${not empty requestScope.success}">
    <div class="alert alert-success"><i class="bi bi-check-circle me-2"></i>${requestScope.success}</div>
  </c:if>
  <c:if test="${not empty requestScope.error}">
    <div class="alert alert-danger"><i class="bi bi-x-circle me-2"></i>${requestScope.error}</div>
  </c:if>

  <!-- Bộ lọc nhanh -->
  <div class="card mb-4">
    <div class="card-body">
      <form class="row g-3 align-items-end" action="${ctx}/shipper/orders" method="get">
        <div class="col-sm-4 col-md-3">
          <label class="form-label">Tìm kiếm</label>
          <input type="text" name="q" value="${param.q}" class="form-control" placeholder="Tên KH / Mã đơn / Sản phẩm..." />
        </div>
        <div class="col-sm-4 col-md-3">
          <label class="form-label">Từ ngày</label>
          <input type="date" name="from" value="${param.from}" class="form-control" />
        </div>
        <div class="col-sm-4 col-md-3">
          <label class="form-label">Đến ngày</label>
          <input type="date" name="to" value="${param.to}" class="form-control" />
        </div>
        <div class="col-sm-12 col-md-3">
          <button class="btn btn-primary w-100"><i class="bi bi-search me-1"></i> Lọc</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Bảng đơn hàng -->
  <div class="card">
    <div class="card-header bg-white d-flex justify-content-between align-items-center">
      <h5 class="mb-0">Danh sách cần giao</h5>
      <a href="${ctx}/shipper/orders" class="small text-decoration-none">Tải lại danh sách</a>
    </div>

    <div class="card-body p-0">
      <c:choose>
        <c:when test="${not empty requestScope.invoices}">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
              <thead class="table-light">
                <tr>
                  <th>Mã đơn</th>
                  <th>Ngày lập</th>
                  <th>Khách hàng</th>
                  <th class="addr-col">Địa chỉ / SĐT</th>
                  <th class="product-col">Sản phẩm</th>
                  <th class="text-center">SL</th>
                  <th class="text-end">Đơn giá</th>
                  <th class="text-end">Thành tiền</th>
                  <th>Ghi chú</th>
                  <th class="actions-col text-center">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="inv" items="${requestScope.invoices}">
                  <tr>
                    <!-- Mã đơn -->
                    <td>#${inv.id}</td>

                    <!-- Ngày lập -->
                    <td>
                      <fmt:formatDate value="${inv.ngayLap}" pattern="dd/MM/yyyy HH:mm" />
                    </td>

                    <!-- Khách hàng -->
                    <td>
                      <c:choose>
                        <c:when test="${not empty requestScope.usersById}">
                          <c:set var="kh" value="${requestScope.usersById[inv.nguoiDungID]}" />
                          <div class="fw-semibold">
                            <c:out value="${kh != null ? kh.fullname : ('User #' += inv.nguoiDungID)}"/>
                          </div>
                          <div class="small text-muted"><c:out value="${kh != null ? kh.email : ''}"/></div>
                        </c:when>
                        <c:otherwise>
                          User #${inv.nguoiDungID}
                        </c:otherwise>
                      </c:choose>
                    </td>

                    <!-- Địa chỉ / SĐT -->
                    <td>
                      <c:choose>
                        <c:when test="${not empty requestScope.usersById}">
                          <c:set var="kh2" value="${requestScope.usersById[inv.nguoiDungID]}" />
                          <div><i class="bi bi-geo-alt me-1"></i><c:out value="${kh2 != null ? kh2.diaChi : '—'}"/></div>
                          <div class="small text-muted"><i class="bi bi-telephone me-1"></i><c:out value="${kh2 != null ? kh2.sdt : ''}"/></div>
                        </c:when>
                        <c:otherwise>—</c:otherwise>
                      </c:choose>
                    </td>

                    <!-- Sản phẩm -->
                    <td>
                      <div class="fw-semibold"><c:out value="${inv.product != null ? inv.product.name : '—'}"/></div>
                      <div class="small text-muted">
                        <c:if test="${inv.product != null}">Mã SP: ${inv.product.id}</c:if>
                      </div>
                    </td>

                    <!-- Số lượng -->
                    <td class="text-center">${inv.soLuong}</td>

                    <!-- Đơn giá -->
                    <td class="text-end">
                      <fmt:formatNumber value="${inv.donGia}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </td>

                    <!-- Thành tiền (ưu tiên inv.tongTien, nếu null thì donGia * soLuong) -->
                    <td class="text-end">
                      <c:set var="thanhTien" value="${not empty inv.tongTien ? inv.tongTien : (inv.donGia * inv.soLuong)}" />
                      <fmt:formatNumber value="${thanhTien}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </td>

                    <!-- Ghi chú -->
                    <td><c:out value="${inv.ghiChu}" /></td>

                    <!-- Hành động -->
                    <td class="text-center">
                      <div class="btn-group" role="group">
                        <a class="btn btn-sm btn-outline-primary" title="Xem chi tiết"
                           href="${ctx}/shipper/order/detail?id=${inv.id}">
                          <i class="bi bi-eye"></i>
                        </a>
                        <a class="btn btn-sm btn-outline-warning" title="Nhận đơn"
                           href="${ctx}/shipper/order/pick?id=${inv.id}">
                          <i class="bi bi-bag-check"></i>
                        </a>
                        <a class="btn btn-sm btn-outline-success" title="Đã giao"
                           href="${ctx}/shipper/order/deliver?id=${inv.id}">
                          <i class="bi bi-check2-circle"></i>
                        </a>
                        <a class="btn btn-sm btn-outline-danger" title="Hoàn/Hủy"
                           href="${ctx}/shipper/order/fail?id=${inv.id}">
                          <i class="bi bi-x-octagon"></i>
                        </a>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:when>
        <c:otherwise>
          <div class="p-4 text-center text-muted">Hiện chưa có đơn hàng nào cần giao.</div>
        </c:otherwise>
      </c:choose>
    </div>

    <!-- Phân trang (tùy chọn) -->
    <c:if test="${not empty requestScope.page}">
      <div class="card-footer bg-white d-flex justify-content-between align-items-center">
        <div class="small text-muted">Trang ${requestScope.page.number} / ${requestScope.page.totalPages}</div>
        <div class="btn-group">
          <c:if test="${requestScope.page.hasPrev}">
            <a class="btn btn-outline-secondary btn-sm" href="${ctx}/shipper/orders?page=${requestScope.page.number - 1}">&laquo; Trước</a>
          </c:if>
          <c:if test="${requestScope.page.hasNext}">
            <a class="btn btn-outline-secondary btn-sm" href="${ctx}/shipper/orders?page=${requestScope.page.number + 1}">Sau &raquo;</a>
          </c:if>
        </div>
      </div>
    </c:if>

  </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
