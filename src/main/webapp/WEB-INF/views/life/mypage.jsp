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
    <script src="/resources/js/sample.js"></script>
</head>
<body>
<div class="mypage">
    <div class="mypage-container">
        <c:if test="${user.user_image ne null}">
            <div>
                <img src="/file/${user.user_image}" style="width: 100px; height: 100px">
            </div>
        </c:if>
        <div>
            프로필 사진 변경
        </div>
        <div>
            ${user.user_nickname}
        </div>
        <div>
            아이디 : ${user.user_id}
        </div>
        <div>
            가입일 : <fmt:formatDate value="${user.user_date}" pattern="yyyy-MM-dd"/>
        </div>
        <div class="mypage-btn">
            <div onclick="location.href='/update'" style="cursor: pointer">내 정보 수정</div>
            <div onclick="location.href='/pwreset'" class="pw" style="cursor: pointer">비밀번호 변경</div>
            <div onclick="location.href='/logout'" style="cursor: pointer">로그아웃</div>
        </div>
    </div>

    <div class="mypage-content">
        <div class="tab-button active" data-target="posts">작성 글 목록</div>
        <div class="tab-button" data-target="comments">작성 댓글 목록</div>
    </div>


    <div class="tab-content show" id="posts">
        <div style="width: 45%; margin: 20px">
            <h3>자유게시판</h3>
            <c:forEach items="${freePosts}" var="p">
                <div class="item" <%--onclick="goToPost(${p.post_id})"--%>>
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
            <%--<div class="post-item" onclick="goToPost(${p.post_id})">
                <div class="post-header">
                    <span class="post-no">No. ${p.post_id}</span>
                    <span class="post-name">${p.user_nickname}</span>
                    <span class="post-date"><fmt:formatDate value="${p.post_date}"
                                                            pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                <div class="post-content">
                    <div class="post-title">${p.post_title}</div>
                </div>
            </div>--%>
        </div>
        <div style="width: 45%; margin: 20px">
            <h3>생활게시판</h3>
            <c:forEach items="${lifePosts}" var="p">
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
        </div>
    </div>
    <div class="tab-content" id="comments">
        <div style="width: 45%; margin: 20px">
            <h3>자유게시판</h3>
            <c:forEach items="${freePostReplies}" var="fr">
                <%--<div>${fr}</div>--%>
                <div class="free-context">
                    <div class="free-reply-text">${fr.r_context}&nbsp;/&nbsp;<fmt:formatDate value="${fr.r_date}"
                                                                                       pattern="yyyy-MM-dd HH:mm"/></div>
                </div>
                <%--<div class="item" onclick="goToPost(${p.post_id})">
                        &lt;%&ndash;<div>번호 : ${l.post_id}</div>
                        <div>제목 : ${l.post_title}</div>
                        <div>작성자 : ${l.user_nickname}</div>
                        <div>작성일 : <fmt:formatDate value="${l.post_date}" pattern="yyyy-MM-dd"/></div>&ndash;%&gt;
                        &lt;%&ndash;<div>
                            <button onclick="location.href='delete?pk=${p.p_no}'">삭제</button>
                        </div>&ndash;%&gt;
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
                                                                             pattern="yyyy-MM-dd"/></div>
                            </div>
                            <div style="display: flex">
                                <div class="info-view">조회수 : ${p.post_view }</div>&nbsp;/&nbsp;
                                <div class="info-like">좋아요 : ${p.post_like }</div>
                            </div>
                        </div>
                    </div>
                </div>--%>
            </c:forEach>
            <%--<div class="post-item" onclick="goToPost(${p.post_id})">
                <div class="post-header">
                    <span class="post-no">No. ${p.post_id}</span>
                    <span class="post-name">${p.user_nickname}</span>
                    <span class="post-date"><fmt:formatDate value="${p.post_date}"
                                                            pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                <div class="post-content">
                    <div class="post-title">${p.post_title}</div>
                </div>
            </div>--%>
        </div>
        <div style="width: 45%; margin: 20px">
            <h3>생활게시판</h3>
            <c:forEach items="${lifePostReplies}" var="lr">
                <%--<div>${lr}</div>--%>
                <div class="life-context">
                    <div class="life-reply-text">${lr.r_context}&nbsp;/&nbsp;<fmt:formatDate value="${lr.r_date}"
                                                                                       pattern="yyyy-MM-dd HH:mm"/></div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const tabs = document.querySelectorAll(".tab-button");
        const contents = document.querySelectorAll(".tab-content");

        tabs.forEach(tab => {
            tab.addEventListener("click", function () {
                // 모든 탭에서 active 제거
                tabs.forEach(t => t.classList.remove("active"));
                this.classList.add("active");

                // 모든 콘텐츠에서 show 제거
                contents.forEach(content => content.classList.remove("show"));

                // 클릭한 탭에 해당하는 콘텐츠만 show 추가
                const targetId = this.getAttribute("data-target");
                document.getElementById(targetId).classList.add("show");
            });
        });
    });
</script>
</body>
<%--<script>
    function mypost() {
        fetch('/user/posts')  // 서버로 요청을 보냄
            .then(response => response.json())  // JSON 형식으로 응답 받음
            .then(posts => {
                let postListDiv = document.querySelector('.mypage-content');
                /*postListDiv.innerHTML = '';  // 기존 내용 지우기*/
                if (posts.length > 0) {
                    posts.forEach(post => {
                        let postDiv = document.createElement('div');
                        postDiv.textContent = post.title;  // 글 제목을 보여줌
                        postListDiv.appendChild(postDiv);
                    });
                } else {
                    postListDiv.innerHTML = '작성한 글이 없습니다.';
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
</script>--%>
<script>
    function goToPost(postId) {
        const token = generateToken();
        sessionStorage.setItem("viewToken", token);
        location.href = "free/" + postId + "?token=" + token;
    }
</script>
</html>