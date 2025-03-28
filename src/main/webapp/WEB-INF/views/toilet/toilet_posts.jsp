<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>Toilet Board</title>
    <link rel="stylesheet" href="/resources/css/board.css">
    <link rel="stylesheet" href="/resources/css/pagination.css">
    <link rel="stylesheet" href="/resources/css/toilet.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.5/pagination.min.js"></script>
    <style>
        .toilet-container #post-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .toilet-item {
            width: 30%;
            background: white;
            padding: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 12px;
            transition: all 0.2s ease;
        }

        .toilet-item:hover {
            transform: translateY(-5px);
        }

        .toilet-post {
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="toilet-container">
    <div class="category">
        <div><span class="menu">すべて</span></div>
        <div><span class="menu" data-val="生活情報">生活情報</span></div>
        <div><span class="menu" data-val="健康情報">健康情報</span></div>
        <div><span class="menu" data-val="質問">質問</span></div>
        <div><span class="menu" data-val="レビュー">レビュー</span></div>
    </div>
    <hr>
    <div class="sort">
        <div>
            <div>
                <label><input type="radio" name="option" value="new" checked="checked"/> 最新順</label>
                <label><input type="radio" name="option" value="like"/> いいね順</label>
                <label><input type="radio" name="option" value="view"/> 閲覧順</label>
                <label><input type="radio" name="option" value="reply"/> コメント順</label>
            </div>
            <div style="display: flex; justify-content: flex-end">
                <button class="write-btn" onclick="logincheck('${sessionScope.user}')">
                    <img class="write-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/> 作成
                </button>
            </div>
            <div class="search-btn">
                <input type="text" placeholder="タイトルを入力してください。" id="search-input">
                <button id="search-btn"><img class="search-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/256/25/25313.png"/> 検索</button>
            </div>
        </div>
    </div>
    <br>
    <div id="post-container"></div>
    <div id="pagination-container" style="display: flex; justify-content: center"></div>
</div>
<script src="/resources/js/toilet/toilet.js"></script>
</body>
</html>
