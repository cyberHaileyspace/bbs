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
        <div><span class="menu">すべて</span></div>
        <div><span class="menu" data-val="生活情報">生活情報</span></div>
        <div><span class="menu" data-val="健康情報">健康情報</span></div>
        <div><span class="menu" data-val="質問">質問</span></div>
        <div><span class="menu" data-val="レビュー">レビュー</span></div>
    </div>


    <!-- 정렬 + 글쓰기 + 검색 -->
    <div class="sort">
        <div>
            <div style="display: flex; justify-content: center">
                <h2>みんなのマップ</h2>
            </div>
            <div class="search-btn">
                <input type="text" placeholder="タイトルを入力してください。" id="search-input">
                <button id="search-btn"><img class="search-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/256/25/25313.png"/> 検索</button>
            </div>
            <hr>

            <div style="display: flex; align-items: center; margin-bottom: 10px">
            <div style="display: flex">
                <label class="cate_radio">
                    <input type="radio" name="option" value="new" checked="checked"/><span>最新順</span>
                </label>
                <label class="cate_radio">
                    <input type="radio" name="option" value="like"/><span>いいね順</span>
                </label>
                <label class="cate_radio">
                    <input type="radio" name="option" value="view"/><span>閲覧数順</span>
                </label>
                <label class="cate_radio">
                    <input type="radio" name="option" value="reply"/><span>コメント順</span>
                </label>
            </div>
            <div style="display: flex; margin-left: auto">
                <button class="write-btn" onclick="logincheck('${sessionScope.user}')">
                    <img class="write-btn-img" alt="" src="https://cdn-icons-png.flaticon.com/512/117/117476.png"/> 作成
                </button>
            </div>
            </div>

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

    function addMarkersToMap(posts) {
        postMarkers = [];

        posts.forEach((p, idx) => {
            if (p.post_lat && p.post_lng) {
                const latlng = new kakao.maps.LatLng(p.post_lat, p.post_lng);

                const marker = new kakao.maps.Marker({
                    map: map,
                    position: latlng
                });

                const iwContent = "<div style=\"padding:6px 12px; font-size:13px; font-weight:bold; color:#333; cursor:pointer\">" + p.post_title + "</div>";
                const infowindow = new kakao.maps.InfoWindow({
                    content: iwContent,
                    removable: false
                });
                infowindow.open(map, marker);

                kakao.maps.event.addListener(marker, 'click', function () {
                    openToiletModal(p);
                    highlightCard(p.post_id);
                });

                kakao.maps.event.addListener(infowindow, 'domready', function () {
                    const iwDiv = document.querySelector(".infoWindow");
                    if (iwDiv) {
                        iwDiv.style.cursor = "pointer";
                        iwDiv.onclick = function () {
                            openToiletModal(p);
                            highlightCard(p.post_id);
                        }
                    }
                });

                postMarkers.push({ id: p.post_id, marker });
            }
        });
    }

    function showMyLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function (position) {
                    const lat = position.coords.latitude;
                    const lng = position.coords.longitude;

                    const loc = new kakao.maps.LatLng(lat, lng);
                    map.setCenter(loc);

                    new kakao.maps.Marker({
                        map: map,
                        position: loc,
                        image: new kakao.maps.MarkerImage(
                            "https://cdn-icons-png.flaticon.com/512/252/252025.png",
                            new kakao.maps.Size(40, 42),
                            { offset: new kakao.maps.Point(13, 42) }
                        )
                    });

                    console.log("📍 내 위치:", lat, lng);
                },
                function (error) {
                    console.error("❌ 위치 정보 접근 실패:", error.message);
                },
                { enableHighAccuracy: true }
            );
        }
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
