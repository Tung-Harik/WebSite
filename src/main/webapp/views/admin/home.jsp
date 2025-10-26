<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Bảng điều khiển Admin</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap + Icons -->
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
      <div class="col-12 col-md-3">
        <div class="card h-100">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Tổng sản phẩm</div>
              <div class="fs-4 fw-semibold">${requestScope.adminStats.totalProducts}</div>
            </div>
            <div class="display-6 text-primary"><i class="bi bi-box-seam"></i></div>
          </div>
          <div class="card-footer bg-transparent border-0 pt-0">
            <a href="${pageContext.request.contextPath}/admin/products" class="small text-decoration-none">Quản lý sản phẩm →</a>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-3">
        <div class="card h-100">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Đơn hàng hôm nay</div>
              <div class="fs-4 fw-semibold">${requestScope.adminStats.ordersToday}</div>
            </div>
            <div class="display-6 text-primary"><i class="bi bi-receipt"></i></div>
          </div>
          <div class="card-footer bg-transparent border-0 pt-0">
            <a href="${pageContext.request.contextPath}/admin/orders" class="small text-decoration-none">Xem đơn hàng →</a>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-3">
        <div class="card h-100">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Người dùng</div>
              <div class="fs-4 fw-semibold">${requestScope.adminStats.totalUsers}</div>
            </div>
            <div class="display-6 text-primary"><i class="bi bi-people"></i></div>
          </div>
          <div class="card-footer bg-transparent border-0 pt-0">
            <a href="${pageContext.request.contextPath}/admin/users" class="small text-decoration-none">Quản lý người dùng →</a>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-3">
        <div class="card h-100">
          <div class="card-body d-flex justify-content-between align-items-center">
            <div>
              <div class="text-muted small">Doanh thu hôm nay</div>
              <div class="fs-4 fw-semibold">
                <fmt:formatNumber value="${requestScope.adminStats.revenueToday}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
              </div>
            </div>
            <div class="display-6 text-primary"><i class="bi bi-currency-dollar"></i></div>
          </div>
          <div class="card-footer bg-transparent border-0 pt-0">
            <a href="${pageContext.request.contextPath}/admin/reports" class="small text-decoration-none">Báo cáo doanh thu →</a>
          </div>
        </div>
      </div>
    </section>

    <!-- Two columns: Quick actions + Recent tables -->
    <section class="row g-4">
      <!-- Quick actions -->
      <div class="col-lg-4">
        <div class="card h-100">
          <div class="card-header bg-white">
            <h5 class="mb-0">Tác vụ nhanh</h5>
          </div>
          <div class="card-body">
            <div class="d-grid gap-2">
              <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/products/new">
                <i class="bi bi-plus-circle me-1"></i> Thêm sản phẩm
              </a>
              <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/orders">
                <i class="bi bi-receipt me-1"></i> Duyệt đơn hàng
              </a>
              <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/users">
                <i class="bi bi-people me-1"></i> Quản lý người dùng
              </a>
              <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/reports">
                <i class="bi bi-bar-chart-line me-1"></i> Báo cáo
              </a>
            </div>
          </div>
          <div class="card-footer bg-white">
            <small class="text-muted">Cập nhật lần cuối: <fmt:formatDate value="${requestScope.adminStats.lastSync}" pattern="dd/MM/yyyy HH:mm"/></small>
          </div>
        </div>
      </div>

      <!-- Recent lists -->
			<div class="card h-100">
				<div
					class="card-header bg-white d-flex justify-content-between align-items-center">
					<h5 class="mb-0">Đơn hàng gần đây</h5>
					<a href="${pageContext.request.contextPath}/admin/orders"
						class="small text-decoration-none">Xem tất cả</a>
				</div>

				<div class="card-body p-0">
					<c:choose>
						<c:when test="${not empty orders}">
							<div class="table-responsive">
								<table class="table table-hover align-middle mb-0">
									<thead class="table-light text-center">
										<tr>
											<th>Ngày lập</th>
											<th>Khách hàng</th>
											<th>Địa chỉ</th>
											<th>SĐT</th>
											<th>Sản phẩm</th>
											<th>SL</th>
											<th>Đơn giá</th>
											<th>Tổng tiền</th>
											<th>Ghi chú</th>
											<th class="text-end">Thao tác</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="o" items="${orders}">
											<tr class="text-center">
												<td><fmt:formatDate value="${o.ngayLap}"
														pattern="dd/MM/yyyy HH:mm" /></td>

												<td>${o.user.fullname}</td>
												<td>${o.user.diaChi}</td>
												<td>${o.user.sdt}</td>

												<!-- Sản phẩm & số lượng -->
												<td>${o.product.name}</td>
												<td>${o.soLuong}</td>

												<!-- Giá & tổng tiền -->
												<td><fmt:formatNumber value="${o.donGia}"
														type="currency" currencySymbol="₫" maxFractionDigits="0" />
												</td>
												<td><fmt:formatNumber
														value="${empty o.tongTien ? o.soLuong * o.donGia : o.tongTien}"
														type="currency" currencySymbol="₫" maxFractionDigits="0" />
												</td>

												<td class="text-truncate" style="max-width: 200px;"
													title="${o.ghiChu}">${o.ghiChu}</td>

												<td class="text-end"><a
													class="btn btn-sm btn-outline-primary"
													href="${pageContext.request.contextPath}/admin/orders/detail?id=${o.id}">
														Chi tiết </a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:when>
						<c:otherwise>
							<div class="p-4 text-center text-muted">Chưa có đơn hàng
								nào gần đây.</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- Recent products -->
        <div class="card h-100 mt-4">
          <div class="card-header bg-white d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Sản phẩm mới thêm</h5>
            <a href="${pageContext.request.contextPath}/admin/products" class="small text-decoration-none">Quản lý sản phẩm</a>
          </div>
          <div class="card-body p-0">
            <c:choose>
              <c:when test="${not empty requestScope.recentProducts}">
                <div class="list-group list-group-flush">
                  <c:forEach var="p" items="${requestScope.recentProducts}">
                    <div class="list-group-item d-flex justify-content-between align-items-center">
                      <div class="me-3">
                        <div class="fw-semibold">${p.name}</div>
                        <div class="small text-muted">
                          Giá:
                          <fmt:formatNumber value="${p.prices}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                          • Thêm lúc: <fmt:formatDate value="${p.createdAt}" pattern="dd/MM HH:mm"/>
                        </div>
                      </div>
                      <div class="text-end">
                        <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.id}" class="btn btn-sm btn-outline-secondary">
                          <i class="bi bi-pencil-square"></i>
                        </a>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </c:when>
              <c:otherwise>
                <div class="p-4 text-center text-muted">Chưa có sản phẩm nào mới.</div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </section>
  </main>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
