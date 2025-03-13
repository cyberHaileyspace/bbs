<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/life/life.css">
</head>
<body>
<c:forEach items="${lifewrite}" var="p">
    <div class="item">
            <%--<div>번호 : ${l.post_id}</div>
            <div>제목 : ${l.post_title}</div>
            <div>작성자 : ${l.user_nickname}</div>
            <div>작성일 : <fmt:formatDate value="${l.post_date}" pattern="yyyy-MM-dd"/></div>--%>
            <%--<div>
                <button onclick="location.href='delete?pk=${p.p_no}'">삭제</button>
            </div>--%>
        <div class="post-life" onclick="goToPost(${p.post_id})">
            <div class="life-kind">
                <div class="life-no">번호 : ${p.post_id }</div>&nbsp;/&nbsp;
                <div class="life-cate">카테고리 : ${p.post_category }</div>&nbsp;/&nbsp;
                <div class="life-menu">지역 : ${p.post_menu }</div>
            </div>
            <div class="life-title">${p.post_title }</div>
            <div class="life-context">
                <div class="life-text"><span>${p.post_context }</span></div>
                <div class="life-image"><img alt="" src="img/post/${p.post_image }"></div>
            </div>
            <div class="life-info">
                <div style="display: flex">
                    <div class="info-name">작성자 : ${p.user_nickname }</div>&nbsp;/&nbsp;
                    <div class="info-date">작성일 : <fmt:formatDate value="${p.post_date}" pattern="yyyy-MM-dd"/></div>
                </div>
                <div style="display: flex">
                    <div class="info-view">조회수 : ${p.post_view }</div>&nbsp;/&nbsp;
                    <div class="info-like">좋아요 : ${p.post_like }</div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<button class="write-btn" onclick="logincheck('${sessionScope.user}')">작성</button>
</body>
<script>
    function generateToken() {
        const now = new Date();
        const token = now.getMinutes() + ":" + now.getSeconds();  // "mm:ss" 형식
        return token;
    }

    function goToPost(postId) {
        const token = generateToken();
        sessionStorage.setItem("viewToken", token);
        location.href = "life/" + postId + "?token=" + token;
    }

    function logincheck(user) {
        if (user)
            location.href = "life/write";
        else {
            alert("먼저 로그인을 해주세요.");
            location.href = "/login"
        }
    }
</script>
</html>