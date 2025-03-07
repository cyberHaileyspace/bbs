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
<div class="content">
    <div class="main02">
        <div class="title"><h1>로그인 페이지</h1></div>
        <div>
            <form action="login" method="post" class="center">
                <div class="id">
                    <br>
                    <div>ID</div>
                    <div><input name="user_id" type="text" required></div>
                </div>
                <div class="pw">
                    <div>패스워드</div>
                    <div><input name="user_pw" type="password" required></div>
                </div>
                <div class="login-button">
                    <button type="submit">로그인</button>
                    <button onclick="location.href='/'" class="back">
                        뒤로가기
                    </button>
                </div>
                <br>
            </form>
            <div class="login-button02">
                <div onclick="location.href='register'">회원가입</div>
                <div onclick="location.href='pwreset'">패스워드 재설정</div>
            </div>
            <%--<div class="two_box">
                <div>Add</div>
                <div>
                    <select name="add">
                        <option value="seoul">Seoul</option>
                        <option value="kyeonggi">Kyeonggi</option>
                        <option value="daejeon">Daejeon</option>
                        <option value="daegu">Daegu</option>
                        <option value="busan" selected="selected">Busan</option>
                    </select>
                </div>
            </div>
            <div class="two_box">
                <div>Interest</div>
                <div>
                    <label><input name="interest" type="checkbox" value="food">Food</label>
                    <label><input name="interest" type="checkbox" value="excer">Excer</label><br>
                    <label><input name="interest" type="checkbox" value="develop">Develop</label>
                    <label><input name="interest" type="checkbox" value="travel">Travel</label>
                </div>
            </div>
            <div class="two_box">
                <div>Introduce</div>
                <div><textarea name="introduce" rows="6" cols="20"></textarea></div>
            </div>--%>

        </div>
    </div>
</div>

</body>
</html>