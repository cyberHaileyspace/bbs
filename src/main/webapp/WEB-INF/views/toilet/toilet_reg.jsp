<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib
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
    <link rel="stylesheet" href="/resources/css/sample.css"/>
    <link rel="stylesheet" href="/resources/css/toilet.css">
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=004383c9a684a2e2224afc37cca60d3c&libraries=services"></script>

</head>
<body>
<form
        id="toiletReg"
        action="/main/toilet"
        method="post"
        enctype="multipart/form-data"
>
    <div class="reg_dom">
        <div hidden="hidden">
            ニックネーム :
            <input
                    name="user_nickname"
                    value="${user.user_nickname}"
                    type="text"
                    placeholder="${user.user_nickname}"
                    readonly
            />
        </div>

        <div class="reg_layout">
            <div>カテゴリー</div>
            <select name="post_category">
                <option value="生活情報">生活情報</option>
                <option value="健康情報">健康情報</option>
                <option value="質問">質問</option>
                <option value="レビュー">レビュー</option>
            </select>
        </div>
        <div class="reg_layout">
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

        <div class="reg_layout">
            <div>タイトル</div>
            <div>
          <textarea
                  name="post_title"
                  rows="5"
                  cols="100"
                  placeholder="タイトルを入力してください。"
                  style="resize: none"
          ></textarea>
            </div>
        </div>
        <div style="position: relative;">
            <div id="map" style="width: 100%; height: 300px; border: 1px solid #ccc; border-radius: 10px;"></div>
            <button type="button" style=" position: absolute;
    top: 10px;
    right: 10px;
    z-index: 300;
    padding: 8px 14px;
    border: none;
    background: #3478f6;
    color: white;
    font-weight: bold;
    border-radius: 6px;
    cursor: pointer;" class="location-btn" onclick="moveToMyLocation()">📍 내 위치
            </button>
        </div>
        <input readonly name="post_lat" id="post_lat"/>
        <input readonly name="post_lng" id="post_lng"/>

        <div class="reg_layout">
            <div>住所</div>
            <input readonly placeholder="位置を選択してください。" name="post_address" id="post_address"/>
        </div>

        <div class="reg_layout"
        <div>内容</div>
        <textarea
                name="post_context"
                id="writearea"
                value="post_context"
                rows="25"
                cols="100"
                placeholder="内容を入力してください。"
        ></textarea>
        <div style="display:flex; align-items: center">
            <div class="reg_layout">
                <input type="file" name="post_file" id="btnAtt" style="display: none"/>
                <!-- label을 버튼처럼 사용 -->
                <label for="btnAtt" class="custom-file-label">
                    ファイルを添付
                </label>

                <!-- 선택한 파일명 표시 -->
                <span id="fileName">ファイルなし</span>
            </div>
            <div class="reg_layout reg_button" style="display: flex; margin-left: auto">
                <button class="reg-cancel" type="button" onclick="history.back()">
                    キャンセル
                </button>
                <button class="reg-post" type="submit">投稿</button>
            </div>
        </div>
    </div>


</form>
</body>
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
            fOnBeforeUnload: function () {
            },
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

        if (!content) {
            alert("内容を入力してください。");
            e.preventDefault(); // 폼 제출 막기
            return;
        }

        // 검증 통과 시 submit
        document.getElementById("freeReg").submit();
    });
</script>
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
