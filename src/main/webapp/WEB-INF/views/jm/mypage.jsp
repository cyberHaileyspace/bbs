<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/sample.css">
    <script src="/resources/js/sample.js"></script>
</head>
<body>
${user.user_image} 프로필 사진 변경
<hr>
${user.user_nickname} (${user.user_id}) 님의 마이페이지입니다.
<br>
<div onclick="location.href='/pwreset'" class="pw" style="cursor: pointer">비밀번호 변경</div>
<hr>
가입일 : <fmt:formatDate value="${user.user_date}" pattern="yyyy-MM-dd" />
<br>
작성 글 목록
작성 댓글 목록
</body>
</html>