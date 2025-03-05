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
<div class="mypage">
    <div class="mypage-container">
        <div>
            <img src="/file/${user.user_image}" style="width: 100px; height: 100px">
        </div>
        <div>
            프로필 사진 변경
        </div>
        <div>
            ${user.user_nickname}
        </div>
        <div>
            아이디 : ${user.user_id}
        </div>
        <div>
            가입일 : <fmt:formatDate value="${user.user_date}" pattern="yyyy-MM-dd"/>
        </div>
    </div>
    <div class="mypage-btn">
        <div onclick="location.href='/update'" style="cursor: pointer">내 정보 수정</div>
        <div onclick="location.href='/pwreset'" class="pw" style="cursor: pointer">비밀번호 변경</div>
        <div onclick="location.href='/logout'" style="cursor: pointer">로그아웃</div>
    </div>
    <div class="mypage-content">
        <div>작성 글 목록</div>
        <div>작성 댓글 목록</div>
    </div>
</div>
</body>
</html>