function handleFreeReplySubmit(user_nickname) {
<<<<<<< HEAD
  if (user_nickname) {
    // 사용자가 로그인된 경우 댓글 등록 함수 호출
    submitReply();
  } else {
    alert("先にログインしてください。");
    // 로그인되지 않은 경우 로그인 페이지로 이동
    window.location.href = "/login";
  }
}

function submitReply() {
  const replyContent = document.getElementById("replyContent").value;
  console.log(replyContent);
  // 댓글 내용이 비어있으면 경고 메시지
  if (!replyContent) {
    alert("コメント欄が空いています。");
    return;
  }

  // 댓글을 서버로 전송하는 fetch 요청
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
          alert("登録されました。");
          replyPage = 0;
          document.getElementById("replySection").innerHTML = "";
          document.getElementById("load-more-replies").style.display = "block";
          loadRepliesPaged();
          document.getElementById("replyContent").value = "";
        } else {
          alert("登録が失敗しました。もう一度お試しください。");
        }
      })
      .catch(error => {
        console.error("コメント登録失敗:", error);
      });
}

function editReply(r_id, r_writer, r_date, r_context) {
  const commentDiv = document.getElementById(`reply-${r_id}`);
  const originalContent = r_context;
  // 기존 내용 저장
  commentDiv.setAttribute("data-original", originalContent);
  // 댓글 내용을 textarea로 변경
  commentDiv.innerHTML = `
=======
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
                replyPage = 0;
                document.getElementById("replySection").innerHTML = "";
                document.getElementById("load-more-replies").style.display = "block";
                loadRepliesPaged();
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
>>>>>>> ef4d36bbc13215d13bec4b334b4893df166d9550
        <div>
          <span>投稿者 : ${r_writer}</span> <br>
          <span>投稿日時 : ${r_date}</span> <br>
          <textarea id="edit-text-${r_id}" class="edit-textarea">${originalContent}</textarea>
        </div>
        <button onclick="saveEdit('${r_id}', '${r_writer}', '${r_date}', '${originalContent}')">修正完了</button>
        <button onclick="cancelEdit('${r_id}', '${r_writer}', '${r_date}', '${originalContent}')">修正取消</button>
    `;
}

function cancelEdit(r_id, r_writer, r_date, originalContent) {
<<<<<<< HEAD
  if (confirm("修正を取り消しますか？")) {
    const commentDiv = document.getElementById(`reply-${r_id}`);
    // 원래 댓글 내용으로 복원
    commentDiv.innerHTML = `
=======
    if (confirm("수정을 취소하시겠습니까?")) {
        const commentDiv = document.getElementById(`reply-${r_id}`);

        // 원래 댓글로 복원
        commentDiv.innerHTML = `
>>>>>>> ef4d36bbc13215d13bec4b334b4893df166d9550
            <div>
              <span>投稿者 : ${r_writer}</span> <br>
              <span>投稿日時 : ${r_date}</span> <br>
              <p id="reply-context" class="edit-textarea">${originalContent}</p>
            </div>
            <button onclick="editReply('${r_id}', '${r_writer}', '${r_date}', '${originalContent}')">修正</button>
            <button onclick="deleteReply(${r_id})">削除</button>
        `;
    }
    loadRepliesPaged();
}

function saveEdit(r_id, r_writer, r_date, originalContent) {
<<<<<<< HEAD
  const newText = document.getElementById(`edit-text-${r_id}`).value;
  console.log("saveEdit 実行:", r_id, r_writer, newText);

  // 텍스트 영역이 비어있는지 확인
  if (!newText.trim()) {
    alert("コメントを入力してください。");
    return;
  }

  fetch(`/main/free/reply`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      r_id: r_id,       // 수정할 댓글 ID
      r_context: newText  // 새로운 댓글 내용
    })
  })
      .then(response => response.json())
      .then(data => {
        console.log("サーバー応答データ", data);
        if (data === 1) {
          alert("コメントが修正されました。");
          replyPage = 0;
          document.getElementById("replySection").innerHTML = "";
          document.getElementById("load-more-replies").style.display = "block";
          loadRepliesPaged();
        } else {
          alert("修正失敗！サーバーの応答: " + JSON.stringify(data));
          loadRepliesPaged();
        }
      })
      .catch(error => {
        console.error("修正中のエラー発生:", error);
        alert("修正失敗！ネットワークエラー。");
        loadRepliesPaged();
      });
}

function deleteReply(r_id) {
  if (confirm("本当にこのコメントを削除しますか？")) {
    fetch(`/main/free/reply/${r_id}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
      }
    })
        .then(response => response.json())
        .then(data => {
          if (data === 1) {
            alert("コメントが削除されました。");
            replyPage = 0;
            document.getElementById("replySection").innerHTML = "";
            document.getElementById("load-more-replies").style.display = "block";
            loadRepliesPaged();
          } else {
            alert("コメント削除失敗！サーバーの応答: " + JSON.stringify(data));
          }
        })
        .catch(error => {
          console.error("コメント削除中のエラー発生:", error);
          alert("コメント削除失敗！ネットワークエラー。");
        });
  }
}

function toggleReplyLike(r_id, button) {
  fetch("/main/free/reply/toggle/" + r_id, {
    method: "POST"
  })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          // 새로운 추천 수 갱신
          const likeSpan = button.querySelector(".like-count");
          likeSpan.textContent = data.newReplyLikeCount;
          // 버튼 텍스트 및 속성 변경
          if (data.nowReplyLiked) {
            button.innerHTML = "取り消し&nbsp;<span class='like-count'>" + data.newReplyLikeCount + "</span>" +
                '<div class="post-like"><img src="https://cdn-icons-png.flaticon.com/512/833/833234.png"></div>';
            button.setAttribute("data-liked", "true");
          } else {
            button.innerHTML = "いいね&nbsp;<span class='like-count'>" + data.newReplyLikeCount + "</span>" +
                '<div class="post-like"><img src="https://cdn-icons-png.flaticon.com/512/833/833234.png"></div>';
            button.setAttribute("data-liked", "false");
          }
        } else {
          alert(data.message || "先にログインしてください。");
          window.location.href = "/login";
        }
      })
      .catch(error => {
        console.error("コメントのいいね処理中にエラーが発生しました:", error);
      });
=======
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

            if (data === 1) {
                alert("댓글이 수정되었습니다.");
                replyPage = 0;
                document.getElementById("replySection").innerHTML = "";
                document.getElementById("load-more-replies").style.display = "block";
                loadRepliesPaged();
            } else {
                alert("수정 실패! 서버 응답: " + JSON.stringify(data));
                loadRepliesPaged(); // 수정 실패 후 댓글 목록 갱신
            }
        })
        .catch(error => {
            console.error("수정 중 오류 발생:", error);
            alert("수정 실패! 네트워크 오류.");
            loadRepliesPaged(); // 오류 발생 시에도 댓글 목록 갱신
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
                if (data === 1) {
                    alert("댓글이 삭제되었습니다.");
                    replyPage = 0;
                    document.getElementById("replySection").innerHTML = "";
                    document.getElementById("load-more-replies").style.display = "block";
                    loadRepliesPaged();  // 댓글 삭제 후 댓글 목록 갱신
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

function toggleReplyLike(r_id, button) {
    fetch("/main/free/reply/toggle/" + r_id, {
        method: "POST"
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // 새로운 추천 수 갱신
                const likeSpan = button.querySelector(".like-count");
                likeSpan.textContent = data.newReplyLikeCount;

                // 버튼 텍스트 및 속성 변경
                if (data.nowReplyLiked) {
                    button.innerHTML = "추천취소&nbsp;<span class='like-count'>" + data.newReplyLikeCount + "</span>";
                    button.setAttribute("data-liked", "true");
                } else {
                    button.innerHTML = "추천수&nbsp;<span class='like-count'>" + data.newReplyLikeCount + "</span>";
                    button.setAttribute("data-liked", "false");
                }
            } else {
                alert(data.message || "로그인이 필요합니다.");
                window.location.href = "/login";
            }
        })
        .catch(error => {
            console.error("댓글 추천 처리 중 오류:", error);
        });
>>>>>>> ef4d36bbc13215d13bec4b334b4893df166d9550
}


function optionReplyHandler() {
<<<<<<< HEAD
  $("input[name='option']").change(function () {
    // 선택된 정렬 옵션을 전역 변수에 저장
    currentSortOption = $("input[name='option']:checked").val();
    console.log("選択された並び順オプション:", currentSortOption);
    // 페이지 초기화 및 댓글 리로딩
    replyPage = 0;
    document.getElementById("replySection").innerHTML = "";
    document.getElementById("load-more-replies").style.display = "block";
    loadRepliesPaged();
  });
}
=======
    $("input[name='option']").change(function () {
        // 선택된 정렬 옵션을 전역 변수에 저장
        currentSortOption = $("input[name='option']:checked").val();
        console.log("선택된 정렬 옵션:", currentSortOption);

        // 페이지 초기화 및 댓글 리로딩
        replyPage = 0;
        document.getElementById("replySection").innerHTML = "";
        document.getElementById("load-more-replies").style.display = "block";

        loadRepliesPaged(); // 최신순 or 추천순 정렬된 댓글 다시 로드
    });
}
>>>>>>> ef4d36bbc13215d13bec4b334b4893df166d9550
