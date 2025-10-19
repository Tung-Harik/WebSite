<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý sản phẩm</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">

<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="h4 mb-0"><i class="bi bi-box-seam me-2"></i>Quản lý sản phẩm</h2>
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createModal">
      <i class="bi bi-plus-lg me-1"></i> Thêm sản phẩm
    </button>
  </div>

  <!-- Alerts -->
  <c:if test="${not empty sessionScope.flash}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      ${sessionScope.flash}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="flash" scope="session"/>
  </c:if>
  <c:if test="${not empty sessionScope.flashError}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      ${sessionScope.flashError}
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="flashError" scope="session"/>
  </c:if>

  <!-- List -->
  <div class="card shadow-sm">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
          <thead class="table-light">
            <tr>
              <th style="width:80px;">ID</th>
              <th>Tên sản phẩm</th>
              <th class="text-end" style="width:220px;">Giá</th>
              <th class="text-end" style="width:220px;">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty products}">
                <tr><td colspan="4" class="text-center text-muted p-4">Chưa có sản phẩm nào.</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="p" items="${products}">
                  <tr>
                    <td>${p.id}</td>
                    <td>${p.name}</td>
                    <td class="text-end">
                      <fmt:formatNumber value="${p.prices}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </td>
                    <td class="text-end">
                      <button
                        class="btn btn-sm btn-outline-primary"
                        data-bs-toggle="modal"
                        data-bs-target="#editModal"
                        data-id="${p.id}"
                        data-name="${p.name}"
                        data-prices="${p.prices}">
                        Sửa
                      </button>

                      <form action="${pageContext.request.contextPath}/admin/products" method="post" class="d-inline"
                            onsubmit="return confirm('Xoá sản phẩm #${p.id}?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${p.id}">
                        <button class="btn btn-sm btn-outline-danger" type="submit">Xoá</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Modal: Create -->
<div class="modal fade" id="createModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <form class="modal-content" method="post" action="${pageContext.request.contextPath}/admin/products">
      <input type="hidden" name="action" value="create">
      <div class="modal-header">
        <h5 class="modal-title">Thêm sản phẩm</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label class="form-label">Tên sản phẩm</label>
          <input type="text" name="name" class="form-control" required maxlength="50">
        </div>
        <div class="mb-3">
          <label class="form-label">Giá (₫)</label>
          <input type="text" name="prices" class="form-control" placeholder="VD: 120000" required>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Huỷ</button>
        <button class="btn btn-primary" type="submit">Lưu</button>
      </div>
    </form>
  </div>
</div>

<!-- Modal: Edit -->
<div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <form class="modal-content" method="post" action="${pageContext.request.contextPath}/admin/products">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" id="edit-id">
      <div class="modal-header">
        <h5 class="modal-title">Sửa sản phẩm</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label class="form-label">Tên sản phẩm</label>
          <input type="text" name="name" id="edit-name" class="form-control" required maxlength="50">
        </div>
        <div class="mb-3">
          <label class="form-label">Giá (₫)</label>
          <input type="text" name="prices" id="edit-prices" class="form-control" required>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Huỷ</button>
        <button class="btn btn-warning" type="submit">Cập nhật</button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Điền dữ liệu vào modal Sửa từ nút "Sửa"
const editModal = document.getElementById('editModal');
editModal.addEventListener('show.bs.modal', function (event) {
  const btn = event.relatedTarget;
  document.getElementById('edit-id').value     = btn.getAttribute('data-id');
  document.getElementById('edit-name').value   = btn.getAttribute('data-name');
  document.getElementById('edit-prices').value = btn.getAttribute('data-prices');
});
</script>
</body>
</html>
