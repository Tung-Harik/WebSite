<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Bootstrap + Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  
<nav class="navbar navbar-expand-lg bg-white border-bottom sticky-top">
  <div class="container">
    <a class="navbar-brand fw-semibold" href="${pageContext.request.contextPath}/admin/home">
      <i class="bi bi-hexagon-fill me-2"></i>MyApp
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div id="navMain" class="collapse navbar-collapse">
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door me-1"></i>Trang chủ</a></li>
      </ul>
      <div class="d-flex align-items-center gap-3">
        <span class="text-muted small d-none d-md-inline">
          Xin chào, <strong><c:out value="${sessionScope.account.fullname}"/></strong>
        </span>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary btn-sm">
          <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
        </a>
      </div>
    </div>
  </div>
</nav>
    