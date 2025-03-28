<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/board.css">
    <link rel="stylesheet" href="/resources/css/pagination.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.5/pagination.min.js"></script>
</head>
<body>
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
<<<<<<< HEAD
            <label><input type="radio" name="option" value="new" checked="checked"/> 最新順</label>
            <label><input type="radio" name="option" value="like"/> いいね順</label>
            <label><input type="radio" name="option" value="view"/> 閲覧順</label>
            <label><input type="radio" name="option" value="reply"/> コメント順</label>
=======
            <label><input type="radio" name="option" value="new" checked="checked"/> 최신순</label>
            <label><input type="radio" name="option" value="like"/> 추천순</label>
            <label><input type="radio" name="option" value="view"/> 조회순</label>
            <label><input type="radio" name="option" value="reply"/>댓글순</label>
>>>>>>> ef4d36bbc13215d13bec4b334b4893df166d9550
        </div>
        <div style="display: flex; justify-content: flex-end">
            <button class="write-btn" onclick="logincheck('${sessionScope.user}')">
                <img class="write-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/> 作成
            </button>
        </div>
        <div class="search-btn">
            <input type="text" placeholder="タイトルを入力してください。" id="search-input">
            <button id="search-btn"><img class="search-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/256/25/25313.png"/> 検索
            </button>
        </div>
    </div>
</div>
<br>
<div id="post-container">
</div>
<div id="pagination-container" style="display: flex; justify-content: center"></div>
<%-- 以下はコメントアウトされた部分（必要に応じて翻訳） --%>
<%--
<c:choose>
    <c:when test="${not empty posts}">
        <c:forEach items="${posts}" var="p">
            <div class="item">
                <div class="post-life" onclick="goToPost(${p.post_id})">
                    <div class="life-kind">
                        <div class="life-no">番号 : ${p.post_id }</div>&nbsp;/&nbsp;
                        <div class="life-cate">カテゴリ : ${p.post_category }</div>&nbsp;/&nbsp;
                        <div class="life-menu">地域 : ${p.post_menu }</div>
                    </div>
                    <div class="life-title">${p.post_title }</div>
                    <div class="life-context">
                        <div class="life-text"><span>${p.post_context }</span></div>
                        <div class="life-image"><img alt="" src="img/post/${p.post_image }"></div>
                    </div>
                    <div class="life-info">
                        <div style="display: flex">
                            <div class="info-name">投稿者 : ${p.user_nickname }</div>&nbsp;/&nbsp;
                            <div class="info-date">投稿日 : <fmt:formatDate value="${p.post_date}"
                                                                         pattern="yyyy-MM-dd HH:mm"/></div>
                        </div>
                        <div style="display: flex">
                            <div class="info-view">閲覧数 : ${p.post_view }</div>&nbsp;/&nbsp;
                            <div class="info-like">いいね : ${p.post_like }</div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <p>投稿がありません。投稿を作成してみてください！</p>
    </c:otherwise>
</c:choose>
--%>
<script src="/resources/js/free/free.js"></script>
</body>
</html>
