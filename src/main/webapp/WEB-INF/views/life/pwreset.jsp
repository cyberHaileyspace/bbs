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
<script>
    function validateForm() {

        let pwReset = document.querySelector('[name="user_pw"]').value;
        let pwreset02 = document.querySelector('[name="pw02"]').value;

        // 비밀번호 유효성 검사
        const pwPattern = /^[a-zA-Z0-9]{6,16}$/;
        if (!pwPattern.test(pwReset)) {
            alert("パスワードは6～16文字の半角英数字で入力してください。");
            return false;
        }

        // 비밀번호 확인 검사
        if (pwReset !== pwreset02) {
            alert("パスワードが一致しません。");
            return false;
        }
    }
</script>
<body>
<div class="content">
    <div class="main02">
        <form action="pwreset" method="post">
            <div class="title"><h1>패스워드 재설정 페이지</h1></div>

            <div class="center">

                <div class="id">
                    <div>ID</div>
                    <div><input name="user_id" type="text" required></div>
                </div>
                <div class="pw">
                    <div>패스워드</div>
                    <div><input name="user_pw" type="password" required></div>
                </div>
                <div class="pw">
                    <div>패스워드 재입력</div>
                    <div><input name="pw02" type="password" required></div>
                </div>
                <div class="login-button">
                    <%--<button onclick="location.href='/'" class="back">
                        閉じる
                    </button>--%>
                    <button type="submit">재설정</button>
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
        </form>
    </div>
</div>
</body>
</html>