<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib
        uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java"
         contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Title</title>
    <script src="/resources/js/tourBoard.js"></script>
    <link rel="stylesheet" href="/resources/css/board.css"/>
</head>
<body>
<div class="container-cm-post">
    <div class="life-back" onclick="location.href='/main/tour'">観光掲示板 ></div>
    <div class="post-title"><span> ${post.post_title } </span></div>
    <div class="post-info">
        <div class="post-profile"><img alt="" src="/img/upload/${user.user_image }"></div>
        <div class="post-mini-wrapper">
            <div class="post-string">
                <div class="post-name">${post.user_nickname }</div>
                <div class="post-date"><fmt:formatDate value="${post.post_date}" pattern="yyyy-MM-dd"/></div>
            </div>
            <div class="post-items">
                <div class="post-view"><img
                        src="https://cdn-icons-png.flaticon.com/512/7835/7835667.png">${post.post_view }</div>
                <div class="post-like"><img
                        src="https://cdn-icons-png.flaticon.com/512/833/833234.png">${post.post_like }</div>
            </div>
        </div>
    </div>

    <div class="post-content">
        <c:if test="${post.post_image ne null}">
            <div class="post-img">
                <img src="/img/upload/${post.post_image}" style="width: 400px; height: 400px">
            </div>
        </c:if>
        <div class="post-text" id="post<%---${post.post_id}--%>">
            <div>${post.post_context}</div>
        </div>
        <br>
        <div class="post-button">
            <button class="like-button" onclick="likePost(${post.post_id}, this)">
                いいね数 : <span class="like-count">${post.post_like}</span>
            </button>
            <c:if test="${login_nickname == post.user_nickname}">
                <button onclick="deletePost(${post.post_id})">削除</button>
                <button onclick="location.href='update/${post.post_id}'">修正</button>
            </c:if>
            <button onclick="location.href='/main/tour'">リスト</button>
        </div>
    </div>
</div>
<div>
    <div>
        <div class="comment-section">
            <div class="comment-header">コメントを書く</div>
            <div hidden="hidden">ニックネーム : <input name="user_nickname" value="${user.user_nickname}" type="text"
                                                       placeholder="${user.user_nickname}" readonly></div>

            <div class="comment-ta">
                <textarea id="replyContent" placeholder="コメントを入力してください..." style="resize: none"></textarea>
                <button id="commentButton"
                        onclick="handleFreeReplySubmit('${user.user_nickname}')">コメント投稿
                </button>
            </div>


        </div>
        <div id="replySection">
        </div>
    </div>
</div>
<%----------------------------------------------------------------------------------------------------------%>
<script>
    var post_id = ${post.post_id}; // JSP 변수를 JavaScript 변수에 할당
    var user_nickname = "${login_nickname}"; // 로그인한 사용자의 닉네임을 JSP 변수로 받아옴

    // 페이지 로드 시 댓글을 비동기적으로 가져오는 함수
    function loadReplies() {
        fetch(`/main/tourBoard/reply/${post_id}`)
            .then(response => response.json())
            .then(data => {
                console.log("取得したコメント一覧:", data)
                const replySection = document.getElementById("replySection");
                replySection.innerHTML = ""; // 기존 댓글 삭제

                if (data.length === 0) {
                    replySection.innerHTML = "<p>コメントはまだありません。ぜひ最初のコメントを投稿してください！</p>";
                } else {
                    data.forEach(reply => {
                        const replyDiv = document.createElement("div");
                        replyDiv.classList.add("reply")
                        replyDiv.id = "reply-" + reply.r_id;
                        // 댓글 작성자와 로그인한 사용자가 동일한 경우 삭제 및 수정 버튼을 추가
                        let replytHTML =
                            "<div>" +
                            "<span>投稿者 : " + reply.r_writer + "</span>" + "<br>" +
                            "<span>投稿日 : " + reply.r_date + "</span>" +
                            "<p>" + reply.r_context + "</p>"
                            + "</div>"
                        ;

                        if (user_nickname === reply.r_writer) {
                            replytHTML += "<button onclick=\"editReply('" + reply.r_id + "', '" + reply.r_writer + "', '" + reply.r_date + "', '" + reply.r_context + "')\">修正</button>" +
                                "<button onclick=\"deleteReply('" + reply.r_id + "')\">削除</button>";
                        }
                        replyDiv.innerHTML = replytHTML;
                        replySection.appendChild(replyDiv);
                    });
                }
            })
            .catch(error => {
                console.error("コメントの読み込みに失敗しました:", error);
            });
    }

    console.log(post_id, user_nickname)

    // 페이지가 로드되면 댓글을 비동기적으로 불러오는 함수 호출

    document.addEventListener("DOMContentLoaded", loadReplies);
    </script>
    <script>
    function likePost(postId, button) {
        fetch(`/main/tourBoard/like/` + postId, {

            method: "POST", // POST 요청으로 변경
        })
            .then(response => response.json()) // JSON 응답 처리
            .then(data => {
                console.log(data)
                console.log(postId);
                if (data.success) {
                    button.querySelector(".like-count").textContent = data.newLikeCount; // 추천수 업데이트
                } else {
                    alert("ログインが必要です。");
                    window.location.href = "/login"; // 로그인 페이지로 이동
                }
            })
            .catch(error => console.error("Error:", error));
    }
</script>
</body>
</html>
