<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8" />
    <title>投稿作成</title>
    <script
      type="text/javascript"
      src="/resources/nse_files/js/HuskyEZCreator.js"
      charset="utf-8"
    ></script>
    <link rel="stylesheet" href="/resources/css/sample.css" />
    <link rel="stylesheet" href="/resources/css/toilet.css" />
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=004383c9a684a2e2224afc37cca60d3c&libraries=services"
    ></script>
  </head>
  <style>
    .location-btn {
      position: absolute;
      top: 10px;
      right: 100px;
      z-index: 10;
      padding: 8px 14px;
      border: none;
      background: #3478f6;
      color: white;
      font-weight: bold;
      border-radius: 6px;
      cursor: pointer;
    }
  </style>
  <body>
    <form
      id="toiletReg"
      action="/main/toilet"
      method="post"
      enctype="multipart/form-data"
    >
      <input type="hidden" name="user_nickname" value="${user.user_nickname}" />

      <div>
        <div>カテゴリー（掲示板分類）</div>
        <select name="post_category" id="post_marker_category">
          <option value="office">公共サービス</option>
          <option value="hospital">病院</option>
          <option value="toilet">トイレ</option>
          <option value="etc">その他</option>
        </select>
      </div>

      <div>
        <div>地域</div>
        <select name="post_menu">
          <option value="ソウル">ソウル</option>
          <option value="京畿／仁川">京畿／仁川</option>
          <option value="忠清／大田">忠清／大田</option>
          <option value="全羅／光州">全羅／光州</option>
          <option value="慶北／大都">慶北／大都</option>
          <option value="慶南／釜山／蓬山">慶南／釜山／蓬山</option>
          <option value="治原">治原</option>
          <option value="濟州">濟州</option>
        </select>
      </div>

      <div>
        <div>タイトル</div>
        <textarea
          name="post_title"
          rows="3"
          cols="100"
          placeholder="タイトルを入力してください。"
          style="resize: none"
        ></textarea>
      </div>

      <div style="position: relative">
        <div
          id="map"
          style="
            width: 60%;
            height: 300px;
            border: 1px solid #ccc;
            border-radius: 10px;
          "
        ></div>
        <button
          type="button"
          style="position: absolute; top: 10px; right: 560px; z-index: 300"
          class="location-btn"
          onclick="moveToMyLocation()"
        >
          📍 내 위치
        </button>
      </div>

      <input type="hidden" name="post_lat" id="post_lat" />
      <input type="hidden" name="post_lng" id="post_lng" />

      <div>住所</div>
      <input
        readonly
        placeholder="位置を選択してください。"
        name="post_address"
        id="post_address"
      />

      <div>内容</div>
      <textarea
        name="post_context"
        id="writearea"
        rows="15"
        cols="100"
        placeholder="内容を入力してください。"
      ></textarea>

      <div>
        <div>画像</div>
        <input type="file" name="post_file" id="btnAtt" />
      </div>

      <div>
        <button class="reg-cancel" type="button" onclick="history.back()">
          取り消し
        </button>
        <button class="reg-post" type="submit">投稿</button>
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
          bUseModeChanger: true,
        },
      });

      document
        .querySelector(".reg-post")
        .addEventListener("click", function (e) {
          oEditors.getById["writearea"].exec("UPDATE_CONTENTS_FIELD", []);
          const title = document
            .querySelector("textarea[name='post_title']")
            .value.trim();
          const content = document
            .querySelector("textarea[name='post_context']")
            .value.trim();

          if (!title || !content) {
            alert("タイトルと内容を入力してください。");
            e.preventDefault();
          }
        });
    </script>

    <!-- 지도 초기화 및 마커 설정 -->
    <script type="text/javascript">
      let map, marker;
      const geocoder = new kakao.maps.services.Geocoder();

      const categoryIcons = {
        office: "https://cdn-icons-png.flaticon.com/128/5693/5693863.png",
        hospital: "https://cdn-icons-png.flaticon.com/128/5693/5693852.png",
        toilet: "https://cdn-icons-png.flaticon.com/128/5695/5695154.png", // 예: 변기 아이콘
        etc: "https://cdn-icons-png.flaticon.com/128/5695/5695144.png",
      };

      function initMap() {
        const container = document.getElementById("map");
        map = new kakao.maps.Map(container, {
          center: new kakao.maps.LatLng(37.5665, 126.978),
          level: 3,
        });

        kakao.maps.event.addListener(map, "click", function (mouseEvent) {
          const latlng = mouseEvent.latLng;
          const category = document.getElementById(
            "post_marker_category"
          ).value;
          const markerImage = new kakao.maps.MarkerImage(
            categoryIcons[category],
            new kakao.maps.Size(40, 42),
            { offset: new kakao.maps.Point(13, 42) }
          );

          if (!marker) {
            marker = new kakao.maps.Marker({
              map: map,
              position: latlng,
              image: markerImage,
            });
          } else {
            marker.setPosition(latlng);
            marker.setImage(markerImage);
          }

          document.getElementById("post_lat").value = latlng.getLat();
          document.getElementById("post_lng").value = latlng.getLng();

          geocoder.coord2Address(
            latlng.getLng(),
            latlng.getLat(),
            function (result, status) {
              if (status === kakao.maps.services.Status.OK) {
                document.getElementById("post_address").value =
                  result[0].address.address_name;
              }
            }
          );
        });
      }

      function moveToMyLocation() {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function (position) {
            const lat = position.coords.latitude;
            const lng = position.coords.longitude;
            const loc = new kakao.maps.LatLng(lat, lng);

            map.setCenter(loc);

            const category = document.getElementById(
              "post_marker_category"
            ).value;
            const markerImage = new kakao.maps.MarkerImage(
              categoryIcons[category],
              new kakao.maps.Size(40, 42),
              { offset: new kakao.maps.Point(13, 42) }
            );

            if (!marker) {
              marker = new kakao.maps.Marker({
                map: map,
                position: loc,
                image: markerImage,
              });
            } else {
              marker.setPosition(loc);
              marker.setImage(markerImage);
            }

            document.getElementById("post_lat").value = lat;
            document.getElementById("post_lng").value = lng;

            geocoder.coord2Address(lng, lat, function (result, status) {
              if (status === kakao.maps.services.Status.OK) {
                document.getElementById("post_address").value =
                  result[0].address.address_name;
              }
            });
          });
        } else {
          alert("이 브라우저는 위치 정보를 지원하지 않아요.");
        }
      }

      document.addEventListener("DOMContentLoaded", function () {
        initMap();

        document
          .getElementById("post_marker_category")
          .addEventListener("change", function () {
            if (marker) {
              const category = this.value;
              const markerImage = new kakao.maps.MarkerImage(
                categoryIcons[category],
                new kakao.maps.Size(40, 42),
                { offset: new kakao.maps.Point(13, 42) }
              );
              marker.setImage(markerImage);
            }
          });
      });
    </script>
  </body>
</html>
