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
    <div><span class="menu" data-val="all">すべて</span><img src="https://cdn-icons-png.flaticon.com/128/4559/4559106.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></div>
    <div><span class="menu" data-val="hobby">趣味</span><img src="https://cdn-icons-png.flaticon.com/128/4807/4807749.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></div>
    <div><span class="menu" data-val="love">恋バナ</span><img src="https://cdn-icons-png.flaticon.com/128/4003/4003342.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></div>
    <div><span class="menu" data-val="talk">雑談</span><img src="https://cdn-icons-png.flaticon.com/128/1000/1000384.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></div>
</div>
<div class="sort">
    <div style="display: flex; justify-content: center">
        <h2>自由掲示板</h2>
    </div>
    <div>
        <div>

        <div class="search-btn">
            <input type="text" placeholder="タイトルを入力してください。" id="search-input">
            <button id="search-btn"><img class="search-btn-img" alt=""
                                         src="https://cdn-icons-png.flaticon.com/256/25/25313.png"/> <span>検索</span>
            </button>
        </div>
            <hr style="width: 1050px;">
            <div style="display: flex; padding: 0 50px; width: 90%; margin-top: 25px">
                <div style="display: flex; flex-direction: row">
                    <label class="cate_radio">
                        <input type="radio" name="option" value="new" checked="checked"/><span>最新順</span>
                    </label>
                    <label class="cate_radio">
                        <input type="radio" name="option" value="like"/><span>いいね順</span>
                    </label>
                    <label class="cate_radio">
                        <input type="radio" name="option" value="view"/><span>閲覧数順</span>
                    </label>
                    <label class="cate_radio">
                        <input type="radio" name="option" value="reply"/><span>コメント順</span>
                    </label>

                </div>

                <div style="margin-left: auto">
                    <button class="write-btn" onclick="logincheck('${sessionScope.user}')">
                        <img class="write-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/>
                        <span>投稿</span>
                    </button>
                </div>
            </div>

</div>
<br>
<div id="post-container">
</div>
<div id="pagination-container" style="display: flex; justify-content: center; padding: 10px"></div>
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
