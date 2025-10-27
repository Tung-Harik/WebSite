<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- WEB-INF/layout/header.jsp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<nav class="navbar navbar-expand-lg bg-white sticky-top border-bottom">
  <div class="container container-narrow">
    <a class="navbar-brand fw-bold" href="${ctx}/trangchu">Gift Shop UTE</a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div id="navMain" class="collapse navbar-collapse">
      <form class="d-flex ms-lg-3 my-3 my-lg-0" action="${ctx}/guest/home" method="get">
        <input class="form-control me-2" name="q" type="search" placeholder="Tìm sản phẩm..." />
        <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
      </form>

      <ul class="navbar-nav ms-auto">
        <li class="nav-item me-2"><a class="btn btn-outline-secondary" href="${ctx}/user/cart"><i class="bi bi-bag"></i> Giỏ hàng</a></li>
        <li class="nav-item me-2"><a class="btn btn-primary" href="${ctx}/login">Đăng nhập</a></li>
        <li class="nav-item"><a class="btn btn-outline-primary" href="${ctx}/register">Đăng ký</a></li>
      </ul>
    </div>
  </div>
</nav>

