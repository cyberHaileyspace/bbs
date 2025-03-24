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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    <input type="radio" name="option" value="new" checked="checked"/> 最新順
    <input type="radio" name="option" value="like"/> おすすめ順
    <input type="radio" name="option" value="view"/> 閲覧数順
</div>
<br>
<button class="write-btn" onclick="logincheck('${sessionScope.user}')"><img class="write-btn-img"
                                                                            alt=""
                                                                            src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/>投稿</button>
<c:choose>
    <c:when test="${not empty posts}">
        <c:forEach items="${posts}" var="p">
            <div class="item">
                    <%--<div>번호 : ${l.post_id}</div>
                    <div>제목 : ${l.post_title}</div>
                    <div>작성자 : ${l.user_nickname}</div>
                    <div>작성일 : <fmt:formatDate value="${l.post_date}" pattern="yyyy-MM-dd"/></div>--%>
                    <%--<div>
                        <button onclick="location.href='delete?pk=${p.p_no}'">삭제</button>
                    </div>--%>
                <div class="post-life" onclick="goToPost(${p.post_id})">
                    <div class="life-kind">
                        <div class="life-no">번호 : ${p.post_id }</div>&nbsp;/&nbsp;
                        <div class="life-cate">카테고리 : ${p.post_category }</div>&nbsp;/&nbsp;
                        <div class="life-menu">지역 : ${p.post_menu }</div>
                    </div>
                    <div class="life-title">${p.post_title }</div>
                    <div class="life-context">
                        <div class="life-text"><span>${p.post_context }</span></div>
                        <div class="life-image"><img alt="" src="img/post/${p.post_image }"></div>
                    </div>
                    <div class="life-info">
                        <div style="display: flex">
                            <div class="info-name">작성자 : ${p.user_nickname }</div>&nbsp;/&nbsp;
                            <div class="info-date">작성일 : <fmt:formatDate value="${p.post_date}"
                                                                         pattern="yyyy-MM-dd HH:mm"/></div>
                        </div>
                        <div style="display: flex">
                            <div class="info-view">조회수 : ${p.post_view }</div>&nbsp;/&nbsp;
                            <div class="info-like">좋아요 : ${p.post_like }</div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <p>投稿がありません。ぜひ最初の投稿をしてみてください！</p>
    </c:otherwise>
</c:choose>
</body>
<script>
    function generateToken() {
        const now = new Date();
        const token = now.getMinutes() + ":" + now.getSeconds();  // "mm:ss" 형식
        return token;
    }

    function goToPost(postId) {
        const token = generateToken();
        sessionStorage.setItem("viewToken", token);
        location.href = "free/" + postId + "?token=" + token;
    }

    function logincheck(user) {
        if (user)
            location.href = "free/reg";
        else {
            alert("先にログインしてください。");
            location.href = "/login"
        }
    }

    $(document).ready(function () {
        radio();  // radio 함수 호출

        function radio() {
            $("input[name='option']").change(function () {
                let option = $("input[name='option']:checked").val();
                console.log("선택된 정렬 옵션:", option);

                $.ajax({
                    url: 'free/option',
                    type: 'GET',
                    data: {option: option},
                    async: true,
                })
                    .done(function (resData) {
                        console.log("응답 데이터:", resData);
                        if (resData.length !== 0) {
                            $("#item").empty();
                            showResult(resData);
                        }
                    })
                    .fail(function (xhr) {
                        console.error("요청 실패:", xhr);
                    });
            });
        }
    });

</script>
</html>