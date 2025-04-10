
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/board.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.5/pagination.min.js"></script>
</head>
<body>
<div class="container-cm-post">
    <!-- "자유掲示판" → "自由掲示板" (일본어) -->
    <div class="life-back" onclick="location.href='/main/free'">自由掲示板 ></div>


    <div class="post-title"><span> <c:choose>
        <c:when test="${post.post_category == 'hobby'}">[趣味]</c:when>
        <c:when test="${post.post_category == 'love'}">[恋バナ]</c:when>
        <c:when test="${post.post_category == 'talk'}">[雑談]</c:when>
        <c:otherwise>[未分類]</c:otherwise>
    </c:choose>${post.post_title } </span></div>
    <div class="post-info">
        <div class="post-profile">
            <c:choose>
                <c:when test="${empty user.user_image}">
                    <img src="/img/free-icon-user-1144760.png" style="width:60px; height:60px;">
                </c:when>
                <c:otherwise>
                    <img src="/file/${user.user_image}" style="width:60px; height:60px;">
                </c:otherwise>
            </c:choose>
        </div>
        <div class="post-mini-wrapper">
            <div class="post-string">
                <div class="post-name">${post.user_nickname }</div>
                <div class="post-date"><fmt:formatDate value="${post.post_date}" pattern="yyyy-MM-dd"/></div>
            </div>
            <div class="post-items">
                <div class="post-view"><img src="https://cdn-icons-png.flaticon.com/512/7835/7835667.png">${post.post_view }</div>
                <div class="post-like"><img src="https://cdn-icons-png.flaticon.com/512/833/833234.png">${post.post_like }</div>
            </div>
        </div>
    </div>

    <div class="post-content">
        <c:if test="${post.post_image ne null}">
            <div class="post-img">
                <img src="/file/${post.post_image}" style="width: 400px; height: 400px">
            </div>
        </c:if>
        <div class="post-text" id="post<%---${post.post_id}--%>">
            <div>${post.post_context}</div>
        </div>
        <br>
        <div class="post-button">

            <button class="like-button reply_button" data-liked="${isLiked}" onclick="toggleLike(${post.post_id}, this)">
                <c:choose>
                    <c:when test="${isLiked}">
                        取り消し&nbsp;<span class="like-count">${post.post_like}</span>
                    </c:when>
                    <c:otherwise>
                        いいね&nbsp;<span class="like-count">${post.post_like}</span>
                    </c:otherwise>
                </c:choose>
                <div class="post-like"><img src="https://cdn-icons-png.flaticon.com/512/833/833234.png"></div>
            </button>
            <c:if test="${login_nickname == post.user_nickname}">
                <button onclick="deletePost(${post.post_id})">削除</button>
                <button onclick="location.href='update/${post.post_id}'">修正</button>
            </c:if>
        </div>
    </div>
</div>
<div>
    <div>
        <div class="comment-section">
            <div class="comment-header">コメントを書く</div>
            <div hidden="hidden">
                ニックネーム : <input name="user_nickname" value="${user.user_nickname}" type="text" placeholder="${user.user_nickname}" readonly>
            </div>

            <div class="comment-ta">
                <textarea id="replyContent" placeholder="コメントを入力してください..." style="resize: none"></textarea>
                <button id="commentButton" onclick="handleFreeReplySubmit('${user.user_nickname}')">コメント投稿</button>
            </div>


        </div>
        <div id="replyCountContainer"></div>
        <div style="display: flex">
            <!-- 정렬 옵션 텍스트 변경: 최신순 → 最新順, 추천순 → いいね順 -->
            <label class="cate_radio">
                <input type="radio" name="option" value="new" checked="checked"/><span>最新順</span>
            </label>
            <label class="cate_radio">
                <input type="radio" name="option" value="like"/><span>いいね順</span>
            </label>
        </div>
        <div id="replySection">
        </div>
        <!-- "댓글 5개 더보기" → "コメントを5件もっと見る" -->
        <div style="display: flex; justify-content: center; margin-top: 20px"><button id="load-more-replies" class="reply_my_button">コメントを5件もっと見る</button></div>
    </div>
</div>

<%----------------------------------------------------------------------------------------------------------%>
<script>
    var post_id = ${post.post_id}; // JSP 변수를 JavaScript 변수에 할당
    var user_nickname = "${login_nickname}"; // 로그인한 사용자의 닉네임을 JSP 변수로 받아옴

    let replyPage = 0;
    const replySize = 5;
    let totalReplyCount = 0; // 전체 댓글 수를 저장할 전역 변수

    function loadReplyCount() {
        return fetch('/main/free/reply/count/' + post_id)
            .then(response => response.text())
            .then(count => {
                totalReplyCount = Number(count);
                console.log(count);
                const countContainer = document.getElementById("replyCountContainer");
                if(Number(count) === 0 ){

                    countContainer.innerHTML = "";
                } else {
                    countContainer.innerHTML = "<p>全コメント : " + count + "件</p>";
                }
            })
            .catch(error => {
                console.error("コメント数の読み込みに失敗しました:", error);
            });
    }


    function loadRepliesPaged() {
        replySortOption = document.querySelector("input[name='option']:checked").value;

        fetch("/main/free/reply/" + post_id + "?page=" + replyPage + "&size=" + replySize + "&option=" + replySortOption)
            .then(response => response.json())
            .then(data => {
                loadReplyCount();
                const replySection = document.getElementById("replySection");

                if (data.length === 0) {

                    if (replyPage === 0) {
                        replySection.innerHTML = "<p>コメントがありません。最初のコメントを残してください！</p>";

                    }
                    document.getElementById("load-more-replies").style.display = "none";
                    return;
                }

                data.forEach(reply => {
                    const replyDiv = document.createElement("div");
                    replyDiv.classList.add("reply", "use_css");
                    replyDiv.id = "reply-" + reply.r_id;


                    // コメント HTML 生成例
                    let replyHTML =
                        "<div class='use_css_box'>" + "<div class='reply_form'>" +
                        "<span>投稿者 : " + reply.r_writer + "</span>" +
                        "<span class='reply_date'>投稿日時 : " + reply.r_date + "</span>" + "</div>" +
                        "<p class='reply_context'>" + reply.r_context + "</p>" +
                        "<button class='like-button' data-liked='" + reply.likedByCurrentUser + "' onclick='toggleReplyLike(" + reply.r_id + ", this)'>" +
                        (reply.likedByCurrentUser ? "取り消し" : "いいね") + "&nbsp;<span class='like-count'>" + reply.r_like + "</span>" +
                        '<div class="post-like"><img src="https://cdn-icons-png.flaticon.com/512/833/833234.png"></div>' +
                        "</button>";

                    if (user_nickname === reply.r_writer) {
                        replyHTML += "<div style='display: flex; gap: 15px; margin-top: 10px'>" +
                            "<button onclick=\"editReply('" + reply.r_id + "', '" + reply.r_writer + "', '" + reply.r_date + "', '" + reply.r_context + "')\" class='reply_my_button'>修正</button>" +
                            "<button onclick=\"deleteReply('" + reply.r_id + "')\" class='reply_my_button'>削除</button>"
                        + "</div>";

                    }

                    replyDiv.innerHTML = replyHTML;
                    replySection.appendChild(replyDiv);
                });

                if (data.length < replySize) {
                    document.getElementById("load-more-replies").style.display = "none";
                }

                replyPage++;

                loadReplyCount().then(() => {
                    let loadedCount = replyPage * replySize;
                    let remaining = totalReplyCount - loadedCount;
                    const loadMoreButton = document.getElementById("load-more-replies");
                    if (remaining <= 0) {
                        loadMoreButton.style.display = "none";
                    } else if (remaining < replySize) {

                        loadMoreButton.textContent = "コメントを" + remaining + "件もっと見る";
                    } else {
                        loadMoreButton.textContent = "コメントを" + replySize + "件もっと見る";

                    }
                });
            })
            .catch(error => {

                console.error("コメントの読み込みに失敗しました:", error);
            });
    }

    console.log(post_id, user_nickname)

    // ページロード時にコメントを非同期で読み込む
    document.addEventListener("DOMContentLoaded", () => {
        loadReplyCount().then(() => {
            loadRepliesPaged(); // 初期表示（基本の並び順）
            document.getElementById("load-more-replies").addEventListener("click", loadRepliesPaged);
        });

        // 並び順オプション変更イベントハンドラ

        document.querySelectorAll("input[name='option']").forEach(radio => {
            radio.addEventListener("change", () => {
                replyPage = 0;
                document.getElementById("replySection").innerHTML = "";
                document.getElementById("load-more-replies").style.display = "block";

                loadRepliesPaged();  // 並び順変更時に再読み込み
            });
        });
    });
</script>
<script>
    function toggleLike(postId, button) {
        // 単一トグル API を呼び出す

        fetch("/main/free/toggle/" + postId, {
            method: "POST"
        })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                console.log(data)
                if (data.success) {
                    // 新しいいいね数を更新
                    button.querySelector(".like-count").textContent = data.newLikeCount;
                    // サーバーから返された nowLiked の値に応じてボタンの状態を変更
                    if (data.nowLiked) {
                        button.innerHTML = "取り消し&nbsp;<span class='like-count'>" + data.newLikeCount + "</span>" +
                            '<div class="post-like"><img src="https://cdn-icons-png.flaticon.com/512/833/833234.png"></div>';
                        button.setAttribute("data-liked", "true");
                    } else {
                        button.innerHTML = "いいね&nbsp;<span class='like-count'>" + data.newLikeCount + "</span>" +
                            '<div class="post-like"><img src="https://cdn-icons-png.flaticon.com/512/833/833234.png"></div>';
                        button.setAttribute("data-liked", "false");
                    }
                } else {
                    alert(data.message || "ログインが必要です。");
                    window.location.href = "/login";
                }
            })
            .catch(function(error) {
                console.error("Error:", error);
            });
    }

</script>
<script src="/resources/js/free/free.js"></script>
<script src="/resources/js/free/free_reply.js"></script>
</body>
</html>

