<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<link rel="stylesheet" href="/resources/css/board_free/board_free.css">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/resources/js/board_free/board_free.js"></script>
</head>
<body>
<div>
    <h1>-post list-</h1>
    <div>
        <div class="item">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
    <%--첨부하길 원하는 템블릿--%>
    <div class="item temp">
        <a onclick="getPost()">
        <div class="no" id="no">${p.p_no}</div>
        <div class="id" id="id">${p.p_id}</div>
        <div class="name" id="name">${p.p_name}</div>
        <div class="begin" id="begin">${p.p_begin}</div>
        <div class="title" id="title">${p.p_title}</div>
        <div class="img" id="img">${p.p_img}</div>
        <div class="text" id="text">${p.p_text}</div>
        </a>
        <hr>
    </div>
    <div id="post-list"></div>
</div>
</body>
</html>