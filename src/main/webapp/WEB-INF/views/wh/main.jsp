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
    <div class="main_content_wrapper" style="width: 100%">
        <div class="main_content_container">
            <div class="main_content">
                <div class="main_content_box">
                    <div style="text-align: center; display: flex"><a href=""
                                                                      style="margin-left: auto; margin-right: auto; display: flex"><span>윗부분</span></a><a
                            href=""><span>더보기</span></a></div>
                    <div>
                        <a href=""><p>1번내용</p></a>
                        <a href=""><p>2번내용</p></a>
                        <a href=""><p>3번내용</p></a>
                        <a href=""><p>4번내용</p></a>
                        <a href=""><p>5번내용</p></a>
                    </div>
                    <a href="">
                        <div><span>밑부분</span></div>
                    </a>
                </div>
                <div class="main_content_box">
                    <div style="text-align: center; display: flex"><a href=""
                                                                      style="margin-left: auto; margin-right: auto; display: flex"><span>윗부분</span></a><a
                            href=""><span>더보기</span></a></div>
                    <div>
                        <a href=""><p>1번내용</p></a>
                        <a href=""><p>2번내용</p></a>
                        <a href=""><p>3번내용</p></a>
                        <a href=""><p>4번내용</p></a>
                        <a href=""><p>5번내용</p></a>
                    </div>
                    <a href="">
                        <div><span>밑부분</span></div>
                    </a>
                </div>
            </div>
            <div class="main_content">
                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title">관광게시판</span><span class="main_board_header_plus">더보기</span></div>
                    <c:forEach var="t" items="${tour}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <a href="/main/tour/getLoc?contentid=${t.contentid}" style="display: flex"><img src="${t.firstimage}"><p class="main_board_content_title">${t.title}</p></a><p style="margin-left: auto">생성날짜</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="main_content_box">
                    <div class="main_board_header"><a href="" class="main_board_header_link"><span>생활게시판</span></a><a
                            href=""><span class="main_board_header_plus">더보기</span></a></div>
                    <c:forEach var="l" items="${life}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <a href="javascript:goToPost(${p.post_id})" style="display: flex"><img src="${l.post_image}"><p>${l.post_title}</p></a><p style="margin-left: auto; padding-right: 10px">생성날짜</p>
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
</body>
</html>