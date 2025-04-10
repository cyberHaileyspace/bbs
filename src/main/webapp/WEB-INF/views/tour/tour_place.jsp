<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ page language="java"
contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Title</title>
  </head>
  <body>
    <div class="tour_info_wrapper">
      <div class="tour_info_container">
        <div class="tour_info_whole_box">
          <h2 style="text-align: center">${common.title}</h2>
          <div class="tour_info_content_box">
            <div style="width: 45%">
              <img src="${common.firstimage}" />
              <div id="map" style="width: 100%; height: 300px"></div>
            </div>
            <div style="width: 55%">
              <div style="margin-bottom: 40px; font-size: large">
                <p style="margin-top: 0">住所 : ${common.addr1}</p>
                <p>郵便番号 : ${common.zipcode}</p>
                <p>連絡先・お問い合わせ : ${intro.infocenter}</p>
              </div>
              <span class="overview"> ${common.overview} </span>
            </div>
          </div>
          <script
            type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8bcc8b8a46ced572b3699ea34f27a380"
          ></script>
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
      <div style="text-align: center; padding: 50px; justify-content: center; display: flex; border-bottom: 1px solid">
          <button
            type="button"
            onclick="history.back()"
            style="
              background: none;
              border: none;
              text-decoration: none;
              color: black;
              font-size: large;
              cursor: pointer;
              width: 230px;
            "
          >
            リストに戻る
          </button>
      </div>
      <div>
        <div class="comment-section">
          <div class="comment-header">コメントを書く</div>
          <div hidden="hidden">
            닉네임 :
            <input
              name="user_nickname"
              value="${sessionScope.user.user_nickname}"
              type="text"
              placeholder="${sessionScope.user.user_nickname}"
              readonly
            />
          </div>
          <div class="comment-ta">
            <textarea
              id="replyContent"
              placeholder="コメントを入力してください..."
              style="resize: none"
            ></textarea>
            <button
                    id="commentButton"
                    onclick="handleTourReplySubmit('${sessionScope.user.user_nickname}')"
            >
              コメント投稿
            </button>
          </div>

        </div>
        <div id="replySection"></div>
      </div>
    </div>

    <script>
      var post_id = ${common.contentid}; // JSP 변수를 JavaScript 변수에 할당
      var user_nickname = "${sessionScope.user.user_nickname}"; // 로그인한 사용자의 닉네임을 JSP 변수로 받아옴

      console.log(post_id, user_nickname);
      // 페이지 로드 시 댓글을 비동기적으로 가져오는 함수
      function loadReplies() {
          fetch('/main/locReply/' + post_id)
              .then(response => response.json())
              .then(data => {
                  console.log("Fetched Replies:", data)
                  const replySection = document.getElementById("replySection");
                  replySection.innerHTML = ""; // 기존 댓글 삭제

                  if (data.length === 0) {
                      replySection.innerHTML = "<p>コメントはまだありません。ぜひ最初のコメントを投稿してください！</p>";
                  } else {
                      data.forEach(reply => {
                          const replyDiv = document.createElement("div");
                          replyDiv.classList.add("reply")
                          replyDiv.id = "reply-" + reply.r_id;
                          // 댓글 작성자와 로그인한 사용자가 동일한 경우 삭제 및 수정 버튼을 추가
                          let replytHTML =
                              "<div>" + "<div style='display: flex'>" +
                              "<span>投稿者 : " + reply.r_writer + "</span>" +
                              "<span style='margin-left: auto'>投稿日 : "  + reply.r_date + "</span>" + "</div>" +
                              "<p>"+ reply.r_context +"</p>"
                              + "</div>"
                          ;

                          if (user_nickname === reply.r_writer) {
                              replytHTML += "<div style='display: flex; gap: 15px'>" +"<button onclick=\"editReply('" + reply.r_id + "', '" + reply.r_writer + "', '" + reply.r_date + "', '" + reply.r_context + "')\" class='reply_my_button'>修正</button>"
                                  +
                                  "<button onclick=\"deleteReply('" + reply.r_id + "')\" class='reply_my_button'>削除</button>" + "</div>";
                          }
                          replyDiv.innerHTML = replytHTML;
                          replySection.appendChild(replyDiv);
                      });
                  }
              })
              .catch(error => {
                  console.error("댓글 로드 실패:", error);
              });
      }
    </script>
  <script src="/resources/js/tour.js"></script>
  </body>
</html>
