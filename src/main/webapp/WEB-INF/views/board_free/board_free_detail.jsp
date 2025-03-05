<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<link rel="stylesheet" href="/resources/css/board_free/board_free.css">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/resources/js/board_free/board_free.js"></script>
</head>
<body>
<div>
    <div>
        <div>작성인 : ${post.p_name}</div>
        <div>${post.p_begin}</div>
        <div>제목 : ${post.p_title}</div>
    </div>
    <div>
    <div><img src="/board_free/board_free_img/${post.p_img}"></div>
    <div>내용 : ${post.p_text}</div>
    <div>작성일 : <c:formatDate value="${post.p_date}" pattern="yyyy-MM-dd HH:mm"/></div>
</div>
</body>
</html>