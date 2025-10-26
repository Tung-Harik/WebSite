<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Bảng điều khiển Shipper</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body class="bg-body-tertiary">
  <main class="container my-4 my-md-5">
    <c:if test="${not empty requestScope.success}">
      <div class="alert alert-success"><i class="bi bi-check-circle me-2"></i>${requestScope.success}</div>
    </c:if>
    <c:if test="${not empty requestScope.error}">
      <div class="alert alert-danger"><i class="bi bi-x-circle me-2"></i>${requestScope.error}</div>
    </c:if>

    <section class="row g-4 mb-4">
      <div class="col-12 col-md-4">
        <div class="card h-100 border-0 shadow-sm">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Đơn hàng đang giao</div>
              <div class="fs-4 fw-semibold">${requestScope.stats.inProgress}</div>
            </div>
            <div class="display-6 text-primary"><i class="bi bi-truck"></i></div>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-4">
        <div class="card h-100 border-0 shadow-sm">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Đã giao thành công</div>
              <div class="fs-4 fw-semibold">${requestScope.stats.delivered}</div>
            </div>
            <div class="display-6 text-success"><i class="bi bi-check2-circle"></i></div>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-4">
        <div class="card h-100 border-0 shadow-sm">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Đơn bị hoàn / hủy</div>
              <div class="fs-4 fw-semibold">${requestScope.stats.canceled}</div>
            </div>
            <div class="display-6 text-danger"><i class="bi bi-x-octagon"></i></div>
          </div>
        </div>
      </div>
    </section>

    <section class="card border-0 shadow-sm mb-4">
      <div class="card-header bg-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Danh sách đơn hàng cần giao</h5>
        <a href="${pageContext.request.contextPath}/shipper/orders" class="small text-decoration-none">Xem tất cả →</a>
      </div>

      <div class="card-body p-0">
        <c:choose>
          <c:when test="${not empty orders}">
            <div class="table-responsive">
              <table class="table table-hover mb-0 align-middle">
                <thead class="table-light">
                  <tr>
                    <th scope="col">Khách hàng</th>
                    <th scope="col">Địa chỉ giao</th>
                    <th scope="col">SĐT</th>
                    <th scope="col">Giá trị</th>
                    <th scope="col">Trạng thái</th>
                    <th scope="col" class="text-center">Hành động</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="order" items="${orders}">
                    <tr>
                      <td>
                        <c:choose>
                          <c:when test="${not empty order.user and not empty order.user.fullname}">${order.user.fullname}</c:when>
                          <c:otherwise>Khách lẻ</c:otherwise>
                        </c:choose>
                      </td>

                      <td>
                        <c:choose>
                          <c:when test="${not empty order.user and not empty order.user.diaChi}">${order.user.diaChi}</c:when>
                          <c:otherwise>—</c:otherwise>
                        </c:choose>
                      </td>

                      <td>
                        <c:choose>
                          <c:when test="${not empty order.user and not empty order.user.sdt}">${order.user.sdt}</c:when>
                          <c:otherwise>—</c:otherwise>
                        </c:choose>
                      </td>

                      <td>
                        <fmt:formatNumber
                          value="${empty order.tongTien ? (order.soLuong * order.donGia) : order.tongTien}"
                          type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                      </td>

                      <td>
                        <c:choose>
                          <c:when test="${empty order.ghiChu}"><span class="badge text-bg-warning">Đang giao</span></c:when>
                          <c:when test="${order.ghiChu eq 'Đang giao'}"><span class="badge text-bg-warning">${order.ghiChu}</span></c:when>
                          <c:when test="${order.ghiChu eq 'Hoàn thành'}"><span class="badge text-bg-success">${order.ghiChu}</span></c:when>
                          <c:when test="${order.ghiChu eq 'Hủy'}"><span class="badge text-bg-danger">${order.ghiChu}</span></c:when>
                          <c:otherwise><span class="badge text-bg-secondary">${order.ghiChu}</span></c:otherwise>
                        </c:choose>
                      </td>

                      <td class="text-center">
                        <c:choose>
                          <c:when test="${order.ghiChu eq 'Hoàn thành'}">
                            <button type="button" class="btn btn-sm btn-success" disabled title="Đơn đã giao xong">
                              <i class="bi bi-check2-circle me-1"></i> Đã giao
                            </button>
                          </c:when>
                          <c:when test="${order.ghiChu eq 'Hủy'}">
                            <button type="button" class="btn btn-sm btn-success" disabled title="Đơn đã hủy">
                              <i class="bi bi-check2-circle me-1"></i> Đã hủy
                            </button>
                          </c:when>
                          <c:otherwise>
                            <form action="${pageContext.request.contextPath}/shipper/order/complete" method="post" class="d-inline">
                              <input type="hidden" name="id" value="${order.id}" />
                              <button type="submit" class="btn btn-sm btn-success">
                                <i class="bi bi-check2-circle me-1"></i> Giao thành công
                              </button>
                            </form>
                          </c:otherwise>
                        </c:choose>
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
    </section>

    <section class="card border-0 shadow-sm">
      <div class="card-header bg-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Hoạt động gần đây</h5>
        <a href="${pageContext.request.contextPath}/shipper/activities" class="small text-decoration-none">Xem tất cả</a>
      </div>

      <div class="card-body p-0">
        <c:choose>
          <c:when test="${not empty requestScope.activities}">
            <ul class="list-group list-group-flush">
              <c:forEach var="act" items="${requestScope.activities}">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                  <div>
                    <div class="fw-semibold">${act.title}</div>
                    <div class="small text-muted">${act.description}</div>
                  </div>
                  <div class="text-end small text-muted">${act.timeAgo}</div>
                </li>
              </c:forEach>
            </ul>
          </c:when>
          <c:otherwise>
            <div class="p-4 text-center text-muted">Không có hoạt động nào gần đây.</div>
          </c:otherwise>
        </c:choose>
      </div>
    </section>
  </main>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
