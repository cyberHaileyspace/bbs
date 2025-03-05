<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Diaspora - ディアスポラ</title>
    <link rel="stylesheet" href="/resources/css/sample.css">
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="/resources/css/tour.css">
    <script src="/resources/js/sample.js"></script>
</head>
<body>
<div class="header">
    <div style="display: flex; flex-direction: row; align-items: center">
        <img width="50px" src="/resources/css/Diaspora.png" class="panel-btn">
    </div>
    <div onclick="location.href='/'" style="cursor: pointer;">
        Diaspora - ディアスポラ
    </div>
    <c:choose>
        <c:when test="${user ne null}">
            <div style="font-size: 20px">
                <span onclick="location.href='/mypage'" style="cursor: pointer">${user.user_nickname} 님의 마이페이지</span>
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
    <div onclick="location.href='/main/tour'"><h2>관광게시판</h2></div>
    <div><h2>생활게시판</h2></div>
    <div onclick="location.href='/login'" style="cursor: pointer"><h2>로그인</h2></div>
    <div onclick="location.href='/register'" style="cursor: pointer"><h2>회원가입</h2></div>
    <div onclick="location.href='https://www.kr.emb-japan.go.jp/itprtop_ko/index.html'" style="cursor: pointer;"><h2>在大韓民国日本国大使館</h2></div>
</div>
<div class="main">
    <div class="main-content">
        <jsp:include page="${content}"></jsp:include>
    </div>
</div>
<div class="footer">
    <div style="font-size: 12px">차이나톡을 통해 중국 생활 및 비즈니스에 유용한 각종 최신 꿀팁 정보를 공유해 보세요</div>
    <div><h4>© 2025 차이나톡(ChinaTalk) 중국 한국인 생활 정보 커뮤니티</h4></div>
</div>
<script src="/resources/js/tour.js"></script>
</body>
</html>