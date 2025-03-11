<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%--<link rel="stylesheet" href="/resources/css/free/free.css">--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/resources/js/free/free.js"></script>

</head>
<body>
<div>
    <div class="comment-section">
        <div class="comment-header">댓글 쓰기</div>
        <textarea placeholder="댓글을 입력하세요..."></textarea>
        <button onclick="location.href='reply'">댓글 쓰기</button>
    </div>
    <c:choose>
    <c:when test="${not empty replys}">
    <c:forEach items="${replys}" var="r">
       <span>작성자 : ${r.c_writer}</span>
       <span><fmt:formatDate value="${r.c_date}" pattern="YYYY-MM-DD HH:mm"/></span>
       <span>${r.c_context}</span>
        <button>수정하기</button>
        <button>삭제하기</button>
        <br>
    </c:forEach>
    </c:when>
        <c:otherwise>
            <p>댓글이 없습니다. 댓글을 작성해 보세요!</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>