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
        <form action="update" method="post">
            <div class="title"><h1>내 정보 재설정 페이지</h1></div>
            <div class="center">
                <div class="id">
                    <div>ID</div>
                    <div><input name="user_id" value="${user.user_id}" type="text" placeholder="${user.user_id}" readonly></div>
                </div>
                <div class="name">
                    <div>이름</div>
                    <div><input name="user_name" id="user_name" type="text" placeholder="${user.user_name}"></div>
                </div>
                <div class="nickname">
                    <div>닉네임</div>
                    <div><input name="user_nickname" id="user_nickname" type="text" placeholder="${user.user_nickname}"></div>
                    <span id="nick_check" style="color: red; font-size: 12px"></span>
                    <button type="button" id="nick_check_btn">중복확인</button>
                </div>
                <div class="email">
                    <div>메일 주소</div>
                    <div><input name="user_email" id="user_email" type="text" placeholder="${user.user_email}"></div>
                    <span id="email_check" style="color: red; font-size: 12px"></span>
                    <button type="button" id="email_check_btn">중복확인</button>
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
</script>
</html>