<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/life/life.css">
</head>
<body>
<div class="category">
    <input type="radio" id="all" name="cm-dog">전체<%--<label class="size" for="all">전체</label>--%>
    <input type="radio" id="tip" name="cm-dog">생활 정보<%--<label class="size" data-val="소형견" for="s">생활 정보</label>--%>
    <input type="radio" id="health" name="cm-dog">건강 정보<%--<label class="size" data-val="중형견" for="m">건강 정보</label>--%>
    <input type="radio" id="qna" name="cm-dog">질문<%--<label class="size" data-val="대형견" for="l">질문</label>--%>
    <input type="radio" id="aft" name="cm-dog">후기<%--<label class="size" data-val="대형견" for="l">후기</label>--%>
</div>
<div class="sort">
    <input type="radio" name="option" value="new" checked="checked"/> 최신순
    <input type="radio" name="option" value="like"/> 좋아요순
    <input type="radio" name="option" value="view"/> 조회순
</div>
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
        <p>게시글이 없습니다. 게시글을 작성해 보세요!</p>
    </c:otherwise>
</c:choose>
<button class="write-btn" onclick="logincheck('${sessionScope.user}')">작성</button>
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
        location.href = "life/" + postId + "?token=" + token;
    }

    function logincheck(user) {
        if (user)
            location.href = "life/reg";
        else {
            alert("먼저 로그인을 해주세요.");
            location.href = "/login"
        }
    }

    $(document).ready(function () {
        function radio() {
            $("input[name='option']").change(function () {
                let option = $("input[name='option']:checked").val();
                console.log("선택된 정렬 옵션:", option);

                $.ajax({
                    url: 'life/option',
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