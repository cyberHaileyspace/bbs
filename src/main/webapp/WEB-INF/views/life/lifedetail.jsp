<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <%-- <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" /> --%>
    <script type="text/javascript" src="/resources/nse_files/js/HuskyEZCreator.js" charset="utf-8"></script>
    <link rel="stylesheet" href="/resources/css/life/life.css">
</head>
<body>
<div class="container-cm-post">

    <div onclick="location.href='/main/life'" style="cursor: pointer">생활게시판 ></div>

    <div class="post-title"><span> ${post.post_title } </span></div>

    <div class="post-info">
        <%--<div>
            <img src="/file/${post.user_image}" style="width: 100px; height: 100px">
        </div>--%>
        <div class="post-mini-wrapper">
            <div class="post-string">
                <div class="post-name">${post.user_nickname }</div>
                <div class="post-date"><fmt:formatDate value="${post.post_date}" pattern="yyyy-MM-dd"/></div>
            </div>
            <div class="post-items">
                <div class="post-view"><img
                        src="https://cdn-icons-png.flaticon.com/512/7835/7835667.png">${post.post_view }</div>
                <div class="post-like"><img
                        src="https://cdn-icons-png.flaticon.com/512/833/833234.png">${post.post_like }</div>
            </div>
        </div>
    </div>
    <div class="post-content">
        <c:if test="${post.post_image ne null}">
            <div class="post-img">
                <img src="/file/${post.post_image}" style="width: 400px; height: 400px">
            </div>
        </c:if>
        <div class="post-text">${post.post_context}</div>
        <div id="post-${post.post_id}">
            <button class="like-button" data-post-id="${post.post_id}">♡</button>
            <span class="like-count" id="like-count-${post.post_id}">0</span>
        </div>
        <%--<div class="cm-asd-btn">
            <button class="cm-up-btn" style="display: ${asd}" onclick="location.href='CmUpdateC?no=${getPost.cm_no}'">수정</button>
            <button class="cm-del-btn" style="display: ${asd}" onclick="deleteCm('${getPost.cm_no}')">삭제</button>
        </div>--%>
    </div>
    <button onclick="deletePost(${post.post_id})">삭제</button>
    <button onclick="updatePost(${post.post_id})">수정</button>
</div>
</body>
<script type="text/javascript" id="smartEditor">
    var oEditors = [];
    //스마트에디터 프레임 생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "writearea", //<textarea> ID 값 입력.
        sSkinURI: "/resources/nse_files/SmartEditor2Skin.html",
        fCreator: "creatorSEditor2",
        htParams: {
            // toolbar 사용 여부
            bUseToolbar: true,
            // 입력창 크기 조절바 사용 여부
            bUseVericalResizer: true,
            // 모드탭 (Editor|HTML|TEXT)
            bUseModeChanger: true,
            //변경사항이 저장 되지 않을 수 있습니다 경고창 제거
            fOnBeforeUnload: function () {
            }
        }
    });

    document.querySelector(".reg-post").addEventListener("click", function (e) {
        oEditors.getById["writearea"].exec("UPDATE_CONTENTS_FIELD", []);
        console.log(oEditors.getById["writearea"].exec("UPDATE_CONTENTS_FILED", []));
    });
</script>
<script>
    function deletePost(no) {
        if (confirm('정말 삭제하시겠습니까?')) {
            // DELETE 요청으로 데이터를 보냄
            /*fetch('/main/life/' + no, {
                method: 'DELETE',  // HTTP method를 DELETE로 설정
                headers: {
                    'Content-Type': 'application/json',  // JSON 형식으로 데이터 전송
                }
            })
                .then(response => response.json())  // 서버에서 응답을 JSON 형태로 받음
                .then(data => {
                    alert('삭제되었습니다.');
                    location.href = '/main/life';  // 삭제 후 페이지를 리다이렉트
                })
                .catch(error => {
                    console.error('Error:', error);  // 에러 처리
                });*/

            fetch('/main/life/' + no, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
                .then(response => response.json())  // JSON 응답을 받음
                .then(data => {
                    if (data.success) {
                        alert('삭제되었습니다.');
                    } else {
                        alert('로그인이 필요합니다.');
                    }
                    location.href = data.redirectUrl;  // 수동으로 페이지 이동
                })
                .catch(error => {
                    console.error('Error:', error);
                });

        }
    }
</script>
</html>