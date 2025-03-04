<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>会員登録ページ</title>
    <link rel="stylesheet" href="/resources/css/product.css">
    <script src="/resources/js/sample.js"></script>
</head>

<body>
<div class="content">
    <div class="main02">

        <div class="title"><h1>会員登録ページ</h1></div>
        <form action="register" method="post" onsubmit="return validateForm()">
            <div class="center">
                <div class="id">
                    <br>
                    <div>ID</div>
                    <div><input name="user_id" type="text" placeholder="※半角英数字6～16文字。"></div>
                </div>
                <div class="pw">
                    <div>パスワード</div>
                    <div><input name="user_pw" type="password" placeholder="※半角英数字6～16文字。"></div>
                    <div><input name="pw02" type="password" placeholder="パスワード再入力"></div>
                </div>
                <div class="name">
                    <div>名前</div>
                    <div><input name="user_name" type="text"></div>
                </div>
                <div class="nickname">
                    <div>ニックネーム</div>
                    <div><input name="user_nickname" type="text"></div>
                </div>
                <div class="email">
                    <div>メールアドレス</div>
                    <div><input name="user_email" type="text"></div>
                </div>

                <div class="gender" style="display: flex; justify-content: space-evenly;">
                    <div>性別</div>
                    &nbsp;|&nbsp;
                    <div>
                        <label>男<input type="radio" name="user_gender" value="male" checked="checked"></label>
                        <label>女<input type="radio" name="user_gender" value="female"></label>
                    </div>
                </div>

                <div class="file">
                    プロフィール : <input type="file" name="user_image">
                </div>

                <div style="display: flex; justify-content: space-evenly;">
                    <div class="two_box">
                        <button onclick="location.href='/'" class="back">
                            閉じる
                        </button>
                    </div>

                    <div class="two_box">
                        <button class="sign">次に進む</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>