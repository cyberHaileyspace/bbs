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
        <form action="update" method="post" id="my-form">
            <div class="title"><h1>マイ情報再設定ページ</h1></div>
            <div class="center">
                <div class="id" hidden="hidden">
                    <div>ユーザーID</div>
                    <div><input name="user_id" value="${user.user_id}" type="text" placeholder="${user.user_id}" readonly></div>
                </div>
                <div class="name">
                    <div>氏名</div>
                    <div><input name="user_name" id="user_name" value="${user.user_name}" type="text" placeholder="${user.user_name}"></div>
                </div>
                <div class="info_form">
                    <div>ニックネーム</div>
                    <div class="duplicate">
                        <input name="user_nickname" id="user_nickname" value="${user.user_nickname}" type="text" placeholder="${user.user_nickname}">
                        <button type="button" id="nick_check_btn" value="0">重複チェック</button>
                    </div>
                    <span id="nick_check" style="color: red; font-size: 12px"></span>
                </div>
                <div class="info_form">
                    <div>メールアドレス</div>
                    <div class="duplicate">
                        <input name="user_email" id="user_email" value="${user.user_email}" type="text" placeholder="${user.user_email}">
                        <button type="button" id="email_check_btn" value="0">重複チェック</button>
                    </div>
                    <span id="email_check" style="color: red; font-size: 12px"></span>
                </div>
                <div class="login-button">
                    <%--<button onclick="location.href='/'" class="back">
                        閉じる
                    </button>--%>
                    <button type="submit" class="my_info_button">更新する</button>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#my-form").submit((e)=>{
           e.preventDefault();
           console.log($("#nick_check_btn").val())
           console.log($("#email_check_btn").val())

           if ($("#nick_check_btn").val() == 0) {alert('nick name check plz'); return;}
           if ($("#email_check_btn").val() == 0) {alert('email check plz'); return;}
            $("#my-form").unbind("submit").submit();


        });
    });

    $(document).ready(function() {
        $("#nick_check_btn").click(function() {
            let userNick = $("#user_nickname").val().trim();
            let msgBox = $("#nick_check");

            // 정규식: 영문 대소문자 + 숫자 6~16자
            let nickPattern = /^[a-zA-Z0-9!@#$%^&*()_\-+=]{2,16}$/;

            // 입력값이 없는 경우
            if (userNick === "") {
                msgBox.text("ニックネームを入力してください。");
                return;
            }

            // 정규식 검사 실패
            if (!nickPattern.test(userNick)) {
                msgBox.text("ニックネームは2～16文字で入力してください。");
                return;
            }

            // AJAX를 이용한 중복 검사
            $.ajax({
                url: "/nickcheck",  // Spring Boot 컨트롤러와 매핑된 URL
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ user_nick: userNick }),
                success: function(response) {
                    if (response.exists) {
                        msgBox.text("すでに使用されているニックネームです。");
                    } else {
                        $("#nick_check_btn").val(1);
                        msgBox.css("color", "blue").text("使用可能なニックネームです。");
                    }
                },
                error: function() {
                    msgBox.text("サーバーエラーが発生しました。");
                }
            });
        });
    });

    $(document).ready(function() {
        $("#email_check_btn").click(function() {
            let userEmail = $("#user_email").val().trim();
            let msgBox = $("#email_check");

            // 정규식: 영문 대소문자 + 숫자 6~16자
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

            // 입력값이 없는 경우
            if (userEmail === "") {
                msgBox.text("メールアドレスを入力してください。");
                return;
            }

            // 정규식 검사 실패
            if (!emailPattern.test(userEmail)) {
                msgBox.text("有効なメールアドレスを入力してください。");
                return;
            }

            // AJAX를 이용한 중복 검사
            $.ajax({
                url: "/emailcheck",  // Spring Boot 컨트롤러와 매핑된 URL
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ user_email: userEmail }),
                success: function(response) {
                    if (response.exists) {
                        msgBox.text("すでに使用されているメールアドレスです。");
                    } else {
                        $("#email_check_btn").val(1);
                        msgBox.css("color", "blue").text("使用可能なメールアドレスです。");
                    }
                },
                error: function() {
                    msgBox.text("サーバーエラーが発生しました。");
                }
            });
        });
    });
</script>
</html>