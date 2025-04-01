<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=004383c9a684a2e2224afc37cca60d3c"></script>
</head>
<style>

    .location-btn {
        position: absolute;
        top: 10px;
        right: 30px;
        z-index: 10;
        padding: 8px 14px;
        border: none;
        background: #3478f6;
        color: white;
        font-weight: bold;
        border-radius: 6px;
        cursor: pointer;
    }

    .toilet-item.highlighted {
        border: 2px solid #3478f6;
        box-shadow: 0 0 12px rgba(52, 120, 246, 0.4);
        transition: all 0.3s ease;
    }

</style>
<body>
<div>
    <div class="main_content_wrapper" style="min-width: 100%">
        <div class="main_content_container">
            <div class="main_content">
                <%-- 뉴스 게시판 --%>
                <div class="main_content_box top_box">
                    <div class="main_board_header"><span class="main_board_header_title"
                                                         onclick="location.href='/main/news'">海外ニュース  <img src="https://cdn-icons-png.flaticon.com/128/117/117965.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></span><span
                            class="main_board_header_plus" onclick="location.href='/main/news'">もっと見る</span></div>
                    <div id="news-container"></div> <!-- 뉴스가 들어갈 공간 -->
                </div>
            </div>
            <div class="main_content">
                <%-- 자유 게시판 --%>
                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title"
                                                         onclick="location.href='/main/free'">自由掲示板  <img src="https://cdn-icons-png.flaticon.com/128/12094/12094191.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></span><span
                            class="main_board_header_plus" onclick="location.href='/main/free'">もっと見る</span></div>
                    <c:forEach var="f" items="${free}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <img src="${empty f.post_image ? '/img/no-image.png' : '/file/'}${f.post_image}" onclick="goToFree(${f.post_id})">
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
                                                         onclick="location.href='/main/life'">生活掲示板  <img src="https://cdn-icons-png.flaticon.com/128/4943/4943739.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></span><span
                            class="main_board_header_plus" onclick="location.href='/main/life'">もっと見る</span></div>
                    <c:forEach var="l" items="${life}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <img src="${empty l.post_image ? '/img/no-image.png' : '/file/'}${l.post_image}" onclick="goToLife(${l.post_id})">
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
                                                         onclick="location.href='/main/tour'">観光掲示板  <img src="https://cdn-icons-png.flaticon.com/128/5333/5333434.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></span><span
                            class="main_board_header_plus" onclick="location.href='/main/tour'">もっと見る</span></div>
                    <c:forEach var="t" items="${tourPosts}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <c:choose>
                                    <c:when test="${empty t.post_image}">
                                        <img src="/img/no-image.png" onclick="gotoTour(${t.post_id})">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/file/${t.post_image}" onclick="gotoTour(${t.post_id})">
                                    </c:otherwise>
                                </c:choose>
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
                                                         onclick="document.getElementById('defaultTourForm').submit()">観光情報  <img src="https://cdn-icons-png.flaticon.com/128/7813/7813703.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;"></span><span
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
            <div class="main_content">
                <%-- 모두의 맵 게시판 --%>
                <div class="main_content_box" style="padding: 0; margin: 15px 20px">
                    <div id="map" style="    position: relative; /* ✅ 이거 추가 */
            width: 100%;
            height: 100%;
            border-radius: 10px;
            border: 1px solid #ccc;">  <button class="location-btn" onclick="showMyLocation()"> <img src="https://cdn-icons-png.flaticon.com/128/7124/7124723.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">내 위치</button></div>

                </div>

                <div class="main_content_box">
                    <div class="main_board_header"><span class="main_board_header_title"
                                                         onclick="location.href='/main/toilet'">みんなのマップ</span><span
                            class="main_board_header_plus" onclick="location.href='/main/toilet'">もっと見る</span></div>
                    <c:forEach var="t" items="${map}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <div class="main_board_box">
                                <img src="${empty t.post_image ? '/img/no-image.png' : '/file/'}${t.post_image}" onclick="goToPost(${t.post_id})">
                                <p onclick="goToPost(${t.post_id})" class="main_board_content_title">${t.post_title}</p>
                                <p style="margin-left: auto">
                                    <fmt:formatDate value="${t.post_date}" pattern="yyyy.M.d"/>
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
<script>
    function showMyLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function (position) {
                    const lat = position.coords.latitude;
                    const lng = position.coords.longitude;

                    const loc = new kakao.maps.LatLng(lat, lng);
                    map.setCenter(loc);

                    const markerImage = new kakao.maps.MarkerImage(
                        "https://cdn-icons-png.flaticon.com/128/7124/7124723.png", // 내 위치 마커 이미지
                        new kakao.maps.Size(40, 42),
                        { offset: new kakao.maps.Point(13, 42) }
                    );

                    const myMarker = new kakao.maps.Marker({
                        map: map,
                        position: loc,
                        image: markerImage
                    });

                    console.log("내 위치 표시됨:", lat, lng);
                },
                function (error) {
                    console.error("위치 정보 가져오기 실패:", error.message);
                    alert("위치 정보를 가져올 수 없습니다.");
                },
                { enableHighAccuracy: true }
            );
        } else {
            alert("이 브라우저는 위치 정보를 지원하지 않습니다.");
        }
    }
</script>
<script>
    let map;
    let postMarkers = [];

    document.addEventListener("DOMContentLoaded", async function () {
        const container = document.getElementById('map');
        map = new kakao.maps.Map(container, {
            center: new kakao.maps.LatLng(37.5665, 126.9780),
            level: 3
        });

        const data = await loadData("");
        addMarkersToMap(data); // 마커 추가
        categoryHandler();
        optionHandler();
        paging(data);
        searchHandler();
    });

    const categoryIcons = {
        "office": "https://cdn-icons-png.flaticon.com/128/5693/5693863.png",
        "hospital": "https://cdn-icons-png.flaticon.com/128/5693/5693852.png",
        "toilet": "https://cdn-icons-png.flaticon.com/128/5695/5695154.png",  // 예: 변기 아이콘
        "etc": "https://cdn-icons-png.flaticon.com/128/5695/5695144.png",     // 기타
        "default": "https://cdn-icons-png.flaticon.com/512/684/684908.png"     // 기본 마커
    };

    const categoryLabels = {
        office: "公共サービス",
        hospital: "病院",
        toilet: "トイレ",
        etc: "その他"
    };
    let openInfoWindow = null;

    function addMarkersToMap(posts) {
        postMarkers.forEach(({ marker }) => marker.setMap(null));
        postMarkers = [];

        posts.forEach((p) => {
            if (p.post_lat && p.post_lng) {
                const latlng = new kakao.maps.LatLng(p.post_lat, p.post_lng);
                const category = p.post_category || "default";

                const markerImage = new kakao.maps.MarkerImage(
                    categoryIcons[category] || categoryIcons["default"],
                    new kakao.maps.Size(40, 42),
                    { offset: new kakao.maps.Point(20, 42) }
                );

                const marker = new kakao.maps.Marker({
                    map: map,
                    position: latlng,
                    image: markerImage
                });

                const iwContent =
                    "<div style='padding:6px 12px; font-size:13px; font-weight:bold; color:#333;'>" +
                    "<div style='font-size:11px; color:gray;'>[" + (categoryLabels[p.post_category] || "未分類") + "]</div>" +
                    "<div style='cursor:pointer;'>" + p.post_title + "</div>" +
                    "</div>";
                const infowindow = new kakao.maps.InfoWindow({
                    content: iwContent,
                    removable: false
                });

                kakao.maps.event.addListener(marker, 'click', function () {
                    if (openInfoWindow) openInfoWindow.close(); // 이전 인포윈도우 닫기
                    infowindow.open(map, marker);
                    openInfoWindow = infowindow;

                    openToiletModal(p);
                    highlightCard(p.post_id);
                });

                postMarkers.push({ id: p.post_id, marker });
            }
        });
    }

    function highlightCard(postId) {
        // 전체 카드에서 클래스 제거
        document.querySelectorAll(".toilet-item").forEach(card => {
            card.classList.remove("highlighted");
        });

        const target = [...document.querySelectorAll(".toilet-item")].find(el => {
            return el.querySelector(".toilet-card")?.dataset.post?.includes(`"post_id":${postId}`);
        });

        if (target) {
            target.classList.add("highlighted");
        }
    }

    function moveToMarkerAndOpenModal(postId) {
        const match = postMarkers.find(m => m.id === postId);
        if (match) {
            map.setCenter(match.marker.getPosition());
            const targetCard = document.querySelector(`.toilet-card[data-post*='"post_id":${postId}']`);
            if (targetCard) {
                const postData = JSON.parse(decodeURIComponent(targetCard.dataset.post));
                openToiletModal(postData);
                highlightCard(postId);
            }
        }
    }

    // 카드 클릭 이벤트 수정
    document.addEventListener("click", function (e) {
        const card = e.target.closest(".toilet-card");
        if (card && card.dataset.post) {
            try {
                const postData = JSON.parse(decodeURIComponent(card.dataset.post));
                moveToMarkerAndOpenModal(postData.post_id);
            } catch (err) {
                console.error("모달 파싱 실패:", err);
            }
        }
    });
</script>

</body>
</html>