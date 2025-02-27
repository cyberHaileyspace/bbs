<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/product.css">
    <script src="/resources/js/product.js"></script>
</head>

<body>
<div class="content">
    <div class="main02">

        <div class="title"><h1>ログインページ</h1></div>

        <div class="center">
            <div class="id">
                <br>
                <div>ID</div>
                <div><input name="user_id" type="text"></div>
            </div>
            <div class="pw">
                <div>パスワード</div>
                <div><input name="user_pw" type="text"></div>
            </div>
            <div class="login-button">

                    ログイン

            </div>
            <div class="login-button02">
                <div onclick="location.href='registerpage'">会員登録</div>
                <div>パスワードの再設定</div>
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