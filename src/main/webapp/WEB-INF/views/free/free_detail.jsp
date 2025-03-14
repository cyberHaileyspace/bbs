<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%--<link rel="stylesheet" href="/resources/css/free/free.css">--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/resources/js/free/free.js"></script>
    <link rel="stylesheet" href="/resources/css/free/free.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            margin: 20px;
        }

        .post-header, .post-content {
            margin-bottom: 20px;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }

        .post-header div {
            font-size: 16px;
            color: #555;
        }

        .post-header .title {
            font-weight: bold;
            color: #333;
            font-size: 20px;
        }

        .post-image-container img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }

        .post-content .text {
            font-size: 14px;
            color: #333;
            line-height: 1.8;
        }

        .post-content .date {
            font-size: 12px;
            color: #888;
        }

        .buttons-container {
            margin-top: 20px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            margin: 10px 5px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .comment-section {
            margin-top: 30px;
        }

        .comment-section .comment-header {
            font-weight: bold;
            color: #333;
        }

        .comment-section textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .comment-section button {
            background-color: #007BFF;
            margin-top: 10px;
        }

        .comment-section button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="post-header">
        <div>작성인 : ${post.user_nickname}</div>
    </div>
    <div class="title">[ ${post.post_category} ] [ ${post.post_menu} ]  ${post.post_title}</div>
    <div class="post-image-container">
        <img src="/Users/kimsuhyeon/Desktop/final_img/${post.post_image}" alt="Post Image">
    </div>
    <div class="post-content">
        <div class="text">${post.post_context}</div>
        <div class="date">작성일 : <fmt:formatDate value="${post.post_date}" pattern="yyyy-MM-dd HH:mm"/></div>
    </div>
    <div class="buttons-container">
        <c:if test="${login_nickname == post.user_nickname}">
            <button onclick="deletePost(${post.post_id})">삭제</button>
            <button onclick="location.href='update/${post.post_id}'">수정하기</button>
        </c:if>
        <button onclick="location.href='/main/free'">목록으로</button>
    </div>
    <div>
        <div class="comment-section">
            <div class="comment-header">댓글 쓰기</div>
            <div hidden="hidden">닉네임 : <input name="user_nickname" value="${user.user_nickname}" type="text"
                                              placeholder="${user.user_nickname}" readonly></div>
            <textarea id="replyContent" placeholder="댓글을 입력하세요..."></textarea>
            <button id="commentButton"
                    onclick="handleReplySubmit('${user.user_nickname}')">댓글 쓰기</button>
        </div>
        <div id="commentSection">
            <p></p>
        </div>
    </div>
</div>
<%--        ---------------------------------------------------------------------------------------%>
        <script>
            var post_id = ${post.post_id}; // JSP 변수를 JavaScript 변수에 할당
            var user_nickname = "${login_nickname}"; // 로그인한 사용자의 닉네임을 JSP 변수로 받아옴

            // 페이지 로드 시 댓글을 비동기적으로 가져오는 함수
            function loadReplies() {
                fetch(`/main/free/reply/${post_id}`)
                    .then(response => response.json())
                    .then(data => {
                        console.log("Fetched Comments:", data)
                        const commentSection = document.getElementById("commentSection");
                        commentSection.innerHTML = ""; // 기존 댓글 삭제

                        if (data.length === 0) {
                            commentSection.innerHTML = "<p>댓글이 없습니다. 댓글을 작성해 보세요!</p>";
                        } else {
                            data.forEach(reply => {
                                const commentDiv = document.createElement("div");
                                commentDiv.classList.add("comment");

                                // 댓글 작성자와 로그인한 사용자가 동일한 경우 삭제 및 수정 버튼을 추가
                                let commentHTML =
                            "<span>작성자 : " + reply.r_writer + "</span>" + "<br>" +
                            "<span> 작성일 : "  + reply.r_date + "</span>" +
                            "<p>"+ reply.r_context +"</p>"
                        ;

                                if (user_nickname === reply.r_writer) {
                                    commentHTML += "<button onclick=\"deleteReply(" + reply.r_id + ")\">삭제</button>" +
                                        "<button onclick=\"editReply(" + reply.r_id + ")\">수정</button>";
                                    ;
                                }

                                commentDiv.innerHTML = commentHTML;
                                commentSection.appendChild(commentDiv);
                            });
                        }
                    })
                    .catch(error => {
                        console.error("댓글 로드 실패:", error);
                    });
            }
            console.log(post_id, user_nickname)

            // 페이지가 로드되면 댓글을 비동기적으로 불러오는 함수 호출

            document.addEventListener("DOMContentLoaded", loadReplies);

        </script>
</body>
</html>