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
    <div onclick="location.href='/'">
        Diaspora - ディアスポラ
    </div>
    <c:choose>
        <c:when test="${user ne null}">
            <div style="font-size: 20px">
                <span onclick="location.href='/mypage'">マイページ</span>
                    <%-- &nbsp;|&nbsp;
                    <span onclick="location.href='/register'">会員登録</span> --%>
                <span onclick="location.href='logout'">로그아웃</span>
            </div>
        </c:when>
        <c:otherwise>
            <div style="font-size: 20px">
                <span onclick="location.href='/login'">ログイン</span>

                <span onclick="location.href='/register'">会員登録</span>
            </div>

        </c:otherwise>
    </c:choose>

</div>
<div class="panel">
    <div><h1>test1</h1></div>
    <div><h1>test2</h1></div>
    <div><h1>test3</h1></div>
    <div><h1>test4</h1></div>
</div>
<div class="main">
    <div class="main-content">
    <jsp:include page="${content}"></jsp:include>
    </div>
</div>
<div class="footer">푸터</div>
</body>
</html>