<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <link rel="stylesheet" href="/resources/css/board.css">
    <link rel="stylesheet" href="/resources/css/pagination.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.5/pagination.min.js"></script>

</head>
<body>
<div class="category">
    <div><span class="menu" name="category" data-val="전체">전체</span></div>
    <div><span class="menu" name="category" data-val="생활 정보">생활 정보</span></div>
    <div><span class="menu" name="category" data-val="건강 정보">건강 정보</span></div>
    <div><span class="menu" name="category" data-val="질문">질문</span></div>
    <div><span class="menu" name="category" data-val="후기">후기</span></div>
</div>
<hr>
<div class="sort">
    <div>
        <div>
        <label><input type="radio" name="option" value="new" checked="checked"/> 최신순</label>
        <label><input type="radio" name="option" value="like"/> 추천순</label>
        <label><input type="radio" name="option" value="view"/> 조회순</label>
        </div>
        <div style="display: flex; justify-content: flex-end">
            <button class="write-btn" onclick="logincheck('${sessionScope.user}')">
                <img class="write-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/> 작성
            </button>
        </div>
        <div class="search-btn">
            <input type="text" placeholder="검색할 내용을 입력하세요." id="search-btn">
            <button><img class="search-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/256/25/25313.png"/> 검색
            </button>
        </div>
    </div>
</div>
<br>
<%--<button class="write-btn" onclick="logincheck('${sessionScope.user}')">
    <img class="write-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/> 작성
</button>--%>
<!-- 게시글 목록 -->

<div id="post-container">
</div>
<div id="pagination-container" style="display: flex; justify-content: center"></div>
</body>
<script src="/resources/js/life/life.js"></script>
<script>
    $()
</script>

</html>