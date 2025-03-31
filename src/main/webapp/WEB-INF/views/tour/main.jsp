<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                <div class="main_content_box top_box">
                    <div class="main_board_header"><span class="main_board_header_title"
                                                         onclick="location.href='/main/news'">海外ニュース</span><span
                            class="main_board_header_plus" onclick="location.href='/main/news'">もっと見る</span></div>
                    <div id="news-container"></div> <!-- 뉴스가 들어갈 공간 -->
                </div>
            </div>
            <div class="main_content">
                <%-- 자유 게시판 --%>
                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title"
                                                         onclick="location.href='/main/free'">自由掲示板</span><span
                            class="main_board_header_plus" onclick="location.href='/main/free'">もっと見る</span></div>
                    <c:forEach var="f" items="${free}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <img src="${empty f.post_image ? '/img/no-image.png' : '/img/upload/'}${f.post_image}" onclick="goToFree(${f.post_id})">
                                <p onclick="goToFree(${f.post_id})" class="main_board_content_title">${f.post_title}</p>
                                <p style="margin-left: auto">
                                    <fmt:formatDate value="${f.post_date}" pattern="yyyy.M.d"/>
                                </p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <%-- 생활 게시판 --%>
                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title"
                                                         onclick="location.href='/main/life'">生活掲示板</span><span
                            class="main_board_header_plus" onclick="location.href='/main/life'">もっと見る</span></div>
                    <c:forEach var="l" items="${life}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <img src="${empty l.post_image ? '/img/no-image.png' : '/img/upload/'}${l.post_image}" onclick="goToFree(${l.post_id})">
                                <p onclick="goToLife(${l.post_id})" class="main_board_content_title">${l.post_title}</p>
                                <p style="margin-left: auto">
                                    <fmt:formatDate value="${l.post_date}" pattern="yyyy.M.d"/>
                                </p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="main_content">
                <%-- 관광 게시판 --%>

                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title"
                                                         onclick="location.href='/main/tour'">観光掲示板</span><span
                            class="main_board_header_plus" onclick="location.href='/main/tour'">もっと見る</span></div>
                    <c:forEach var="t" items="${tourPosts}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <img src="${empty t.post_image ? '/img/no-image.png' : '/img/upload/'}${t.post_image}" onclick="goToFree(${t.post_id})">
                                <p onclick="gotoTour(${t.post_id})" class="main_board_content_title">${t.post_title}</p>
                                <p style="margin-left: auto">
                                    <fmt:formatDate value="${t.post_date}" pattern="yyyy.M.d"/>
                                </p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                    <%-- 관광 정보 --%>

                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title tour-link"
                                                         onclick="document.getElementById('defaultTourForm').submit()">観光情報</span><span
                            class="main_board_header_plus tour-link" onclick="document.getElementById('defaultTourForm').submit()">もっと見る</span>
                    </div>
                    <c:forEach var="t" items="${tour}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <a href="/main/tourInfo/getLoc?contentid=${t.contentid}" style="display: flex"><img style="width: 40px; height: 40px"
                                        src="${t.firstimage}">
                                    <p class="main_board_content_title">${t.title}</p></a>
                                <p style="margin-left: auto">
                                    <fmt:parseDate value="${t.createdtime.substring(0,8)}" pattern="yyyyMMdd"
                                                   var="parsedDate"/>
                                    <fmt:formatDate value="${parsedDate}" pattern="yyyy.M.d"/>
                                </p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>


            </div>
        </div>
    </div>
</div>
<form id="defaultTourForm" action="/main/tourInfo/loc" method="get">
    <input type="hidden" name="areaCode" value="6"/>
    <input type="hidden" name="sigungu" value=""/>
    <input type="hidden" name="sort" value="R"/>
    <input type="hidden" name="pageNo" value="1"/>
</form>
<script>
    function generateToken() {
        const now = new Date();
        const token = now.getMinutes() + ":" + now.getSeconds();  // "mm:ss" 형식
        return token;
    }

    function goToFree(postId) {
        const token = generateToken();
        sessionStorage.setItem("viewToken", token);
        location.href = "/main/free/" + postId + "?token=" + token;
    }

    function goToLife(postId) {
        const token = generateToken();
        sessionStorage.setItem("viewToken", token);
        location.href = "/main/life/" + postId + "?token=" + token;
    }

    function gotoTour(postId) {
        const token = generateToken();
        sessionStorage.setItem("viewToken", token);
        location.href = "/main/tourBoard/" + postId + "?token=" + token;
    }

    // 뉴스 데이터를 가져와서 메인 페이지에 5개만 표시하는 함수
    function getNewsForMain() {
        let date = new Date();
        let year = date.getFullYear();
        let month = (date.getMonth() + 1).toString().padStart(2, '0');
        let day = (date.getDate() - 7).toString().padStart(2, '0');

        let formattedDate = `${year}-${month}-${day}`;
        let url = `https://newsapi.org/v2/everything?q=japan&from=${formattedDate}&searchIn=title&sortBy=popularity&apiKey=cac04d3f1ecc479580de012e82548f93`;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                renderNewsForMain(data.articles.slice(0, 5)); // 상위 5개만 표시
            })
            .catch(error => console.error("뉴스 로드 오류:", error));
    }

    // 메인 페이지에 뉴스 5개 출력
    function renderNewsForMain(newsList) {
        const newsContainer = document.querySelector("#news-container"); // 뉴스 표시할 컨테이너
        newsList.forEach((news, index) => {
            const newsItem = document.createElement("div");
            newsItem.classList.add("main_board_box");

            newsItem.innerHTML =
                "<p class='main_board_content_news'>" +
                "<a href='" + news.url + "' target='_blank'>" + news.title + "</a>" +
                "</p>" +
                "<p style='margin-left: auto'>" +
                (new Date(news.publishedAt).getFullYear()) + "." +
                (new Date(news.publishedAt).getMonth() + 1) + "." +
                (new Date(news.publishedAt).getDate()) + "</p>";

            newsContainer.appendChild(newsItem);
        });
    }

    // 메인 페이지 로드 시 뉴스 가져오기
    document.addEventListener("DOMContentLoaded", function () {
        getNewsForMain();
    });
</script>
</body>
</html>