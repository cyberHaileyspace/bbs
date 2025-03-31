<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/board.css">
    <script src="/resources/js/sample.js"></script>
</head>

<body>
<div class="content">
    <div class="main02">
        <div class="title"><h1>ログインページ</h1></div>
        <div>
            <form action="login" method="post" class="center">
                <div class="id">
                    <br>
                    <div>ユーザーID</div>
                    <div><input name="user_id" type="text" required></div>
                </div>
                <div class="pw">
                    <div>パスワード</div>
                    <div><input name="user_pw" type="password" required></div>
                </div>
                <div class="login-button">
                    <button onclick="location.href='/'" class="back my_info_button">
                        戻る
                    </button>
                    <button type="submit" class="my_info_button">ログイン</button>
                </div>
                <br>
            </form>
            <div class="login-button02">
                <div onclick="location.href='user'">新規登録</div>
                <div onclick="location.href='pwreset'">パスワード再設定</div>
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