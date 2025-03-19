<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .post-header div {
            font-size: 16px;
            color: #555;
        }

        .post-header .title {
            font-weight: bold;
            color: #333;
            font-size: 20px;
        }

        .post-image-container img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }

        .post-content .text {
            font-size: 14px;
            color: #333;
            line-height: 1.8;
        }

        .post-content .date {
            font-size: 12px;
            color: #888;
        }

        .comment-section .comment-header {
            font-weight: bold;
            color: #333;
        }

        .comment-section textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .comment-section button {
            background-color: #007BFF;
            margin-top: 10px;
        }

        .comment-section button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="tour_info_wrapper">
    <div class="tour_info_container">
        <div class="tour_info_whole_box">
            <h2 style="text-align: center">${common.title}</h2>
            <div class="tour_info_content_box">
                <div style="width: 45%">
                    <img src="${common.firstimage}">
                    <div id="map" style="width:100%; height:300px;"></div>
                </div>
                <div style="width: 55%">
                    <div style="margin-bottom: 40px; font-size: large">
                        <p style="margin-top: 0"> 주소 : ${common.addr1}</p>
                        <p> 우편번호 : ${common.zipcode}</p>
                        <p> 연락 및 문의 : ${intro.infocenter}</p>

                    </div>
                    <span class="overview">
                        ${common.overview}
                    </span>
                </div>
            </div>
            <script type="text/javascript"
                    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8bcc8b8a46ced572b3699ea34f27a380"></script>
            <script>
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                    mapOption = {
                        center: new kakao.maps.LatLng(${common.mapy}, ${common.mapx}), // 지도의 중심좌표
                        level: 4, // 지도의 확대 레벨
                        mapTypeId: kakao.maps.MapTypeId.ROADMAP // 지도종류
                    };

                // 지도를 생성한다
                var map = new kakao.maps.Map(mapContainer, mapOption);

                // 지도 타입 변경 컨트롤을 생성한다
                var mapTypeControl = new kakao.maps.MapTypeControl();

                // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
                map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

                // 지도에 확대 축소 컨트롤을 생성한다
                var zoomControl = new kakao.maps.ZoomControl();

                // 지도의 우측에 확대 축소 컨트롤을 추가한다
                map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

                // 지도에 마커를 생성하고 표시한다
                var marker = new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(${common.mapy}, ${common.mapx}), // 마커의 좌표
                    draggable: true, // 마커를 드래그 가능하도록 설정한다
                    map: map // 마커를 표시할 지도 객체
                });

            </script>
        </div>
    </div>
    <div style="text-align: center; padding: 50px">

        <%--        <form id="backForm" action="/main/tour/loc" method="post" style="display:inline">--%>
        <button type="button" onclick="history.back()"
                style="background:none; border:none; text-decoration: none; color: black; font-size: large; cursor: pointer; width: 230px">
            리스트로 돌아가기
        </button>
        <%--        </form>--%>
    </div>
    <!-- 댓글 입력 폼 -->
    <form id="commentForm" action="/tour/comment" method="post">
        <input type="hidden" name="contentid" value="${common.contentid}"/>
        <!-- 로그인된 경우에만 사용자 닉네임을 넣음. (로그인하지 않은 경우 빈 문자열) -->
        <input type="hidden" name="c_writer"
               value="${sessionScope.user != null ? sessionScope.user.user_nickname : ''}"/>
        <textarea name="c_context" placeholder="댓글을 입력하세요..."></textarea>
        <input type="submit" value="댓글 쓰기"/>
    </form>


    <!-- 댓글 목록 표시 영역 -->
    <div id="commentSection">
        <c:choose>
            <c:when test="${not empty commentList}">
                <c:forEach var="r" items="${commentList}">
                    <div class="comment">
                        <span>작성자: ${r.c_writer}</span>
                        <span><fmt:formatDate value="${r.c_date}" pattern="yyyy-MM-dd HH:mm"/></span>
                        <p>${r.c_context}</p>
                        <c:if test="${user.user_nickname == r.c_writer}">
                            <form action="/tour/comment/delete" method="post" style="display:inline">
                                <input type="hidden" name="c_id" value="${r.c_id}"/>
                                <input type="hidden" name="contentid" value="${common.contentid}"/>
                                <input type="submit" value="삭제"/>
                            </form>
                            <!-- 수정 버튼은 별도의 수정 페이지나 팝업으로 구현할 수 있습니다. -->
                        </c:if>
                    </div>
                    <hr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>댓글이 없습니다. 댓글을 작성해 보세요!</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
<script>
    window.addEventListener("load", function() {
        const slider = document.getElementById("imageSlider");
        if (!slider) return;
        const images = slider.querySelectorAll("img");
        if (images.length <= 1) return; // 이미지가 1장 이하이면 슬라이더 작동 안 함

        // 모든 이미지가 같은 너비라고 가정 (최대 600px)
        // slider의 현재 translateX 값을 관리할 변수
        let currentIndex = 0;

        // 다음 슬라이드로 전환하는 함수
        function nextSlide() {
            currentIndex = (currentIndex + 1) % images.length;
            // 슬라이더의 너비(또는 이미지의 너비)를 기준으로 이동
            // 이미지가 inline-block으로 나열되어 있으므로, 각 이미지의 너비를 사용합니다.
            const imageWidth = images[0].offsetWidth;
            slider.style.transform = "translateX(-" + (currentIndex * imageWidth) + "px)";
        }

        // 3초마다 nextSlide 함수 호출
        setInterval(nextSlide, 3000);
    });
</script>
</html>