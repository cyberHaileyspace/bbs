<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <link rel="stylesheet" href="/resources/css/free/free.css">
    <%-- 스타일 추가 --%>
</head>
<body>
<div class="container">
    <div class="header">
        <button class="register-btn">등록하기</button>
    </div>

    <div class="post-list">
        <c:choose>
            <c:when test="${not empty posts}">
                <c:forEach items="${posts}" var="p">
                    <div class="post-item" onclick="location.href='free/${p.post_id}'">
                        <div class="post-header">
                            <span class="post-no">No. ${p.post_id}</span>
                            <span class="post-name">${p.user_nickname}</span>
                            <span class="post-date"><fmt:formatDate value="${p.post_date}"
                                                                    pattern="yyyy-MM-dd HH:mm"/></span>
                        </div>
                        <div class="post-content">
                            <div class="post-title">${p.post_title}</div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>게시글이 없습니다. 게시글을 작성해 보세요!</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
