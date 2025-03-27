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
        alert("ユーザーIDは6～16文字の半角英数字で入力してください。");
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
        alert("パスワードは6～16文字の英数字、または一部の記号を含めて入力してください。");
        return false;
    }

    // 비밀번호 확인 검사
    if (userPw !== pw02) {
        alert("パスワードが一致しません。");
        return false;
    }

    // 이름, 닉네임, 이메일 유효성 검사
    if (userName.trim() === "") {
        alert("お名前は必須項目です。");
        return false;
    }
    if (userNickname.trim() === "") {
        alert("ニックネームは必須項目です。");
        return false;
    }
    if (userEmail.trim() === "") {
        alert("メールアドレスは必須項目です。");
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
        alert('JPGまたはPNG形式の画像を添付してください。')
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

/*function generateToken() {
    const now = new Date();
    const token = now.getMinutes() + ":" + now.getSeconds();  // "mm:ss" 형식
    return token;
}

function goToPost(postId) {
    const token = generateToken();
    sessionStorage.setItem("viewToken", token);
    location.href = "life/" + postId + "?token=" + token;
}

function logincheck(user) {
    if (user)
        location.href = "life/reg";
    else {
        alert("先にログインしてください。");
        location.href = "/login"
    }
}*/

function deletePost(no) {
    if (confirm('本当に削除しますか？')) {
        // DELETE 요청으로 데이터를 보냄
        /*fetch('/main/life/' + no, {
            method: 'DELETE',  // HTTP method를 DELETE로 설정
            headers: {
                'Content-Type': 'application/json',  // JSON 형식으로 데이터 전송
            }
        })
            .then(response => response.json())  // 서버에서 응답을 JSON 형태로 받음
            .then(data => {
                alert('삭제되었습니다.');
                location.href = '/main/life';  // 삭제 후 페이지를 리다이렉트
            })
            .catch(error => {
                console.error('Error:', error);  // 에러 처리
            });*/

        fetch('/main/life/' + no, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        })
            .then(response => response.json())  // JSON 응답을 받음
            .then(data => {
                if (data.success) {
                    alert('削除が完了しました。');
                } else {
                    alert('ログインが必要です。');
                }
                location.href = data.redirectUrl;  // 수동으로 페이지 이동
            })
            .catch(error => {
                console.error('削除中にエラーが発生しました:', error);
            });

    }
}

function handleReplySubmit(user_nickname) {
    if (user_nickname) {
        // 사용자가 로그인된 경우, 댓글을 등록하는 함수 호출
        submitReply();
    } else {
        alert("コメントの投稿にはログインが必要です。")
        // 로그인되지 않은 경우, 로그인 페이지로 리다이렉트
        window.location.href = "/login"; // 필요에 따라 URL을 수정하세요
    }
}

function submitReply() {
    const replyContent = document.getElementById("replyContent").value;
    console.log(replyContent)
    // 댓글 내용이 비어있으면 경고 메시지
    if (!replyContent) {
        alert("コメント内容を入力してください。");
        return;
    }
    console.log(post_id)
    // 댓글을 서버로 전송하는 fetch 요청 (서버 경로는 실제 경로로 수정해야 합니다)
    fetch(`/main/life/reply`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            post_id: post_id,
            r_context: replyContent,
            r_writer: user_nickname
        })
    })
        .then(response => response.json())
        .then(data => {
            if (data) {
                alert("コメントが投稿されました。");
                loadReplies(); // 댓글을 성공적으로 등록한 후 댓글을 다시 불러옴
            } else {
                alert("コメントの投稿に失敗しました。もう一度お試しください。");
            }
        })
        .catch(error => {
            console.error("コメント投稿エラー:", error);
        });
}
