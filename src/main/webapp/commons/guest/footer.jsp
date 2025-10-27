<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- WEB-INF/layout/footer.jsp -->


<footer class="bg-white border-top mt-4">
  <div class="container container-narrow d-flex flex-wrap justify-content-between align-items-center py-3">
    <span class="text-muted">© <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy" /> UTE Shop</span>
    <ul class="nav">
      <li class="nav-item"><a href="${pageContext.request.contextPath}/guest/about" class="nav-link px-2 text-muted">Giới thiệu</a></li>
      <li class="nav-item"><a href="${pageContext.request.contextPath}/guest/policy" class="nav-link px-2 text-muted">Chính sách</a></li>
      <li class="nav-item"><a href="${pageContext.request.contextPath}/guest/contact" class="nav-link px-2 text-muted">Liên hệ</a></li>
    </ul>
  </div>
</footer>
