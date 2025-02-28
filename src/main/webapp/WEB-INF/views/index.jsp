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
        <img src="D:\sjm97\springworkspace\bbs\src\main\resources\static\css\Diaspora.png">
    </div>
    <div onclick="location.href='/'">
        Diaspora - ディアスポラ
    </div>
    <div style="font-size: 20px">
        <span onclick="location.href='/login'">ログイン</span>
        &nbsp;|&nbsp;
        <span onclick="location.href='/register'">会員登録</span>
    </div>

</div>
<div class="main" style="height: 1000px"><jsp:include page="${content}"></jsp:include></div>
<div class="footer">푸터</div>
</body>
</html>