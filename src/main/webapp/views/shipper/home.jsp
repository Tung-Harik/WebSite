<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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


  <!-- Main content -->
  <main class="container my-4 my-md-5">

    <!-- Alerts -->
    <c:if test="${not empty requestScope.success}">
      <div class="alert alert-success"><i class="bi bi-check-circle me-2"></i>${requestScope.success}</div>
    </c:if>
    <c:if test="${not empty requestScope.error}">
      <div class="alert alert-danger"><i class="bi bi-x-circle me-2"></i>${requestScope.error}</div>
    </c:if>

    <!-- Quick stats -->
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

    <!-- Danh sách đơn hàng -->
    <section class="card border-0 shadow-sm mb-4">
      <div class="card-header bg-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Danh sách đơn hàng cần giao</h5>
        <a href="${pageContext.request.contextPath}/shipper/orders" class="small text-decoration-none">Xem tất cả →</a>
      </div>

      <div class="card-body p-0">
        <c:choose>
          <c:when test="${not empty requestScope.orders}">
            <div class="table-responsive">
              <table class="table table-hover mb-0 align-middle">
                <thead class="table-light">
                  <tr>
                    <th scope="col">Mã đơn</th>
                    <th scope="col">Khách hàng</th>
                    <th scope="col">Địa chỉ giao</th>
                    <th scope="col">Giá trị</th>
                    <th scope="col">Trạng thái</th>
                    <th scope="col" class="text-center">Hành động</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="order" items="${requestScope.orders}">
                    <tr>
                      <td>#${order.id}</td>
                      <td>${order.customerName}</td>
                      <td>${order.address}</td>
                      <td>
                        <fmt:formatNumber value="${order.total}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${order.status eq 'Đang giao'}">
                            <span class="badge text-bg-warning">${order.status}</span>
                          </c:when>
                          <c:when test="${order.status eq 'Hoàn thành'}">
                            <span class="badge text-bg-success">${order.status}</span>
                          </c:when>
                          <c:when test="${order.status eq 'Hủy'}">
                            <span class="badge text-bg-danger">${order.status}</span>
                          </c:when>
                          <c:otherwise>
                            <span class="badge text-bg-secondary">${order.status}</span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td class="text-center">
                        <a href="${pageContext.request.contextPath}/shipper/order/detail?id=${order.id}" class="btn btn-sm btn-outline-primary">
                          <i class="bi bi-eye"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/shipper/order/update?id=${order.id}" class="btn btn-sm btn-outline-success">
                          <i class="bi bi-pencil"></i>
                        </a>
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

    <!-- Hoạt động gần đây -->
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
