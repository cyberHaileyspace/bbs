function validateForm() {
    // 유효성 검사 함수
    let userId = document.querySelector('[name="user_id"]').value;
    let userPw = document.querySelector('[name="user_pw"]').value;
    let pw02 = document.querySelector('[name="pw02"]').value;
    let userName = document.querySelector('[name="user_name"]').value;
    let userNickname = document.querySelector('[name="user_nickname"]').value;
    let userEmail = document.querySelector('[name="user_email"]').value;
    let userImage = document.querySelector('[name="user_image"]').value;

    // 사용자 ID 유효성 검사
    const idPattern = /^[a-zA-Z0-9]{6,16}$/;
    if (!idPattern.test(userId)) {
        alert("IDは6～16文字の半角英数字で入力してください。");
        return false;
    }

    // 비밀번호 유효성 검사

    /* const pwPattern = /^[a-zA-Z0-9._%+-]{6,16}$/;
    if (!pwPattern.test(userPw)) {
        alert("パスワードは6～16文字の半角英数字で入力してください。");
        return false;
    } */

    const pwPattern = /^[a-zA-Z0-9._%+!@#$^&*()_+[\]{}|;:'",.<>?/]{6,16}$/;
    if (!pwPattern.test(userPw)) {
        alert("パスワードは6～16文字の半角英数字または指定された特別な文字を含めてください。");
        return false;
    }

    // 비밀번호 확인 검사
    if (userPw !== pw02) {
        alert("パスワードが一致しません。");
        return false;
    }

    // 이름, 닉네임, 이메일 유효성 검사
    if (userName.trim() === "") {
        alert("名前は必須です。");
        return false;
    }
    if (userNickname.trim() === "") {
        alert("ニックネームは必須です。");
        return false;
    }
    if (userEmail.trim() === "") {
        alert("メールアドレスは必須です。");
        return false;
    }

    // 이메일 형식 검사 (간단한 정규식)
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (!emailPattern.test(userEmail)) {
        alert("有効なメールアドレスを入力してください。");
        return false;
    }

    if (isNotType(userImage, "jpg") &&
        isNotType(userImage, "png")) {
        alert('형식에 맞는 자료를 첨부하세요.')
        userImage.value = "";
        return;
    }

    return true; // 모든 검사 통과 시 폼 제출
}

/*$(document).ready(function () {
    $("#user_id").on("focusout", function () {
        var user_id = $("#user_id").val();
        if (user_id == '' || user_id.length == 0) {
            $("#label01").css("color", "red").text("ID를 입력해 주세요.");
            return false;
        }
        $.ajax({
            url : './validid',
            data : {
                user_id : user_id
            },
            type : 'POST',
            dataType : 'json',
            success : function (result) {
                if (result == true) {
                    $("#label01").css("color", "black").text("사용 가능한 ID입니다.");
                } else {
                    $("#label01").css("color", "red").text("사용 불가능한 ID입니다.");
                    $("#user_id").val('');
                }
            }
        });
    });
})*/

// panel logic
let panelFlag = true;

function panel() {
    const panel = document.querySelector(".panel");
    const panelBtn = document.querySelector(".panel-btn");
    console.log(panel)
    panelBtn.addEventListener("click", () => {
        if (panelFlag)
            panel.classList.add("open");
        else
            panel.classList.remove("open");
        panelFlag = !panelFlag;
    });
}

// 페이지 로드시 준비해서 실행할 것들
window.onload = () => {
    panel();
}
