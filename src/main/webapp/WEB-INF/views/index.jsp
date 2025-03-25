<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Diaspora - ディアスポラ</title>
    <link rel="stylesheet" href="/resources/css/sample.css"/>
    <link rel="stylesheet" href="/resources/css/board.css"/>
    <link rel="stylesheet" href="/resources/css/main.css"/>
    <link rel="stylesheet" href="/resources/css/tour.css"/>
    <link rel="stylesheet" href="/resources/css/tour_place.css"/>
    <link rel="stylesheet" href="/resources/css/board.css">
    <link rel="stylesheet" href="/resources/css/tourBoard.css">
    <script src="/resources/js/sample.js"></script>
</head>
<body>
<div style="max-width: 1300px; margin: 0 auto">
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
            >${user.user_nickname} 様のマイページ</span
            >

                    &nbsp;|&nbsp; <%--
            <span onclick="location.href='/register'">会員登録</span> --%>
                    <span onclick="location.href='/logout'" style="cursor: pointer"
                    >ログアウト</span
                    >
                </div>
            </c:when>
            <c:otherwise>
                <div style="font-size: 20px">
            <span onclick="location.href='/login'" style="cursor: pointer"
            >ログイン</span
            >
                    &nbsp;|&nbsp;
                    <span onclick="location.href='/user'" style="cursor: pointer"
                    >ユーザー登録</span
                    >
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="panel">
        <div onclick="location.href='/main/news'" style="cursor: pointer">
            ニュース・お知らせ
        </div>
        <div onclick="location.href='/main/free'" style="cursor: pointer">
            自由掲示板
        </div>
        <div onclick="location.href='/main/life'" style="cursor: pointer">
            生活掲示板
        </div>
        <div
                onclick="location.href='/main/tour'"
                style="cursor: pointer"
        >
            観光掲示板
        </div>
        <div onclick="document.getElementById('defaultTourForm').submit()" style="cursor: pointer">
            観光情報
        </div>
        <div onclick="location.href='/login'" style="cursor: pointer">ログイン</div>
        <div onclick="location.href='/user'" style="cursor: pointer">
            会員登録
        </div>
        <div
                onclick="location.href='https://www.kr.emb-japan.go.jp/itprtop_ko/index.html'"
                style="cursor: pointer"
        >
            在大韓民国日本国大使館
        </div>
    </div>
    <div class="main">
        <div class="main-cnt">
            <jsp:include page="${content}"></jsp:include>
        </div>
    </div>
    <div class="footer">
        <div style="font-size: 12px">
            ディアスポラを通じて、韓国での生活やビジネスに役立つ最新のヒントを共有しましょう。
        </div>
        <div>
            <h4>© 2025 ディアスポラ（Diaspora） 韓国在住日本人のための生活情報コミュニティ</h4>
        </div>
    </div>
</div>
        <form id="defaultTourForm" action="/main/tourInfo/loc" method="get">
            <input type="hidden" name="areaCode" value="1"/>
            <input type="hidden" name="sigungu" value=""/>
            <input type="hidden" name="sort" value="R"/>
            <input type="hidden" name="pageNo" value="1"/>
        </form>
</body>
</html>