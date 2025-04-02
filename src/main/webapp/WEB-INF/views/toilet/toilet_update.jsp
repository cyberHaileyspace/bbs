<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>投稿修正</title>
    <script type="text/javascript" src="/resources/nse_files/js/HuskyEZCreator.js" charset="utf-8"></script>
    <link rel="stylesheet" href="/resources/css/sample.css">
    <link rel="stylesheet" href="/resources/css/toilet.css">
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=004383c9a684a2e2224afc37cca60d3c&libraries=services"></script>
    <style>     .location-btn {
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
    }</style>
</head>
<body>
<form id="updateForm" action="/main/toilet/update" method="post" enctype="multipart/form-data">
    <div class="reg_dom">
    <input type="hidden" name="post_id" value="${post.post_id}">
    <input type="hidden" name="user_nickname" value="${user.user_nickname}">

    <div class="reg_layout">
        <div>カテゴリー</div>
        <select name="post_category" id="post_category">
            <option value="office" <c:if test="${post.post_category == 'office'}">selected</c:if>>公共サービス</option>
            <option value="hospital" <c:if test="${post.post_category == 'hospital'}">selected</c:if>>病院</option>
            <option value="toilet" <c:if test="${post.post_category == 'toilet'}">selected</c:if>>トイレ</option>
            <option value="etc" <c:if test="${post.post_category == 'etc'}">selected</c:if>>その他</option>
        </select>
    </div>

    <div class="reg_layout">
        <div>地域</div>
        <select name="post_menu">
            <option value="ソウル" <c:if test="${post.post_menu == 'ソウル'}">selected</c:if>>ソウル</option>
            <option value="京畿／仁川" <c:if test="${post.post_menu == '京畿／仁川'}">selected</c:if>>京畿／仁川</option>
            <option value="忠清／大田" <c:if test="${post.post_menu == '忠清／大田'}">selected</c:if>>忠清／大田</option>
            <option value="全羅／光州" <c:if test="${post.post_menu == '全羅／光州'}">selected</c:if>>全羅／光州</option>
            <option value="慶北／大都" <c:if test="${post.post_menu == '慶北／大都'}">selected</c:if>>慶北／大都</option>
            <option value="慶南／釜山／蔵山" <c:if test="${post.post_menu == '慶南／釜山／蔵山'}">selected</c:if>>慶南／釜山／蔵山</option>
            <option value="江原" <c:if test="${post.post_menu == '江原'}">selected</c:if>>江原</option>
            <option value="濟州" <c:if test="${post.post_menu == '濟州'}">selected</c:if>>濟州</option>
        </select>
    </div>

    <div class="reg_layout">
        <div>タイトル</div>
        <textarea name="post_title" rows="3" cols="100" style="resize: none" placeholder="タイトルを入力してください。">${post.post_title}</textarea>
    </div>

    <div class="reg_layout" style="position: relative;">
        <div id="map" style="width: 100%; height: 300px; border: 1px solid #ccc; border-radius: 10px;"></div>
        <button type="button" class="location-btn" style="position:absolute; top:10px; right:10px; z-index:300;"
                onclick="moveToMyLocation()">📍 現在位置</button>
    </div>

    <input type="hidden" name="post_lat" id="post_lat" value="${post.post_lat}">
    <input type="hidden" name="post_lng" id="post_lng" value="${post.post_lng}">
<div class="reg_layout">
    <div>住所</div>
    <input name="post_address" id="post_address" value="${post.post_address}" readonly>
    </div>
        <div class="reg_layout">
    <div>内容</div>
    <textarea name="post_context" id="writearea" rows="15" cols="100">${post.post_context}</textarea>
    </div>
    <div class="reg_form">
    <div>
        <div>現在の画像:
            <c:if test="${not empty post.post_image}">
                <span>${post.post_image}</span>
                <input type="hidden" name="existing_post_image" value="${post.post_image}">
            </c:if>
        </div>
        <input type="file" name="post_file" id="btnAtt" style="display: none">

        <!-- label을 버튼처럼 사용 -->
        <label for="btnAtt" class="custom-file-label">
            ファイルを添付
        </label>
    </div>

    <div class="reg_button">
        <button type="button" onclick="history.back()">キャンセル</button>
        <button type="submit">修正</button>
    </div>
    </div>
    </div>
</form>

<!-- 스마트 에디터 -->
<script type="text/javascript">
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "writearea",
        sSkinURI: "/resources/nse_files/SmartEditor2Skin.html",
        fCreator: "createSEditor2",
        htParams: {
            bUseToolbar: true,
            bUseVerticalResizer: true,
            bUseModeChanger: true
        }
    });

    document.querySelector("form").addEventListener("submit", function (e) {
        oEditors.getById["writearea"].exec("UPDATE_CONTENTS_FIELD", []);
    });
</script>

<!-- 지도 및 마커 -->
<script type="text/javascript">
    let map, marker;
    const geocoder = new kakao.maps.services.Geocoder();

    const categoryIcons = {
        "office": "https://cdn-icons-png.flaticon.com/128/5693/5693863.png",
        "hospital": "https://cdn-icons-png.flaticon.com/128/5693/5693852.png",
        "toilet": "https://cdn-icons-png.flaticon.com/128/5695/5695154.png",  // 예: 변기 아이콘
        "etc": "https://cdn-icons-png.flaticon.com/128/5695/5695144.png"
    };

    function initMap() {
        const lat = parseFloat("${post.post_lat}") || 37.5665;
        const lng = parseFloat("${post.post_lng}") || 126.9780;
        const category = "${post.post_category}" || "etc";

        const markerImage = new kakao.maps.MarkerImage(
            categoryIcons[category],
            new kakao.maps.Size(40, 42),
            { offset: new kakao.maps.Point(13, 42) }
        );

        map = new kakao.maps.Map(document.getElementById("map"), {
            center: new kakao.maps.LatLng(lat, lng),
            level: 3
        });

        marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(lat, lng),
            image: markerImage
        });

        kakao.maps.event.addListener(map, "click", function (mouseEvent) {
            const latlng = mouseEvent.latLng;
            const selectedCategory = document.getElementById("post_category").value;

            const newImage = new kakao.maps.MarkerImage(
                categoryIcons[selectedCategory],
                new kakao.maps.Size(40, 42),
                { offset: new kakao.maps.Point(13, 42) }
            );

            marker.setPosition(latlng);
            marker.setImage(newImage);

            document.getElementById("post_lat").value = latlng.getLat();
            document.getElementById("post_lng").value = latlng.getLng();

            geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function (result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    document.getElementById("post_address").value = result[0].address.address_name;
                }
            });
        });

        document.getElementById("post_category").addEventListener("change", function () {
            const newIcon = categoryIcons[this.value];
            if (marker) {
                marker.setImage(new kakao.maps.MarkerImage(newIcon, new kakao.maps.Size(40, 42), {
                    offset: new kakao.maps.Point(13, 42)
                }));
            }
        });
    }

    function moveToMyLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                const lat = position.coords.latitude;
                const lng = position.coords.longitude;
                const loc = new kakao.maps.LatLng(lat, lng);

                map.setCenter(loc);

                const category = document.getElementById("post_category").value;
                const markerImage = new kakao.maps.MarkerImage(
                    categoryIcons[category],
                    new kakao.maps.Size(40, 42),
                    { offset: new kakao.maps.Point(13, 42) }
                );

                marker.setPosition(loc);
                marker.setImage(markerImage);

                document.getElementById("post_lat").value = lat;
                document.getElementById("post_lng").value = lng;

                geocoder.coord2Address(lng, lat, function (result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        document.getElementById("post_address").value = result[0].address.address_name;
                    }
                });
            });
        }
    }

    window.onload = function () {
        kakao.maps.load(initMap);
    };
</script>
</body>
</html>