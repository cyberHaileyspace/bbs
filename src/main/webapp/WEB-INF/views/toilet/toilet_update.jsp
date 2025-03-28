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
                <option value="生活情報">生活情報</option>
                <option value="健康情報">健康情報</option>
                <option value="質問">質問</option>
                <option value="レビュー">レビュー</option>
            </select>
        </div>
        <div>
            <div>地域</div>
            <select name="post_menu">
                <option value="ソウル">ソウル</option>
                <option value="京畿／仁川">京畿／仁川</option>
                <option value="忠正／大田">忠正／大田</option>
                <option value="全羅／光州">全羅／光州</option>
                <option value="慶北／大都">慶北／大都</option>
                <option value="慶南／釜山／蔵山">慶南／釜山／蔵山</option>
                <option value="江原">江原</option>
                <option value="濟州">濟州</option>
            </select>
        </div>
    </div>
    <div>
        <div>タイトル</div>
        <div><textarea name="post_title" rows="5" cols="100" style="resize: none;">${post.post_title}</textarea></div>
    </div>
    <div>
        <div>内容</div>
        <div>
            <textarea name="post_context" id="writearea" value="post_context" rows="25" cols="100">${post.post_context}</textarea>
        </div>
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
        <button class="reg-cancel" type="button" onclick="history.back()">キャンセル</button>
        <button class="reg-post" type="submit" name="post_id" value="${post.post_id}">投稿</button>
    </div>
</form>
</body>
<script type="text/javascript" id="smartEditor">
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "writearea",
        sSkinURI: "/resources/nse_files/SmartEditor2Skin.html",
        fCreator: "creatorSEditor2",
        htParams: {
            bUseToolbar: true,
            bUseVericalResizer: true,
            bUseModeChanger: true,
            fOnBeforeUnload: function () {}
        }
    });

    document.querySelector(".reg-post").addEventListener("click", function (e) {
        oEditors.getById["writearea"].exec("UPDATE_CONTENTS_FIELD", []);
        console.log(oEditors.getById["writearea"].exec("UPDATE_CONTENTS_FILED", []));
        $("#writereg").submit();
    });
</script>
</html>
