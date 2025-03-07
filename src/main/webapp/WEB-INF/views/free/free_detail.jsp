<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%--<link rel="stylesheet" href="/resources/css/free/free.css">--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/resources/js/free/free.js"></script>
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
        <div>작성인 : ${post.p_name}</div>
    </div>
    <div class="title">[ ${post.p_begin} ]  ${post.p_title}</div>
    <div class="post-image-container">
        <img src="/free/free_img/${post.p_img}" alt="Post Image">
    </div>
    <div class="post-content">
        <div class="text">${post.p_text}</div>
        <div class="date">작성일 : <c:formatDate value="${post.p_date}" pattern="yyyy-MM-dd HH:mm"/></div>
    </div>
    <div class="buttons-container">
        <button onclick="deletePost(${post.p_no})">삭제</button>
        <button>수정하기</button>
        <button onclick="location.href='/free'">목록으로</button>
    </div>
    <div class="comment-section">
        <div class="comment-header">댓글 쓰기</div>
        <textarea placeholder="댓글을 입력하세요..."></textarea>
        <button>댓글 쓰기</button>
    </div>
</div>
</body>
</html>