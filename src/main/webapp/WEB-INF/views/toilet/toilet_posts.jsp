<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>Toilet Board</title>
    <link rel="stylesheet" href="/resources/css/board.css">
    <link rel="stylesheet" href="/resources/css/pagination.css">
    <link rel="stylesheet" href="/resources/css/toilet.css">

    <script src="https://code.jquery.com/jquery-3.7.1.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.5/pagination.min.js"></script>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=004383c9a684a2e2224afc37cca60d3c"></script>
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
</head>
<body>
<div class="toilet-container">

    <!-- 카테고리 -->
    <div class="category">
        <div><span class="menu" data-val="all">すべて</span></div>
        <div><span class="menu" data-val="office">公共サービス</span></div>
        <div><span class="menu" data-val="hospital">病院</span></div>
        <div><span class="menu" data-val="toilet">トイレ</span></div>
        <div><span class="menu" data-val="etc">その他</span></div>
    </div>
    <hr>

    <!-- 정렬 + 글쓰기 + 검색 -->
    <div class="sort">
        <div>
            <label><input type="radio" name="option" value="new" checked="checked"/> 最新順</label>
            <label><input type="radio" name="option" value="like"/> いいね順</label>
            <label><input type="radio" name="option" value="view"/> 閲覧順</label>
            <label><input type="radio" name="option" value="reply"/> コメント順</label>
        </div>
        <div style="display: flex; justify-content: flex-end">
            <button class="write-btn" onclick="logincheck('${sessionScope.user}')">
                <img class="write-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/> 作成
            </button>
        </div>
        <div class="search-btn">
            <input type="text" placeholder="タイトルを入力してください。" id="search-input">
            <button id="search-btn">
                <img class="search-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/256/25/25313.png"/> 検索
            </button>
        </div>
    </div>

    <!-- 지도 + 버튼 -->

    <div id="map" style="    position: relative; /* ✅ 이거 추가 */
            width: 100%;
            height: 400px;
            margin-bottom: 30px;
            border-radius: 10px;
            border: 1px solid #ccc;">  <button class="location-btn" onclick="showMyLocation()">📍 내 위치</button></div>
    <!-- 게시글 목록 -->
    <div id="post-container"></div>

    <!-- 페이징 -->
    <div id="pagination-container" style="display: flex; justify-content: center;"></div>

</div>
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
                        "https://cdn-icons-png.flaticon.com/512/252/252025.png", // 내 위치 마커 이미지
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
        "office": "https://cdn-icons-png.flaticon.com/512/5953/5953760.png",     // 공공서비스
        "hospital": "https://cdn-icons-png.flaticon.com/512/2972/2972657.png", // 병원
        "toilet": "https://cdn-icons-png.flaticon.com/512/169/169367.png",     // 화장실
        "etc": "https://cdn-icons-png.flaticon.com/512/5953/5953760.png",      // 기타
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


<script src="/resources/js/toilet/toilet.js"></script>

</body>
</html>
