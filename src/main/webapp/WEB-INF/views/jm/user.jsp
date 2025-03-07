<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <%--script src="/resources/js/sample.js"></script>--%>
    <link rel="stylesheet" href="/resources/css/sample.css">
</head>
<body>
<div class="content">
    <div class="main02">
        <div>
            <div class="title"><h1>회원가입 페이지</h1></div>
            <form action="user" method="post" class="center" onsubmit="return validateForm()" enctype="multipart/form-data">
                <div class="id">
                    <br>
                    <div>ID</div>
                    <div><input name="user_id" id="user_id" type="text" placeholder="※半角英数字6～16文字。"></div>
                    <span id="id_check" style="color: red; font-size: 12px"></span>
                    <button type="button" id="id_check_btn">중복확인</button>
                </div>
                <div class="pw">
                    <div>패스워드</div>
                    <div><input name="user_pw" type="password" placeholder="※半角英数字6～16文字。"></div>
                    <div><input name="pw02" type="password" placeholder="パスワード再入力"></div>
                </div>
                <div class="name">
                    <div>이름</div>
                    <div><input name="user_name" type="text"></div>
                </div>
                <div class="nickname">
                    <div>닉네임</div>
                    <div><input name="user_nickname" id="user_nickname" type="text" placeholder="※半角英数字6～16文字。"></div>
                    <span id="nick_check" style="color: red; font-size: 12px"></span>
                    <button type="button" id="nick_check_btn">중복확인</button>
                </div>
                <div class="email">
                    <div>메일 주소</div>
                    <div><input name="user_email" id="user_email" type="text"></div>
                    <span id="email_check" style="color: red; font-size: 12px"></span>
                    <button type="button" id="email_check_btn">중복확인</button>
                </div>
                <div class="gender" style="display: flex; justify-content: space-evenly;">
                    <div>성별</div>
                    &nbsp;|&nbsp;
                    <div>
                        <label>남<input type="radio" name="user_gender" value="male" checked="checked"></label>
                        <label>여<input type="radio" name="user_gender" value="female"></label>
                    </div>
                </div>
                <div class="file">
                    프로필 : <input type="file" name="user_file">
                </div>

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
                    <button type="submit" class="sign">가입하기</button>
                    <button onclick="location.href='/'" class="back">
                        뒤로가기
                    </button>
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
                msgBox.text("ID를 입력하세요.");
                return;
            }

            // 정규식 검사 실패
            if (!idPattern.test(userId)) {
                msgBox.text("ID는 영문과 숫자로 6~16자여야 합니다.");
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
                        msgBox.text("이미 사용 중인 ID입니다.");
                    } else {
                        msgBox.css("color", "blue").text("사용 가능한 ID입니다.");
                    }
                },
                error: function() {
                    msgBox.text("서버 오류가 발생했습니다.");
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
                msgBox.text("닉네임을 입력하세요.");
                return;
            }

            // 정규식 검사 실패
            if (!nickPattern.test(userNick)) {
                msgBox.text("닉네임은 2~16자여야 합니다.");
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
                        msgBox.text("이미 사용 중인 닉네임입니다.");
                    } else {
                        msgBox.css("color", "blue").text("사용 가능한 닉네임입니다.");
                    }
                },
                error: function() {
                    msgBox.text("서버 오류가 발생했습니다.");
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
                msgBox.text("이메일을 입력하세요.");
                return;
            }

            // 정규식 검사 실패
            if (!emailPattern.test(userEmail)) {
                msgBox.text("올바른 이메일 형식이 아닙니다.");
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
                        msgBox.text("이미 사용 중인 이메일입니다.");
                    } else {
                        msgBox.css("color", "blue").text("사용 가능한 이메일입니다.");
                    }
                },
                error: function() {
                    msgBox.text("서버 오류가 발생했습니다.");
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
            alert("모든 필드를 입력해주세요.");
            return false;
        }

        if (idCheckMsg !== "사용 가능한 ID입니다." || nickCheckMsg !== "사용 가능한 닉네임입니다." || emailCheckMsg !== "사용 가능한 이메일입니다.") {
            alert("ID, 닉네임, 이메일 중복 확인을 완료해주세요.");
            return false;
        }
        return true;
    }

</script>
</html>