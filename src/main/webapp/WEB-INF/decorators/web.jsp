<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>

</head>
<body class="bg-body-tertiary">

    <!-- Header dùng chung -->
    <jsp:include page="/commons/user/header.jsp"/>

    <!-- Nội dung trang con -->
    <sitemesh:write property="body"/>

    <!-- Footer dùng chung -->
    <jsp:include page="/commons/user/footer.jsp"/>

    <sitemesh:write property="page.script"/>
</body>
</html>
