<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
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
    <div><span class="menu" data-val="생활 정보">生活情報</span></div>
    <div><span class="menu" data-val="건강 정보">健康情報</span></div>
    <div><span class="menu" data-val="질문">質問</span></div>
    <div><span class="menu" data-val="후기">レビュー</span></div>
</div>
<hr>
<div class="sort">
    <div>
        <div>
            <label><input type="radio" name="option" value="new" checked="checked"/> 최신순</label>
            <label><input type="radio" name="option" value="like"/> 추천순</label>
            <label><input type="radio" name="option" value="view"/> 조회순</label>
            <label><input type="radio" name="option" value="reply"/> 댓글순</label>
        </div>
        <div style="display: flex; justify-content: flex-end">
            <button class="write-btn" onclick="logincheck('${sessionScope.user}')">
                <img class="write-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/> 작성
            </button>
        </div>
        <div class="search-btn">
            <input type="text" placeholder="검색할 내용을 입력하세요." id="search-input">
            <button id="search-btn"><img class="search-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/256/25/25313.png"/> 검색
            </button>
        </div>
    </div>

</div>
<br>
<div id="post-container">
</div>
<div id="pagination-container" style="display: flex; justify-content: center"></div>
<%--<c:choose>--%>
<%--    <c:when test="${not empty posts}">--%>
<%--        <c:forEach items="${posts}" var="p">--%>
<%--            <div class="item">--%>

<%--                <div class="post-life" onclick="goToPost(${p.post_id})">--%>
<%--                    <div class="life-kind">--%>
<%--                        <div class="life-no">번호 : ${p.post_id }</div>&nbsp;/&nbsp;--%>
<%--                        <div class="life-cate">카테고리 : ${p.post_category }</div>&nbsp;/&nbsp;--%>
<%--                        <div class="life-menu">지역 : ${p.post_menu }</div>--%>
<%--                    </div>--%>
<%--                    <div class="life-title">${p.post_title }</div>--%>
<%--                    <div class="life-context">--%>
<%--                        <div class="life-text"><span>${p.post_context }</span></div>--%>
<%--                        <div class="life-image"><img alt="" src="img/post/${p.post_image }"></div>--%>
<%--                    </div>--%>
<%--                    <div class="life-info">--%>
<%--                        <div style="display: flex">--%>
<%--                            <div class="info-name">작성자 : ${p.user_nickname }</div>&nbsp;/&nbsp;--%>
<%--                            <div class="info-date">작성일 : <fmt:formatDate value="${p.post_date}"--%>
<%--                                                                         pattern="yyyy-MM-dd HH:mm"/></div>--%>
<%--                        </div>--%>
<%--                        <div style="display: flex">--%>
<%--                            <div class="info-view">조회수 : ${p.post_view }</div>&nbsp;/&nbsp;--%>
<%--                            <div class="info-like">좋아요 : ${p.post_like }</div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--    </c:when>--%>
<%--    <c:otherwise>--%>
<%--        <p>게시글이 없습니다. 게시글을 작성해 보세요!</p>--%>
<%--    </c:otherwise>--%>
<%--</c:choose>--%>
</body>
<script src="/resources/js/free/free.js"></script>
</html>