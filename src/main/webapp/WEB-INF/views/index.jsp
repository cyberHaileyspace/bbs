<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Diaspora - ディアスポラ</title>
    <link rel="stylesheet" href="/resources/css/sample.css">
    <link rel="stylesheet" href="/resources/css/board.css">
    <link rel="stylesheet" href="/resources/css/main.css"/>
    <link rel="stylesheet" href="/resources/css/tour.css"/>
    <link rel="stylesheet" href="/resources/css/tour_place.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="/resources/js/sample.js"></script>
</head>
<body>
<div class="header">
    <div style="display: flex; flex-direction: row; align-items: center">
        <img width="50px" src="/resources/css/Diaspora.png" class="panel-btn"/>
    </div>
    <div onclick="location.href='/'" style="cursor: pointer">
        Diaspora - ディアスポラ
    </div>
    <c:choose>
        <c:when test="${user ne null}">
            <div style="font-size: 20px">
            <span onclick="location.href='/mypage'" style="cursor: pointer"
            >${user.user_nickname} 님의 마이페이지</span
            >
                &nbsp;|&nbsp; <%--
            <span onclick="location.href='/register'">会員登録</span> --%>
                <span onclick="location.href='/logout'" style="cursor: pointer"
                >로그아웃</span
                >
            </div>
        </c:when>
        <c:otherwise>
            <div style="font-size: 20px">
            <span onclick="location.href='/login'" style="cursor: pointer"
            >로그인</span
            >
                &nbsp;|&nbsp;
                <span onclick="location.href='/user'" style="cursor: pointer"
                >회원가입</span
                >
            </div>
        </c:otherwise>
    </c:choose>
</div>
<div class="panel">
    <div onclick="location.href='/main/news'" style="cursor: pointer">해외 뉴스</div>
    <div onclick="location.href='/main/free'" style="cursor: pointer">자유게시판</div>
    <form id="defaultTourForm" action="/main/tour/loc" method="get">
        <input type="hidden" name="areaCode" value="1"/>
        <input type="hidden" name="sigungu" value=""/>
        <input type="hidden" name="sort" value="R"/>
        <input type="hidden" name="pageNo" value="1"/>
    </form>
    <div onclick="document.getElementById('defaultTourForm').submit()" style="cursor: pointer">관광게시판</div>
    <div onclick="location.href='/main/life'" style="cursor: pointer">생활게시판</div>
    <div onclick="location.href='/login'" style="cursor: pointer">로그인</div>
    <div onclick="location.href='/user'" style="cursor: pointer">회원가입</div>
    <div onclick="location.href='https://www.kr.emb-japan.go.jp/itprtop_ko/index.html'" style="cursor: pointer;">
        在大韓民国日本国大使館
    </div>
</div>
<%--<div class="panel">
    <div onclick="location.href='/main/news'" style="cursor: pointer">
        해외 뉴스
    </div>
    <div onclick="location.href='/main/free'" style="cursor: pointer">
        자유게시판
    </div>
    <div onclick="location.href='/main/tour'" style="cursor: pointer">
        관광게시판
    </div>
    <div onclick="location.href='/main/life'" style="cursor: pointer">
        생활게시판
    </div>
    <div onclick="location.href='/login'" style="cursor: pointer">로그인</div>
    <div onclick="location.href='/user'" style="cursor: pointer">
        회원가입
    </div>
    <div
            onclick="location.href='https://www.kr.emb-japan.go.jp/itprtop_ko/index.html'"
            style="cursor: pointer"
    >
        在大韓民国日本国大使館
    </div>
</div>--%>
<div class="main">
    <div class="main-cnt">
        <jsp:include page="${content}"></jsp:include>
    </div>
</div>
<div class="footer">
    <div style="font-size: 12px">
        디아스포라를 통해 한국 생활 및 비즈니스에 유용한 각종 최신 꿀팁 정보를
        공유해 보세요
    </div>
    <div>
        <h4>© 2025 디아스포라(Diaspora) 한국 일본인 생활 정보 커뮤니티</h4>
    </div>
</div>
</body>
</html>
