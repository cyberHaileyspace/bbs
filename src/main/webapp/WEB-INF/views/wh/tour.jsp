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
<div style="width: 100%">
    <div class="travel">
        <div>관광게시판</div>
        <div>관광정보</div>
    </div>
    <div style="display: flex; flex-direction: column; align-items: center; width: 300px; height: 70px; background-color: #dce1ff; margin: 0 auto; padding: 20px 0; border-radius: 20px">
        <h3 style="width: 240px; height: 50px; text-align: center; display: flex; align-items: center; justify-content: center; border-radius: 15px; margin: 0">
            가고싶은 지역을 골라보세요</h3>
        <input type="text" class="location-input" style="width: 230px; border-radius: 5px; border: none" placeholder="여길 누르면 지역선택창이 뜹니다."/>
    </div>
    <!-- 대분류/소분류 영역 (이전 코드와 동일) -->
    <div class="location-wrap">
        <div class="panels place_scroll panel_2depth">
            <div class="tour_panel selected">
                <ul class="place_items">
                    <li class="selected on"><a href="#place07"><span>서울/인천/경기</span></a></li>
                    <li class="on"><a href="#place03"><span>강원</span></a></li>
                    <li class="on"><a href="#place06"><span>충청</span></a></li>
                    <li class="on"><a href="#place05"><span>전라</span></a></li>
                    <li class="on"><a href="#place04"><span>경상</span></a></li>
                    <li class="on"><a href="#place02" class="search-area" data-areaCode="6"><span>부산</span></a></li>
                    <li class="on"><a href="#place02" class="search-area" data-areaCode="4"><span>대구</span></a></li>
                    <li class="on"><a href="#place01"><span>제주도</span></a></li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place01" class="sub-panel selected">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="39" class="search-area" data-sigungu="4"><span>제주시</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="39" class="search-area" data-sigungu="3"><span>서귀포시</span></a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="panels place_scroll state">
            <div id="place03" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="32" class="search-area"><span>강원도</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place04" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="35" class="search-area"><span>경상북도</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="36" class="search-area"><span>경상남도</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place05" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="37" class="search-area"><span>전라북도</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="38" class="search-area"><span>전라남도</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place06" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="33" class="search-area"><span>충청북도</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="34" class="search-area"><span>충청남도</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="panels place_scroll state">
            <div id="place07" class="sub-panel">
                <ul class="place_items">
                    <li>
                        <a href="#" data-areaCode="1" class="search-area"><span>서울</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="2" class="search-area"><span>인천</span></a>
                    </li>
                    <li>
                        <a href="#" data-areaCode="31" class="search-area"><span>경기도</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div
                class="close-btn"
                style="position: absolute; bottom: 10px; right: 15px"
        >
            close
        </div>
    </div>

    <!-- 관광정보 표시 영역 -->
    <div class="tour_img_container" id="tourContainer">
        <div id="extraInfo">
            <span class="extraList" style="margin-right: auto">관광지 목록</span>
            <span style="margin: 0 15px" class="sort" data-sort="O" data-area-code="${param.areaCode}"
                  data-sigungu="${param.sigungu}">제목순</span>
            <span>|</span>
            <span style="margin: 0 15px" class="sort" data-sort="R" data-area-code="${param.areaCode}"
                  data-sigungu="${param.sigungu}">최신순</span>
        </div>
        <div class="tour_img_container">
            <c:forEach var="i" items="${result}">
                <div class="tour_img_box" data-img-url="${i.firstimage}">
                    <a href="/main/tour/getLoc?contentid=${i.contentid}">
                        <div>${i.title}</div>
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
            form.action = "/main/tour/loc";

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
