<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<div>
    <div class="main_content_wrapper" style="min-width: 100%">
        <div class="main_content_container">



            <div class="main_content">
                    <%-- 뉴스 게시판 --%>
                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title" onclick="location.href='/main/news'">뉴스 및 공지</span><span class="main_board_header_plus" onclick="location.href='/main/news'">더보기</span></div>
                    <c:forEach var="t" items="${tour}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <a href="/main/news" style="display: flex"><img src="${t.firstimage}"><p class="main_board_content_title">${t.title}</p></a><p style="margin-left: auto">생성날짜</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                    <%-- 자유 게시판 --%>
                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title" onclick="location.href='/main/free'">자유게시판</span><span class="main_board_header_plus" onclick="location.href='/main/free'">더보기</span></div>
                    <c:forEach var="f" items="${free}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <a href="/main/free" style="display: flex"><img src="${f.post_image}"><p class="main_board_content_title">${f.post_title}</p></a><p style="margin-left: auto">생성날짜</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="main_content">
                    <%-- 관광 게시판 --%>
                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title tour-link" onclick="location.href='/main/tour/loc?areaCode=1&sigungu=&sort=R&pageNo=1'">관광게시판</span><span class="main_board_header_plus tour-link" onclick="location.href='/main/tour/loc?areaCode=1&sigungu=&sort=R&pageNo=1'">더보기</span></div>
                    <c:forEach var="t" items="${tour}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <a href="/main/tour/getLoc?contentid=${t.contentid}" style="display: flex"><img src="${t.firstimage}"><p class="main_board_content_title">${t.title}</p></a><p style="margin-left: auto">생성날짜</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                    <%-- 생활 게시판 --%>
                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title" onclick="location.href='/main/life'">생활게시판</span><span class="main_board_header_plus" onclick="location.href='/main/life'">더보기</span></div>
                    <c:forEach var="t" items="${tour}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <a href="/main/life" style="display: flex"><img src="${t.firstimage}"><p class="main_board_content_title">${t.title}</p></a><p style="margin-left: auto">생성날짜</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="main_content">
                <div>
                    <a href="https://www.kr.emb-japan.go.jp/itprtop_ko/index.html">
                        <p>주한일본대사관 바로가기</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
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
</script>
</body>
</html>