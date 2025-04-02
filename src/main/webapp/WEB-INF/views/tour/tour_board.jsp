<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/pagination.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.5/pagination.min.js"></script>
    <link rel="stylesheet" href="resources/css/pagination">

</head>
<body>

<div style="width: 100%">
    <div class="travel">
        <div>観光掲示板   <img src="https://cdn-icons-png.flaticon.com/128/4559/4559106.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></div>
        <div onclick="document.getElementById('defaultTourForm').submit()">
            観光情報   <img src="https://cdn-icons-png.flaticon.com/128/13471/13471961.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
        </div>
    </div>
    <form id="defaultTourForm" action="/main/tourInfo/loc" method="get">
        <input type="hidden" name="areaCode" value="6"/>
        <input type="hidden" name="sigungu" value=""/>
        <input type="hidden" name="sort" value="R"/>
        <input type="hidden" name="pageNo" value="1"/>
    </form>
    <br>
    <div class="sort">
        <div style="display: flex; justify-content: center">
            <h2>観光掲示板</h2>
        </div>
        <div>
            <div class="search-btn">
                <input type="text" placeholder="タイトルを入力してください。" id="search-input">
                <button id="search-btn"><img class="search-btn-img" alt=""
                                             src="https://cdn-icons-png.flaticon.com/256/25/25313.png"/>
                    <span>検索</span>
                </button>
            </div>
            <hr style="width: 1000px;">
            <div style="display: flex; padding: 0 50px; width: 90%; margin-top: 25px">
                <div style="display: flex; flex-direction: row">
                    <label class="cate_radio">
                        <input type="radio" name="option" value="new" checked="checked"/><span>最新順</span>
                    </label>
                    <label class="cate_radio">
                        <input type="radio" name="option" value="like"/><span>おすすめ順</span>
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

    </div>
    <c:choose>
        <c:when test="${not empty posts}">
            <c:forEach items="${posts}" var="p">
                <div class="item">

                    <div class="post-life" onclick="gotoPost(${p.post_id})">
                        <div style="display: flex">
                            <div class="life-kind">
                                <div style="display: flex; gap: 15px">
                                    <div class="life-no">番号 : ${p.post_id }</div>
                                    <div class="life-menu">地域 : ${p.post_menu }</div>
                                </div>
                                <div style="display: flex; margin-left: auto; gap: 15px">
                                    <div class="info-name">投稿者 : ${p.user_nickname }</div>
                                    <div class="info-date">投稿日 : <fmt:formatDate value="${p.post_date}" pattern="yyyy-MM-dd HH:mm"/></div>
                                </div>
                            </div>

                        </div>
                        <div class="life-title">${p.post_title }</div>

                        <div class="life-info">
                            <div style="display: flex; gap: 15px">
                                <div class="info-name">投稿者 : ${p.user_nickname }</div>
                                <div class="info-date">投稿日 : <fmt:formatDate value="${p.post_date}"
                                                                                pattern="yyyy-MM-dd HH:mm"/></div>
                            </div>
                            <div style="display: flex; margin-left: auto; gap: 15px">
                                <div class="info-view">閲覧数 : ${p.post_view }</div>
                                <div class="info-like">いいね : ${p.post_like }</div>
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
    <div id="post-container"></div>
    <div id="pagination-container" style="display: flex; justify-content: center;"></div>
    <script src="/resources/js/tourBoard(paging).js"></script></div>
</body>
<script>
    function generateToken() {
        const now = new Date();
        const token = now.getMinutes() + ":" + now.getSeconds();  // "mm:ss" 형식
        return token;
    }

    function gotoPost(postId) {
        const token = generateToken();
        sessionStorage.setItem("viewToken", token);
        location.href = "tourBoard/" + postId + "?token=" + token;
    }

    function logincheck(user) {
        if (user)
            location.href = "/main/tourBoard/reg";
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

<script src="/resources/js/tourBoard.js"></script>

</html>