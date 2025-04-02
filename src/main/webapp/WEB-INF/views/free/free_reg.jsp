<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib
        uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Title</title>
    <script
            type="text/javascript"
            src="/resources/nse_files/js/HuskyEZCreator.js"
            charset="utf-8"
    ></script>
    <link rel="stylesheet" href="/resources/css/sample.css"/>
</head>
<body>

<form
        id="freeReg"
        action="/main/free"
        method="post"
        enctype="multipart/form-data"
>
    <div class="reg_dom">
        <div>
            <div hidden="hidden">
                닉네임 :
                <input
                        name="user_nickname"
                        value="${user.user_nickname}"
                        type="text"
                        placeholder="${user.user_nickname}"
                        readonly
                />
            </div>
            <div>カテゴリー</div>
            <div>
                <%--<input
                  type="radio"
                  name="post_category"
                  &lt;%&ndash;id="life-tip"
                  &ndash;%&gt;
                  value="life-tip"
                />&lt;%&ndash;<label for="life-tip">&ndash;%&gt;생활 정보</label>
                <input
                  type="radio"
                  name="post_category"
                  &lt;%&ndash;id="life-health"
                  &ndash;%&gt;
                  value="life-health"
                />&lt;%&ndash;<label for="life-health">&ndash;%&gt;건강 정보</label>
                <input
                  type="radio"
                  name="post_category"
                  &lt;%&ndash;id="life-qna"
                  &ndash;%&gt;
                  value="life-qna"
                />&lt;%&ndash;<label for="life-qna">&ndash;%&gt;질문</label>
                <input
                  type="radio"
                  name="post_category"
                  &lt;%&ndash;id="life-aft"
                  &ndash;%&gt;
                  value="life-aft"
                />&lt;%&ndash;<label for="life-aft">&ndash;%&gt;후기</label>--%>
                <select name="post_category">
                    <option value="all">すべて</option>
                    <option value="hobby">趣味</option>
                    <option value="love">恋バナ</option>
                    <option value="talk">雑談</option>
                </select>
            </div>
            <div>
                <div>地域</div>
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

        <div>
            <div>内容</div>
            <div>
          <textarea
                  name="post_context"
                  id="writearea"
                  value="post_context"
                  rows="25"
                  cols="100"
                  placeholder="内容を入力してください。"
          ></textarea>
            </div>
        </div>
        <div class="reg_form">
            <div>
                <div>
                    <!-- 숨겨진 파일 선택 input -->
                    <input type="file" name="post_file" id="btnAtt" style="display: none;">

                    <!-- label을 버튼처럼 사용 -->
                    <label for="btnAtt" class="custom-file-label">
                        ファイルを添付
                    </label>

                    <!-- 선택한 파일명 표시 -->
                    <span id="fileName">ファイルなし</span>
                </div>
                <script>
                    document.getElementById('btnAtt').addEventListener('change', function () {
                        const fileName = this.files[0]?.name || "ファイルなし";
                        document.getElementById('fileName').innerText = fileName;
                    });
                </script>
            </div>
            <div class="reg_button">
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
