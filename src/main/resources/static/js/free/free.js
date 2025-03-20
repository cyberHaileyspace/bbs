function deletePost(no) {
    if (confirm('정말로 삭제하시겠습니까?')) {
        // DELETE 요청으로 데이터를 보냄
        fetch('/main/free/' + no, {
            method: 'DELETE',  // HTTP method를 DELETE로 설정
            headers: {
                'Content-Type': 'application/json',  // JSON 형식으로 데이터 전송
            }
        })
            .then(response => response.json())  // 서버에서 응답을 JSON 형태로 받음
            .then(data => {
                alert('삭제 되었습니다.');
                location.href = '/main/free';  // 삭제 후 페이지를 리다이렉트
            })
            .catch(error => {
                console.error('Error:', error);  // 에러 처리
            });
    }
}

function handleFreeReplySubmit(user_nickname) {
    if (user_nickname) {
        // 사용자가 로그인된 경우, 댓글을 등록하는 함수 호출
        submitReply();
    } else {
        alert("로그인 후 작성 가능합니다.")
        // 로그인되지 않은 경우, 로그인 페이지로 리다이렉트
        window.location.href = "/login"; // 필요에 따라 URL을 수정하세요
    }
}

function submitReply() {
    const replyContent = document.getElementById("replyContent").value;
    console.log(replyContent)
    // 댓글 내용이 비어있으면 경고 메시지
    if (!replyContent) {
        alert("댓글 내용을 입력해주세요.");
        return;
    }
    // console.log(post_id)
    // 댓글을 서버로 전송하는 fetch 요청 (서버 경로는 실제 경로로 수정해야 합니다)
    fetch(`/main/free/reply`, {
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
                alert("댓글이 등록되었습니다.");
                loadReplies(); // 댓글을 성공적으로 등록한 후 댓글을 다시 불러옴
                document.getElementById("replyContent").value = "";
            } else {
                alert("댓글 등록 실패. 다시 시도해주세요.");
            }
        })
        .catch(error => {
            console.error("댓글 등록 실패:", error);
        });
}

function editReply(r_id, r_writer, r_date, r_context) {
    const commentDiv = document.getElementById(`reply-${r_id}`);
    const originalContent = r_context;

    // 기존 내용 저장
    commentDiv.setAttribute("data-original", originalContent);

    // 댓글을 textarea로 변경
    commentDiv.innerHTML = `
        <div>
        <span>작성자 : ${r_writer}</span> <br>
        <span>작성일 : ${r_date}</span> <br>
        <textarea id="edit-text-${r_id}" class="edit-textarea">${originalContent}</textarea>
        </div>
        <button onclick="saveEdit('${r_id}', '${r_writer}', '${r_date}', '${originalContent}')">수정완료</button>
        <button onclick="cancelEdit()">수정취소</button>
    `;
}

function cancelEdit(r_id, r_writer, r_date, originalContent) {
   if (confirm("수정을 취소하시겠습니까?")){
      loadReplies();
   }

    // const commentDiv = document.getElementById(`reply-${r_id}`);
    //
    // // 원래 댓글로 복원
    // commentDiv.innerHTML = `
    //     <div>
    //     <span>작성자 : ${r_writer}</span> <br>
    //     <span>작성일 : ${r_date}</span> <br>
    //     <p id="reply-context" class="edit-textarea">${originalContent}</p>
    //     </div>
    //     <button onclick="editReply('${r_id}', '${r_writer}', '${r_date}', '${originalContent}')">수정</button>
    //     <button onclick="deleteReply(${r_id})">삭제</button>
    //
    // `;
}
function saveEdit(r_id, r_writer, r_date, originalContent) {
    const newText = document.getElementById(`edit-text-${r_id}`).value;

    console.log("saveEdit 실행됨", r_id, r_writer, newText); // 실행 여부 확인

    // 텍스트 영역이 비어있는지 확인
    if (!newText.trim()) {
        alert("댓글 내용을 입력해주세요.");
        return;  // 텍스트가 비어 있으면 수정하지 않음
    }

    fetch(`/main/free/reply`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            r_id: r_id, // 수정할 댓글의 ID 포함
            r_context: newText // 새로운 댓글 내용
        })
    })
        .then(response => response.json())
        .then(data => {
            console.log("서버 응답 데이터", data); // 응답 데이터 확인

            if (!data || !data.success) {
                alert("댓글이 수정되었습니다.");
                loadReplies(); // 수정 성공 후 댓글 목록 갱신
            } else {
                alert("수정 실패! 서버 응답: " + JSON.stringify(data));
                loadReplies(); // 수정 실패 후 댓글 목록 갱신
            }
        })
        .catch(error => {
            console.error("수정 중 오류 발생:", error);
            alert("수정 실패! 네트워크 오류.");
            loadReplies(); // 오류 발생 시에도 댓글 목록 갱신
        });
}

function deleteReply(r_id) {
    if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
        // DELETE 요청으로 데이터를 보냄
        fetch(`/main/free/reply/${r_id}`, {
            method: 'DELETE',  // HTTP method를 DELETE로 설정
            headers: {
                'Content-Type': 'application/json',  // JSON 형식으로 데이터 전송
            }
        })
            .then(response => response.json())  // 서버에서 응답을 JSON 형태로 받음
            .then(data => {
                if (data || !data.success) {
                    alert("댓글이 삭제되었습니다.");
                    loadReplies();  // 댓글 삭제 후 댓글 목록 갱신
                } else {
                   alert("댓글 삭제 실패! 서버 응답: " + JSON.stringify(data));
                }
            })
            .catch(error => {
                console.error("댓글 삭제 중 오류 발생:", error);
                alert("댓글 삭제 실패! 네트워크 오류.");
            });
    }
}

