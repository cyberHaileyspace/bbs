<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/sample.css">
</head>
<body>
<c:forEach items="${lifewrite}" var="l">
    <div class="item">
        <div>번호 : ${l.post_id}</div>
        <div>제목 : ${l.post_title}</div>
        <div>작성자 : ${l.user_nickname}</div>
        <div>작성일 : <fmt:formatDate value="${l.post_date}" pattern="yyyy-MM-dd"/></div>
        <%--<div>
            <button onclick="location.href='delete?pk=${p.p_no}'">삭제</button>
        </div>--%>
    </div>
    <hr>
</c:forEach>
<button onclick="location.href='write'">작성</button>
</body>
</html>