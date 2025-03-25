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
    <link rel="stylesheet" href="/resources/css/sample.css">
</head>
<body>
<form id="freeReg" action="/main/free" method="post" enctype="multipart/form-data">
    <div>
        <div hidden="hidden">닉네임 : <input name="user_nickname" value="${user.user_nickname}" type="text"
                                          placeholder="${user.user_nickname}" readonly></div>
        <div>カテゴリー</div>
        <div>
            <%--<input type="radio" name="post_category" &lt;%&ndash;id="life-tip"&ndash;%&gt; value="life-tip">&lt;%&ndash;<label for="life-tip">&ndash;%&gt;생활
            정보</label>
            <input type="radio" name="post_category" &lt;%&ndash;id="life-health"&ndash;%&gt; value="life-health">&lt;%&ndash;<label for="life-health">&ndash;%&gt;건강
            정보</label>
            <input type="radio" name="post_category" &lt;%&ndash;id="life-qna"&ndash;%&gt; value="life-qna">&lt;%&ndash;<label for="life-qna">&ndash;%&gt;질문</label>
            <input type="radio" name="post_category" &lt;%&ndash;id="life-aft"&ndash;%&gt; value="life-aft">&lt;%&ndash;<label for="life-aft">&ndash;%&gt;후기</label>--%>
            <select name="post_category">
                <option value="生活情報">生活情報</option>
                <option value="健康情報">健康情報</option>
                <option value="質問">質問</option>
                <option value="レビュー">レビュー</option>
            </select>
        </div>
        <div>
            <div>지역</div>
            <%--<div class="add-size">
                <input type="radio" name="post_menu" &lt;%&ndash;id="life-tip"&ndash;%&gt; value="life-tip">&lt;%&ndash;<label for="life-tip">&ndash;%&gt;생활
                정보</label>
                <input type="radio" name="post_menu" &lt;%&ndash;id="life-health"&ndash;%&gt; value="life-health">&lt;%&ndash;<label for="life-health">&ndash;%&gt;건강
                정보</label>
                <input type="radio" name="post_menu" &lt;%&ndash;id="life-qna"&ndash;%&gt; value="life-qna">&lt;%&ndash;<label for="life-qna">&ndash;%&gt;질문</label>
            </div>--%>
            <select name="post_menu">
                <option value="ソウル">ソウル</option>
                <option value="京畿／仁川">京畿／仁川</option>
                <option value="忠清／大田">忠清／大田</option>
                <option value="全羅／光州">全羅／光州</option>
                <option value="慶北／大邱">慶北／大邱</option>
                <option value="慶南／釜山／蔚山">慶南／釜山／蔚山</option>
                <option value="江原">江原</option>
                <option value="済州">済州</option>
            </select>
        </div>
    </div>

    <div>
        <div>タイトル</div>
        <div><textarea name="post_title" rows="5" cols="100" placeholder="タイトルを入力してください。" style="resize: none;"></textarea>
        </div>
    </div>

    <div>
        <div>내용</div>
        <div>
            <textarea name="post_context" id="writearea" value="post_context" rows="25" cols="100"
                      placeholder="内容を入力してください。"></textarea>
        </div>
    </div>
    <div>

        <div>
            <input type='file' name="post_file" id='btnAtt'>
        </div>

    </div>
    <div>
        <button class="reg-cancel" type="button" onclick="history.back()">キャンセル</button>
        <button class="reg-post" type="submit">投稿</button>
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