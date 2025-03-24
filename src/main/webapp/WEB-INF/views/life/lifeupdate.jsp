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
    <link rel="stylesheet" href="/resources/css/board.css">
</head>
<body>
<form id="writereg" action="/main/life/update" method="post" enctype="multipart/form-data">
    <input type="hidden" name="post_id" value="${post.post_id}">  <!-- 여기에 post_id 추가 -->
    <div>
        <div hidden="hidden">
            ニックネーム : <input name="user_nickname" value="${user.user_nickname}" type="text"
                         placeholder="${user.user_nickname}" readonly></div>
        <div>カテゴリー</div>
        <div>
            <select name="post_category">
                <option value="생활 정보">生活情報</option>
                <option value="건강 정보">健康情報</option>
                <option value="질문">質問</option>
                <option value="후기">レビュー</option>
            </select>
        </div>
        <div>
            <div>地域</div>
            <select name="post_menu">
                <option value="서울">ソウル</option>
                <option value="경기/인천">京畿／仁川</option>
                <option value="충청/대전">忠清／大田</option>
                <option value="전라/광주">全羅／光州</option>
                <option value="경북/대구">慶北／大邱</option>
                <option value="경남/부산/울산">慶南／釜山／蔚山</option>
                <option value="강원">江原</option>
                <option value="제주">済州</option>
            </select>
        </div>
    </div>

    <div>
        <div>タイトル</div>
        <div><textarea name="post_title" rows="5" cols="100" style="resize: none;">${post.post_title}
        </textarea>
        </div>
    </div>

    <div>
        <div>内容</div>
        <div>
            <textarea name="post_context" id="writearea" value="post_context" rows="25" cols="100">${post.post_context}
            </textarea>
        </div>
    </div>
    <div>

        <div>
            <input type='file' name="post_file" id='btnAtt' value="${post.post_image}">
        </div>
    </div>
    <div>
        <button class="reg-cancel" type="button" onclick="history.back()">キャンセル</button>
        <button class="reg-post" type="submit" name="post_id" value="${post.post_id}">登録</button>
    </div>
</form>
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
        $("#writereg").submit();
    });

</script>
</html>