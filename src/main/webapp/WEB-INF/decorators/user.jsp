<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property="title" default="User - MyApp"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <sitemesh:write property="head"/>
</head>
<body>
    <jsp:include page="/commons/user/header.jsp"/>
    
    <main class="container my-4">
        <sitemesh:write property="body"/>
    </main>
    
    <jsp:include page="/commons/user/footer.jsp"/>
</body>
</html>