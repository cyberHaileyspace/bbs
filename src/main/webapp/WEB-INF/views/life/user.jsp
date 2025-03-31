<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/board.css">
</head>
<body>
<div class="content">
    <div class="main02">
        <div>
            <div class="title"><h1>新規登録ページ</h1></div>
            <form action="user" method="post" class="center" onsubmit="return validateForm()" enctype="multipart/form-data" id="reg_form">
                <div class="id reg_input">
                    <div>ユーザーID</div>
                    <div class="duplicate">
                        <input name="user_id" id="user_id" type="text" placeholder="※半角英数字6～16文字。">
                        <button type="button" id="id_check_btn">重複チェック</button>
                    </div>
                    <span id="id_check" style="color: red; font-size: 12px"></span>
                </div>
                <div class="pw">
                    <div>パスワード</div>
                    <div style="margin-bottom: 5px"><input name="user_pw" type="password" placeholder="※半角英数字6～16文字。"></div>
                    <div>パスワード確認</div>
                    <div><input name="pw02" type="password" placeholder="パスワード再入力"></div>
                </div>
                <div class="name reg_input">
                    <div>氏名</div>
                    <div><input name="user_name" type="text"></div>
                </div>
                <div class="nickname reg_input">
                    <div>ニックネーム</div>
                    <div class="duplicate">
                        <input name="user_nickname" id="user_nickname" type="text" placeholder="※半角英数字6～16文字。">
                        <button type="button" id="nick_check_btn">重複チェック</button>
                    </div>
                    <span id="nick_check" style="color: red; font-size: 12px"></span>

                </div>
                <div class="email reg_input">
                    <div>メールアドレス</div>
                    <div class="duplicate">
                        <input name="user_email" id="user_email" type="text">
                        <button type="button" id="email_check_btn">重複チェック</button>
                    </div>
                    <span id="email_check" style="color: red; font-size: 12px"></span>

                </div>
                <div class="gender reg_input" style="display: flex">
                    <div><span>性別</span></div>
                    |
                    <div>
                        <label><span>男性</span><input type="radio" name="user_gender" value="male" checked="checked"></label>
                        <label><span>女性</span><input type="radio" name="user_gender" value="female"></label>
                    </div>
                </div>
                <div class="file">
                    <span>プロフィール画像</span>
                    <input type="file" name="user_file" id="userFileInput" style="display: none;">

                    <label for="userFileInput" class="custom-file-label">
                        ファイルを選択
                    </label>

                    <span id="fileName">ファイルなし</span>
                </div>
                <script>
                    document.querySelector('input[name="user_file"]').addEventListener('change', function () {
                        const fileName = this.files[0]?.name || "선택된 파일 없음";
                        document.getElementById('fileName').innerText = fileName;
                    });
                </script>

                <%--.login-button {
                display: flex;
                width: 100%;
                /*justify-content: space-evenly;*/
                align-items: center;
                }

                .register-button {
                display: flex;
                width: 100%;
                /*justify-content: space-evenly;*/
                align-items: center;
                }--%>

                <div class="register-button">
                    <button onclick="location.href='/'" class="back my_info_button">
                        戻る
                    </button>
                    <button type="submit" class="sign my_info_button">登録する</button>
                </div>
        </div>
        </form>
    </div>
</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#id_check_btn").click(function() {
            let userId = $("#user_id").val().trim();
            let msgBox = $("#id_check");

            // 정규식: 영문 대소문자 + 숫자 6~16자
            let idPattern = /^[a-zA-Z0-9]{6,16}$/;

            // 입력값이 없는 경우
            if (userId === "") {
                msgBox.text("ユーザーIDを入力してください。");
                return;
            }

            // 정규식 검사 실패
            if (!idPattern.test(userId)) {
                msgBox.text("ユーザーIDは英数字6～16文字で入力してください。");
                return;
            }

            // AJAX를 이용한 중복 검사
            $.ajax({
                url: "/idcheck",  // Spring Boot 컨트롤러와 매핑된 URL
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ user_id: userId }),
                success: function(response) {
                    if (response.exists) {
                        msgBox.text("既に使用されているユーザーIDです。");
                    } else {
                        msgBox.css("color", "blue").text("使用可能なユーザーIDです。");
                    }
                },
                error: function() {
                    msgBox.text("サーバーエラーが発生しました。");
                }
            });
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
                        msgBox.text("既に使用されているニックネームです。");
                    } else {
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
                msgBox.text("正しいメールアドレスの形式ではありません。");
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
                        msgBox.text("既に使用されているメールアドレスです。");
                    } else {
                        msgBox.css("color", "blue").text("使用可能なメールアドレスです。");
                    }
                },
                error: function() {
                    msgBox.text("サーバーエラーが発生しました。");
                }
            });
        });
    });

    function validateForm() {
        let userId = $("#user_id").val().trim();
        let userNick = $("#user_nickname").val().trim();
        let userEmail = $("#user_email").val().trim();

        let idCheckMsg = $("#id_check").text();
        let nickCheckMsg = $("#nick_check").text();
        let emailCheckMsg = $("#email_check").text();

        if (userId === "" || userNick === "" || userEmail === "") {
            alert("全ての項目を入力してください。");
            return false;
        }

        if (idCheckMsg !== "使用可能なユーザーIDです。" || nickCheckMsg !== "使用可能なニックネームです。" || emailCheckMsg !== "使用可能なメールアドレスです。") {
            alert("ユーザーID・ニックネーム・メールアドレスの重複チェックを完了してください。");
            return false;
        }
        return true;
    }

</script>
</html>