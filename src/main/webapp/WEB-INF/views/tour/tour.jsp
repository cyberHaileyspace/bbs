<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Tour Page</title>
</head>
<body>
<div class="info_wrap" style="width: 100%">
    <div class="travel">
        <div onclick="location.href='/main/tour'">観光掲示板</div>
        <div>観光情報</div>
    </div>
    <div style="display: flex; flex-direction: column; align-items: center; width: 350px; height: 70px; background-color: #dce1ff; margin: 0 auto; padding: 20px 0; border-radius: 20px">
        <h3 style="width: 80%; height: 50px; text-align: center; display: flex; align-items: center; justify-content: center; border-radius: 15px; margin: 0">
            行きたい地域を選んでください</h3>
        <input type="text" class="location-input" style="width: 75%; border-radius: 5px; border: none" placeholder="クリックすると地域選択が表示されます。"/>
    </div>
    <!-- 대분류/소분류 영역 (이전 코드와 동일) -->
    <div class="location-wrap">
        <div class="panels place_scroll panel_2depth">
            <div class="tour_panel selected">
                <ul class="place_items">
                    <li class="selected on"><a href="#place07"><span>ソウル/仁川/京畿</span></a></li>
                    <li class="on"><a href="#place03"><span>江原</span></a></li>
                    <li class="on"><a href="#place06"><span>忠清</span></a></li>
                    <li class="on"><a href="#place05"><span>全羅</span></a></li>
                    <li class="on"><a href="#place04"><span>慶尚</span></a></li>
                    <li class="on"><a href="#place02" class="search-area" data-areaCode="6"><span>蔚山</span></a></li>
                    <li class="on"><a href="#place02" class="search-area" data-areaCode="4"><span>大邱</span></a></li>
                    <li class="on"><a href="#place01"><span>済州</span></a></li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place01" class="sub-panel selected">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="39" class="search-area" data-sigungu="4"><span>済州市</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="39" class="search-area" data-sigungu="3"><span>西帰浦市</span></a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="panels place_scroll state">
            <div id="place03" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="32" class="search-area"><span>江原道</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place04" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="35" class="search-area"><span>慶尚北道</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="36" class="search-area"><span>慶尚南道</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place05" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="37" class="search-area"><span>全羅北道</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="38" class="search-area"><span>全羅南道</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place06" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="33" class="search-area"><span>忠清北道</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="34" class="search-area"><span>忠清南道</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place07" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="1" class="search-area"><span>ソウル</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="2" class="search-area"><span>仁川</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="31" class="search-area"><span>京畿道</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="close-btn">
            閉じる
        </div>
    </div>

    <!-- 관광정보 표시 영역 -->
    <div class="tour_img_container" id="tourContainer">
        <div id="extraInfo">
            <span class="extraList" style="margin-right: auto">観光地リスト</span>
            <span style="margin: 0 15px; cursor: pointer" class="sort" data-sort="O" data-area-code="${param.areaCode}"
                  data-sigungu="${param.sigungu}">タイトル順</span>
            <span>|</span>
            <span style="margin: 0 15px; cursor: pointer" class="sort" data-sort="R" data-area-code="${param.areaCode}"
                  data-sigungu="${param.sigungu}">最新順</span>
        </div>
        <div class="tour_img_container">
            <c:forEach var="i" items="${result}">
                <div class="tour_img_box" data-img-url="${i.firstimage}">
                    <a href="/main/tourInfo/getLoc?contentid=${i.contentid}">
                        <div class="jp-title" data-title="${i.title}">${i.title}</div>
                    </a>
                </div>
            </c:forEach>
        </div>
        <div class="pagination">
        </div>
    </div>


</div>
<script>
    document.querySelectorAll(".sort").forEach((sort) => {
        sort.addEventListener("click", (e) => {
            // 기존 시군구, 지역코드, 솔팅
            const params = e.target.dataset;

            const form = document.createElement("form");
            form.method = "get";
            form.action = "/main/tourInfo/loc";

            const inputAreaCode = document.createElement("input");
            inputAreaCode.type = "hidden";
            inputAreaCode.name = "areaCode";
            inputAreaCode.value = params.areaCode;
            form.appendChild(inputAreaCode);

            const inputSigungu = document.createElement("input");
            inputSigungu.type = "hidden";
            inputSigungu.name = "sigungu";
            inputSigungu.value = params.sigungu;
            form.appendChild(inputSigungu);

            const inputSort = document.createElement("input");
            inputSort.type = "hidden";
            inputSort.name = "sort";
            inputSort.value = params.sort;
            form.appendChild(inputSort);

            document.body.appendChild(form);
            form.submit();
        })
    })

</script>
<script src="/resources/js/tour.js"></script>
</body>
</html>
