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
<form id="writereg" action="writereg" method="post" enctype="multipart/form-data">
    <div>
        <div hidden="hidden">닉네임 : <input name="user_nickname" value="${user.user_nickname}" type="text"
                                          placeholder="${user.user_nickname}" readonly></div>
        <div>카테고리</div>
        <div>
            <input type="radio" name="post_category" <%--id="life-tip"--%> value="life-tip"><%--<label for="life-tip">--%>생활
            정보</label>
            <input type="radio" name="post_category" <%--id="life-health"--%> value="life-health"><%--<label for="life-health">--%>건강
            정보</label>
            <input type="radio" name="post_category" <%--id="life-qna"--%> value="life-qna"><%--<label for="life-qna">--%>질문</label>
            <input type="radio" name="post_category" <%--id="life-aft"--%> value="life-aft"><%--<label for="life-aft">--%>후기</label>
        </div>
        <div>
            <div>지역</div>
            <div class="add-size">
                <input type="radio" name="post_menu" <%--id="life-tip"--%> value="life-tip"><%--<label for="life-tip">--%>생활
                정보</label>
                <input type="radio" name="post_menu" <%--id="life-health"--%> value="life-health"><%--<label for="life-health">--%>건강
                정보</label>
                <input type="radio" name="post_menu" <%--id="life-qna"--%> value="life-qna"><%--<label for="life-qna">--%>질문</label>
            </div>
        </div>
    </div>

    <div>
        <div>제목</div>
        <div><textarea name="post_title" rows="5" cols="100" placeholder="제목을 입력하세요." style="resize: none;"></textarea>
        </div>
    </div>

    <div>
        <div>내용</div>
        <div>
            <textarea name="post_context" id="writearea" value="post_context" rows="25" cols="100"
                      placeholder="내용을 입력하세요"></textarea>
        </div>
    </div>
    <div>

        <div>
            <input type='file' name="post_file" id='btnAtt'>
        </div>

    </div>
    <div>
        <button class="reg-cancel" type="button" onclick="history.back()">취소</button>
        <button class="reg-post" type="submit">등록</button>
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