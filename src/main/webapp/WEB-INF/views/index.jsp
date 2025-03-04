<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Diaspora - ディアスポラ</title>
    <link rel="stylesheet" href="/resources/css/sample.css">
    <script src="/resources/js/sample.js"></script>
</head>
<body>
<div class="header">
    <div>
        <img width="50px" src="/resources/css/Diaspora.png" class="panel-btn">
    </div>
    <div onclick="location.href='/'" style="cursor: pointer">
        Diaspora - ディアスポラ
    </div>
    <c:choose>
        <c:when test="${user ne null}">
            <div style="font-size: 20px">
                <span onclick="location.href='/mypage'" style="cursor: pointer">마이페이지</span>
                &nbsp;|&nbsp;
                    <%-- <span onclick="location.href='/register'">会員登録</span> --%>
                <span onclick="location.href='/logout'" style="cursor: pointer">로그아웃</span>
            </div>
        </c:when>
        <c:otherwise>
            <div style="font-size: 20px">
                <span onclick="location.href='/login'" style="cursor: pointer">로그인</span>
                &nbsp;|&nbsp;
                <span onclick="location.href='/register'" style="cursor: pointer">회원가입</span>
            </div>
        </c:otherwise>
    </c:choose>

</div>
<div class="panel">
    <div><h2>뉴스</h2></div>
    <div><h2>자유게시판</h2></div>
    <div><h2>관광게시판</h2></div>
    <div><h2>생활게시판</h2></div>
    <div onclick="location.href='/login'" style="cursor: pointer"><h2>로그인</h2></div>
    <div onclick="location.href='/register'" style="cursor: pointer"><h2>회원가입</h2></div>
    <div onclick="location.href='https://www.kr.emb-japan.go.jp/itprtop_ko/index.html'" style="cursor: pointer;"><h2>주한
        일본 대사관</h2></div>
</div>
<div class="main">
    <div class="main-content">
        <jsp:include page="${content}"></jsp:include>
    </div>
</div>
<div class="footer">푸터</div>
</body>
</html>