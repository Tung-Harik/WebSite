<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý người dùng</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary">

<div class="container py-4">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="h4 mb-0"><i class="bi bi-people me-2"></i>Quản lý người dùng</h2>
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createModal">
      <i class="bi bi-person-plus me-1"></i> Thêm người dùng
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
              <th>Username</th>
              <th>Họ tên</th>
              <th>Email</th>
              <th>SĐT</th>
              <th>Địa chỉ</th>
              <th class="text-center" style="width:120px;">Role</th>
              <th class="text-end" style="width:220px;">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty users}">
                <tr><td colspan="8" class="text-center text-muted p-4">Chưa có người dùng nào.</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="u" items="${users}">
                  <tr>
                    <td>${u.id}</td>
                    <td>${u.username}</td>
                    <td>${u.fullname}</td>
                    <td>${u.email}</td>
                    <td>${u.sdt}</td>
                    <td>${u.diaChi}</td>
                    <td class="text-center">
                      <span class="badge 
  							${u.roleID == 1 ? 'bg-danger' 
 								 : (u.roleID == 2 ? 'bg-warning text-dark' 
  								 : (u.roleID == 3 ? 'bg-secondary' 
								 : (u.roleID == 4 ? 'bg-info text-dark' 
								 : (u.roleID == 5 ? 'bg-success' : 'bg-light text-dark'))))}">
							${u.roleID == 1 ? 'ADMIN' 
						 		 : (u.roleID == 2 ? 'MANAGER' 
								 : (u.roleID == 3 ? 'USER' 
  							     : (u.roleID == 4 ? 'SELLER' 
                                 : (u.roleID == 5 ? 'SHIPPER' : 'UNKNOWN'))))}
						</span>
                    </td>
                    <td class="text-end">
                      <button
                        class="btn btn-sm btn-outline-primary"
                        data-bs-toggle="modal"
                        data-bs-target="#editModal"
                        data-id="${u.id}"
                        data-username="${u.username}"
                        data-fullname="${u.fullname}"
                        data-email="${u.email}"
                        data-sdt="${u.sdt}"
                        data-diachi="${u.diaChi}"
                        data-roleid="${u.roleID}">
                        Sửa
                      </button>

                      <form action="${pageContext.request.contextPath}/admin/users" class="d-inline" method="post"
                            onsubmit="return confirm('Xoá người dùng #${u.id}?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${u.id}">
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
    <form class="modal-content" method="post" action="${pageContext.request.contextPath}/admin/users">
      <input type="hidden" name="action" value="create">
      <div class="modal-header">
        <h5 class="modal-title">Thêm người dùng</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label class="form-label">Username *</label>
          <input type="text" name="username" class="form-control" required maxlength="50">
        </div>
        <div class="mb-3">
          <label class="form-label">Password *</label>
          <input type="password" name="password" class="form-control" required maxlength="50">
        </div>
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">Họ tên</label>
            <input type="text" name="fullname" class="form-control" maxlength="50">
          </div>
          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" maxlength="50">
          </div>
        </div>
        <div class="row g-3 mt-1">
          <div class="col-md-6">
            <label class="form-label">SĐT</label>
            <input type="text" name="sdt" class="form-control" maxlength="50">
          </div>
          <div class="col-md-6">
            <label class="form-label">Địa chỉ</label>
            <input type="text" name="diaChi" class="form-control" maxlength="50">
          </div>
        </div>
        <div class="mt-3">
          <label class="form-label">Role</label>
          <select name="roleID" class="form-select">
            <option value="1">ADMIN</option>
            <option value="2">MANAGER</option>
            <option value="3" selected>USER</option>
            <option value="4">SELLER</option>
            <option value="5">SHIPPER</option>
          </select>
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
    <form class="modal-content" method="post" action="${pageContext.request.contextPath}/admin/users">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" id="edit-id">
      <div class="modal-header">
        <h5 class="modal-title">Sửa người dùng</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label class="form-label">Username</label>
          <input type="text" name="username" id="edit-username" class="form-control" maxlength="50">
        </div>
        <div class="mb-3">
          <label class="form-label">Mật khẩu (để trống nếu không đổi)</label>
          <input type="password" name="password" id="edit-password" class="form-control" maxlength="50">
        </div>
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">Họ tên</label>
            <input type="text" name="fullname" id="edit-fullname" class="form-control" maxlength="50">
          </div>
          <div class="col-md-6">
            <label class="form-label">Email</label>
            <input type="email" name="email" id="edit-email" class="form-control" maxlength="50">
          </div>
        </div>
        <div class="row g-3 mt-1">
          <div class="col-md-6">
            <label class="form-label">SĐT</label>
            <input type="text" name="sdt" id="edit-sdt" class="form-control" maxlength="50">
          </div>
          <div class="col-md-6">
            <label class="form-label">Địa chỉ</label>
            <input type="text" name="diaChi" id="edit-diachi" class="form-control" maxlength="50">
          </div>
        </div>
        <div class="mt-3">
          <label class="form-label">Role</label>
          <select name="roleID" id="edit-roleID" class="form-select">
            <option value="1">ADMIN</option>
            <option value="2">MANAGER</option>
            <option value="3">USER</option>
          </select>
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
// Điền dữ liệu vào modal Sửa
const editModal = document.getElementById('editModal');
editModal.addEventListener('show.bs.modal', function (event) {
  const btn = event.relatedTarget;
  document.getElementById('edit-id').value        = btn.getAttribute('data-id');
  document.getElementById('edit-username').value  = btn.getAttribute('data-username');
  document.getElementById('edit-fullname').value  = btn.getAttribute('data-fullname');
  document.getElementById('edit-email').value     = btn.getAttribute('data-email');
  document.getElementById('edit-sdt').value       = btn.getAttribute('data-sdt');
  document.getElementById('edit-diachi').value    = btn.getAttribute('data-diachi');
  document.getElementById('edit-roleID').value    = btn.getAttribute('data-roleid');
  document.getElementById('edit-password').value  = ""; // luôn rỗng
});
</script>
</body>
</html>
