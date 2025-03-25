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
        <div class="comment-header">コメントを書く</div>
        <div hidden="hidden">ニックネーム : <input name="user_nickname" value="${user.user_nickname}" type="text"
                                          placeholder="${user.user_nickname}" readonly></div>
        <textarea id="replyContent" placeholder="コメントを入力してください..."></textarea>
        <button onclick="insertReply()">コメント投稿</button>
    </div>
    <c:choose>
        <c:when test="${not empty replys}">
            <c:forEach items="${replys}" var="r">
                <span>投稿者 : ${r.c_writer}</span>
                <span><fmt:formatDate value="${r.c_date}" pattern="YYYY-MM-DD HH:mm"/></span>
                <span>${r.c_context}</span>
                <c:if test="${user.user_nickname == r.c_writer}">
                    <button>削除</button>
                    <button>修正</button>
                </c:if>
                <br>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>コメントはまだありません。ぜひ最初のコメントを投稿してください！</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>