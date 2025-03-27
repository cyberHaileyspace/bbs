<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib
        uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java"
         contentType="text/html; charset=utf-8" pageEncoding="utf-8" %> <%--<link
  rel="stylesheet"
  href="/resources/css/free/free.css"
/>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Title</title>
    <script src="/resources/js/free/free.js"></script>
    <link rel="stylesheet" href="/resources/css/board.css" />
  </head>
  <body>
  <div class="container-cm-post">
    <div class="life-back" onclick="location.href='/main/free'">自由掲示板 ></div>

    <div class="post-title"><span> ${post.post_title } </span></div>
    <div class="post-info">
        <div class="post-profile"><img alt="" src="file/${user.user_image }"></div>
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
          <img src="/file/${post.post_image}" style="width: 400px; height: 400px">
        </div>
      </c:if>
      <div class="post-text" id="post<%---${post.post_id}--%>">
        <div>${post.post_context}</div>
      </div>
      <br>
      <div class="post-button">
        <button class="like-button" data-liked="${isLiked}" onclick="toggleLike(${post.post_id}, this)">
          <c:choose>
            <c:when test="${isLiked}">
              추천취소&nbsp;<span class="like-count">${post.post_like}</span>
            </c:when>
            <c:otherwise>
              추천수&nbsp;<span class="like-count">${post.post_like}</span>
            </c:otherwise>
          </c:choose>
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
        <div class="reply-section">
            <div class="reply-header">댓글 쓰기</div>
            <div hidden="hidden">닉네임 : <input name="user_nickname" value="${user.user_nickname}" type="text"
                                              placeholder="${user.user_nickname}" readonly></div>
            <div class="reply-ta">
                <textarea id="replyContent" placeholder="댓글을 입력하세요..." style="resize: none"></textarea>
            </div>

            <button id="replyButton"
                    onclick="handleReplySubmit('${user.user_nickname}')">댓글 쓰기
            </button>
        </div>

        <div id="replySection">
            <p></p>
        </div>
    </div>
</div>
<%----------------------------------------------------------------------------------------------------------%>
<script>
    var post_id = ${post.post_id}; // JSP 변수를 JavaScript 변수에 할당
    var user_nickname = "${login_nickname}"; // 로그인한 사용자의 닉네임을 JSP 변수로 받아옴

    // 페이지 로드 시 댓글을 비동기적으로 가져오는 함수
    function loadReplies() {
        fetch('/main/free/reply/'+ post_id)
            .then(response => response.json())
            .then(data => {
                console.log("Fetched Replies:", data)
                const replySection = document.getElementById("replySection");
                replySection.innerHTML = ""; // 기존 댓글 삭제

              function loadReplyCount() {
               return fetch('/main/free/reply/count/' + post_id)
                        .then(response => response.text())
                        .then(count => {
                          totalReplyCount = Number(count);
                          console.log(count);
                          const countContainer = document.getElementById("replyCountContainer");
                          if(Number(count) === 0 ){
                            countContainer.innerHTML = ""
                          }else {
                            countContainer.innerHTML = "<p>전체 댓글 : " + count + "개</p>"
                          }
                        })
                        .catch(error => {
                          console.error("댓글 수 불러오기 실패:", error);
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
                              replySection.innerHTML = "<p>댓글이 없습니다. 첫 댓글을 남겨보세요!</p>";
                            }
                            document.getElementById("load-more-replies").style.display = "none";
                            return;
                          }

                          data.forEach(reply => {
                            const replyDiv = document.createElement("div");
                            replyDiv.classList.add("reply");
                            replyDiv.id = "reply-" + reply.r_id;

                            // 댓글 HTML 생성 예시
                            let replyHTML =
                                    "<div>" +
                                    "<span>작성자 : " + reply.r_writer + "</span><br>" +
                                    "<span>작성일 : " + reply.r_date + "</span>" +
                                    "<p>" + reply.r_context + "</p>" +
                                    "<button class='like-button' data-liked='" + reply.likedByCurrentUser + "' onclick='toggleReplyLike(" + reply.r_id + ", this)'>" +
                                    (reply.likedByCurrentUser ? "추천취소" : "추천수") + "&nbsp;<span class='like-count'>" + reply.r_like + "</span>" +
                                    "</button>";


                            if (user_nickname === reply.r_writer) {
                              replyHTML +=
                                      "<button onclick=\"editReply('" + reply.r_id + "', '" + reply.r_writer + "', '" + reply.r_date + "', '" + reply.r_context + "')\">수정</button>" +
                                      "<button onclick=\"deleteReply('" + reply.r_id + "')\">삭제</button>";
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
                              loadMoreButton.textContent = "댓글 " + remaining + "개 더보기";
                            } else {
                              loadMoreButton.textContent = "댓글 " + replySize + "개 더보기";
                            }
                          });
                        })
                        .catch(error => {
                          console.error("댓글 로드 실패:", error);
                        });
              }



              console.log(post_id, user_nickname)

      // 페이지가 로드되면 댓글을 비동기적으로 불러오는 함수 호출

              document.addEventListener("DOMContentLoaded", () => {
                loadReplyCount().then(() => {
                  loadRepliesPaged(); // 기본 정렬
                  document.getElementById("load-more-replies").addEventListener("click", loadRepliesPaged);
                });

                // 정렬 옵션 변경 이벤트 핸들러
                document.querySelectorAll("input[name='option']").forEach(radio => {
                  radio.addEventListener("change", () => {
                    replyPage = 0;
                    document.getElementById("replySection").innerHTML = "";
                    document.getElementById("load-more-replies").style.display = "block";
                    loadRepliesPaged();  // 정렬 변경 시 새로 불러오기
                  });
                });
              });


    </script>
  <script>
    function toggleLike(postId, button) {
      // 단일 토글 API를 호출합니다.
      fetch("/main/free/toggle/" + postId, {
        method: "POST"
      })
              .then(function(response) {
                return response.json();
              })
              .then(function(data) {
                console.log(data)
                if (data.success) {
                  // 새로운 추천 수 업데이트
                  button.querySelector(".like-count").textContent = data.newLikeCount;
                  // 서버에서 반환한 nowLiked 값에 따라 버튼 상태 변경
                  if (data.nowLiked) {
                    // nowLiked가 true이면 추천된 상태 -> 버튼을 "추천취소"로 변경
                    button.innerHTML = "추천취소&nbsp;<span class='like-count'>" + data.newLikeCount + "</span>";
                    button.setAttribute("data-liked", "true");
                  } else {
                    // false이면 추천 취소된 상태 -> 버튼을 "추천"으로 변경
                    button.innerHTML = "추천&nbsp;<span class='like-count'>" + data.newLikeCount + "</span>";
                    button.setAttribute("data-liked", "false");
                  }
                } else {
                  alert(data.message || "로그인이 필요합니다.");
                  window.location.href = "/login";
                }
              })
              .catch(function(error) {
                console.error("Error:", error);
              });
    }

  </script>
  <script src="/resources/js/free/free_reply.js"></script>
  </body>
</html>
