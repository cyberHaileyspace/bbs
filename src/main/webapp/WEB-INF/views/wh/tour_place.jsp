<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
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
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8bcc8b8a46ced572b3699ea34f27a380"></script>
            <script>
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                    mapOption = {
                        center: new kakao.maps.LatLng(${common.mapy}, ${common.mapx}), // 지도의 중심좌표
                        level: 4, // 지도의 확대 레벨
                        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
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
                    draggable : true, // 마커를 드래그 가능하도록 설정한다
                    map: map // 마커를 표시할 지도 객체
                });

            </script>
        </div>
    </div>
    <div style="text-align: center; padding: 50px"><a href="/main/tour" style="text-decoration: none; color: black; font-size: large">리스트로 돌아가기</a></div>
    <div>
        <div class="comment-section">
            <div class="comment-header">댓글 쓰기</div>
            <div hidden="hidden">닉네임 : <input name="user_nickname" value="${user.user_nickname}" type="text"
                                              placeholder="${user.user_nickname}" readonly></div>
            <textarea id="replyContent" placeholder="댓글을 입력하세요..."></textarea>
            <button onclick="insertReply()">댓글 쓰기</button>
        </div>
<%--        <c:choose>--%>
<%--            <c:when test="${not empty replys}">--%>
<%--                <c:forEach items="${replys}" var="r">--%>
<%--                    <span>작성자 : ${r.c_writer}</span>--%>
<%--                    <span><fmt:formatDate value="${r.c_date}" pattern="YYYY-MM-DD HH:mm"/></span>--%>
<%--                    <span>${r.c_context}</span>--%>
<%--                    <c:if test="${user.user_nickname == r.c_writer}">--%>
<%--                        <button>삭제</button>--%>
<%--                        <button>수정</button>--%>
<%--                    </c:if>--%>
<%--                    <br>--%>
<%--                </c:forEach>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
<%--                <p>댓글이 없습니다. 댓글을 작성해 보세요!</p>--%>
<%--            </c:otherwise>--%>
<%--        </c:choose>--%>
    </div>
</div>


</body>
</html>