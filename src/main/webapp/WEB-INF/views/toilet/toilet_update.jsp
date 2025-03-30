<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script type="text/javascript" src="/resources/nse_files/js/HuskyEZCreator.js" charset="utf-8"></script>
    <link rel="stylesheet" href="/resources/css/sample.css">
    <link rel="stylesheet" href="/resources/css/toilet.css">
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=004383c9a684a2e2224afc37cca60d3c&libraries=services"></script>
</head>
<body>
<form id="writereg" action="/main/toilet/update" method="post" enctype="multipart/form-data">
    <input type="hidden" name="post_id" value="${post.post_id}">
    <div>
        <div hidden="hidden">
            ニックネーム : <input name="user_nickname" value="${user.user_nickname}" type="text" placeholder="${user.user_nickname}" readonly>
        </div>
        <div>カテゴリー</div>
        ${post.post_id}
        <div>
            <select name="post_category">
                <option value="生活情報" <c:if test="${post.post_category == '生活情報'}">selected</c:if>>生活情報</option>
                <option value="健康情報" <c:if test="${post.post_category == '健康情報'}">selected</c:if>>健康情報</option>
                <option value="質問" <c:if test="${post.post_category == '質問'}">selected</c:if>>質問</option>
                <option value="レビュー" <c:if test="${post.post_category == 'レビュー'}">selected</c:if>>レビュー</option>
            </select>
        </div>
        <div>
            <div>地域</div>
            <select name="post_menu">
                <option value="ソウル" <c:if test="${post.post_menu == 'ソウル'}">selected</c:if>>ソウル</option>
                <option value="京畿／仁川" <c:if test="${post.post_menu == '京畿／仁川'}">selected</c:if>>京畿／仁川</option>
                <option value="忠正／大田" <c:if test="${post.post_menu == '忠正／大田'}">selected</c:if>>忠正／大田</option>
                <option value="全羅／光州" <c:if test="${post.post_menu == '全羅／光州'}">selected</c:if>>全羅／光州</option>
                <option value="慶北／大都" <c:if test="${post.post_menu == '慶北／大都'}">selected</c:if>>慶北／大都</option>
                <option value="慶南／釜山／蔵山" <c:if test="${post.post_menu == '慶南／釜山／蔵山'}">selected</c:if>>慶南／釜山／蔵山</option>
                <option value="江原" <c:if test="${post.post_menu == '江原'}">selected</c:if>>江原</option>
                <option value="濟州" <c:if test="${post.post_menu == '濟州'}">selected</c:if>>濟州</option>
            </select>
        </div>
    </div>
    <div>
        <div>タイトル</div>
        <div><textarea name="post_title" rows="5" cols="100" style="resize: none;">${post.post_title}</textarea></div>
    </div>
    <div style="position: relative;">
        <div id="map" style="width: 60%; height: 300px; border: 1px solid #ccc; border-radius: 10px;"></div>
        <button type="button" style=" position: absolute;
    top: 10px;
    right: 560px;
    z-index: 300;
    padding: 8px 14px;
    border: none;
    background: #3478f6;
    color: white;
    font-weight: bold;
    border-radius: 6px;
    cursor: pointer;" class="location-btn" onclick="moveToMyLocation()">📍 내 위치</button>
    </div>
        <input readonly value="${post.post_lat}" name="post_lat" id="post_lat" />
        <input readonly value="${post.post_lng}" name="post_lng" id="post_lng" />
        <div>住所</div>
        <div>
            <input readonly value="${post.post_address}" placeholder="位置を選択してください。" name="post_address" id="post_address" />
        </div>
        <div>内容</div>
        <div>
            <textarea name="post_context" id="writearea" value="post_context" rows="25" cols="100">${post.post_context}</textarea>
        </div>

    <div>
        <div>
            <div>現在のファイル :
                <c:if test="${not empty post.post_image}">
                    <span>${post.post_image}</span>
                    <input type="hidden" name="existing_post_image" value="${post.post_image}">
                </c:if>
            </div>
            <div>
                <input type="file" name="post_file" id="btnAtt">
            </div>
        </div>
    </div>
    <div>
        <button class="reg-cancel" type="button" onclick="history.back()">取り消し</button>
        <button class="reg-post" type="submit" name="post_id" value="${post.post_id}">修正完了</button>
    </div>
    </div>
</form>
</body>
<script type="text/javascript">
    let map, marker;
    const geocoder = new kakao.maps.services.Geocoder();

    function initMap() {
        const lat = parseFloat("${post.post_lat}");
        const lng = parseFloat("${post.post_lng}");
        const address = "${post.post_address}";

        const mapContainer = document.getElementById('map');
        const mapOption = {
            center: new kakao.maps.LatLng(lat || 37.5665, lng || 126.9780),
            level: 3
        };
        map = new kakao.maps.Map(mapContainer, mapOption);

        if (!isNaN(lat) && !isNaN(lng)) {
            marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(lat, lng),
                map: map
            });
        }

        document.getElementById('post_lat').value = lat;
        document.getElementById('post_lng').value = lng;
        document.getElementById('post_address').value = address;

        // 마커 찍기 (지도 클릭 시)
        kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
            const latlng = mouseEvent.latLng;

            if (!marker) {
                marker = new kakao.maps.Marker({
                    map: map,
                    position: latlng
                });
            } else {
                marker.setPosition(latlng);
            }

            document.getElementById('post_lat').value = latlng.getLat();
            document.getElementById('post_lng').value = latlng.getLng();

            // 주소 변환
            geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    const address = result[0].address.address_name;
                    document.getElementById('post_address').value = address;
                }
            });
        });
    }

    function moveToMyLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                const lat = position.coords.latitude;
                const lng = position.coords.longitude;
                const loc = new kakao.maps.LatLng(lat, lng);

                map.setCenter(loc);

                if (!marker) {
                    marker = new kakao.maps.Marker({ map: map, position: loc });
                } else {
                    marker.setPosition(loc);
                }

                document.getElementById('post_lat').value = lat;
                document.getElementById('post_lng').value = lng;

                geocoder.coord2Address(lng, lat, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        const address = result[0].address.address_name;
                        document.getElementById('post_address').value = address;
                    }
                });
            });
        } else {
            alert("이 브라우저는 위치 정보를 지원하지 않아요.");
        }
    }

    // 기존 코드
    // window.onload = initMap;

    // 수정된 코드 👇
    window.onload = function () {
        kakao.maps.load(initMap);
    };

</script>

<script type="text/javascript" id="smartEditor">
    var oEditors = [];

    // 스마트에디터 프레임 생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "writearea",
        sSkinURI: "/resources/nse_files/SmartEditor2Skin.html",
        fCreator: "creatorSEditor2",
        htParams: {
            bUseToolbar: true,
            bUseVericalResizer: true,
            bUseModeChanger: true,
            fOnBeforeUnload: function () {},
        },
    });

    document.querySelector(".reg-post").addEventListener("click", function (e) {
        // 스마트에디터 내용 → textarea로 업데이트
        oEditors.getById["writearea"].exec("UPDATE_CONTENTS_FIELD", []);

        // 제목과 내용 가져오기
        const title = document.querySelector("textarea[name='post_title']").value.trim();
        const content = document.querySelector("textarea[name='post_context']").value.trim();

        if (!title) {
            alert("タイトルを入力してください。");
            e.preventDefault(); // 폼 제출 막기
            return;
        }

        if (!content) {
            alert("内容を入力してください。");
            e.preventDefault(); // 폼 제출 막기
            return;
        }

        // 검증 통과 시 submit
        document.getElementById("freeReg").submit();
    });
</script>

</html>
