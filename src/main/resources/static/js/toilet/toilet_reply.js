function handleToiletReplySubmit(user_nickname) {
    if (user_nickname) {
        submitReply();
    } else {
        alert("先にログインしてください。");
        window.location.href = "/login";
    }
}

function submitReply() {
    const replyContent = document.getElementById("replyContent").value;
    if (!replyContent) {
        alert("コメント欄が空いています。");
        return;
    }

    fetch(`/main/toilet/reply`, {
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
    commentDiv.setAttribute("data-original", originalContent);
    commentDiv.innerHTML = `
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
    if (confirm("修正を取り消しますか？")) {
        const commentDiv = document.getElementById(`reply-${r_id}`);
        commentDiv.innerHTML = `
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
    const newText = document.getElementById(`edit-text-${r_id}`).value;
    if (!newText.trim()) {
        alert("コメントを入力してください。");
        return;
    }

    fetch(`/main/toilet/reply`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            r_id: r_id,
            r_context: newText
        })
    })
        .then(response => response.json())
        .then(data => {
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
        fetch(`/main/toilet/reply/${r_id}`, {
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
    fetch("/main/toilet/reply/toggle/" + r_id, {
        method: "POST"
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const likeSpan = button.querySelector(".like-count");
                likeSpan.textContent = data.newReplyLikeCount;
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
}

function optionReplyHandler() {
    $("input[name='option']").change(function () {
        currentSortOption = $("input[name='option']:checked").val();
        replyPage = 0;
        document.getElementById("replySection").innerHTML = "";
        document.getElementById("load-more-replies").style.display = "block";
        loadRepliesPaged();
    });
}