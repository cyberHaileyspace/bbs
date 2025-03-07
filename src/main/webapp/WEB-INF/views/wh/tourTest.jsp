<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>Tour Page</title>
    <style>
        .location-wrap.show {
            display: flex;
        }

        .tour_img_container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .tour_img_box {
            width: 200px;
            position: relative;
        }

        .tour_img_box img {
            width: 100%;
            height: auto;
            display: block;
        }

        .tour_img_box div {
            background-color: rgba(0, 0, 0, 0.5);
            color: #fff;
            position: absolute;
            bottom: 0;
            width: 100%;
            text-align: center;
            padding: 5px 0;
        }
    </style>
</head>
<body>
<div style="display: flex; flex-direction: column; align-items: center">
    <span>가고싶은 지역을 골라보세요</span>
    <input type="text" class="location-input"/>
</div>
<!-- 대분류/소분류 영역 (이전 코드와 동일) -->
<div class="location-wrap">
    <div class="panels place_scroll panel_2depth">
        <div class="tour_panel selected">
            <ul class="place_items">
                <li class="on"><a href="#place01"><span>제주도</span></a></li>
                <li class="on"><a href="#place02" class="search-area" data-areaCode="6"><span>부산</span></a></li>
                <li class="on"><a href="#place02" class="search-area" data-areaCode="4"><span>대구</span></a></li>
                <li class="on"><a href="#place03"><span>강원</span></a></li>
                <li class="on"><a href="#place04"><span>경상</span></a></li>
                <li class="on"><a href="#place05"><span>전라</span></a></li>
                <li class="on"><a href="#place06"><span>충청</span></a></li>
                <li class="selected on"><a href="#place07"><span>서울/인천/경기</span></a></li>
            </ul>
        </div>
    </div>
    <div class="panels place_scroll">
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

    <div class="panels place_scroll">
        <div id="place03" class="sub-panel">
            <ul class="place_items">
                <li>
                    <a href="#" data-areaCode="32" class="search-area"><span>강원도</span></a>
                </li>
            </ul>
        </div>
    </div>
    <div class="panels place_scroll">
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
    <div class="panels place_scroll">
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
    <div class="panels place_scroll">
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
    <div class="panels place_scroll">
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
    <div class="tour_img_container">
    <c:forEach var="i" items="${result}">
        <div class="tour_img_box"><a><img src="${i.firstimage}"><div>${i.title}</div> </a></div>
    </c:forEach>



    </div>

</div>

</body>
<script>
    document.querySelectorAll(".search-area").forEach((atag) => {
        atag.addEventListener("click", (e) => {
            const areaCode = e.target.parentElement.dataset.areacode;
            const sigungu = e.target.parentElement.dataset.sigungu;
            console.log(areaCode);
            console.log(sigungu);


            const form = document.createElement("form");
            form.method = "post";
            form.action = "/tour/loc"; // 실제 엔드포인트 URL로 변경

// areaCode를 담을 hidden input 생성
            const areaCodeInput = document.createElement("input");
            areaCodeInput.type = "hidden";
            areaCodeInput.name = "areaCode";
            areaCodeInput.value = areaCode;
            form.appendChild(areaCodeInput);

// sigungu를 담을 hidden input 생성

            const sigunguInput = document.createElement("input");
            sigunguInput.type = "hidden";
            sigunguInput.name = "sigungu";
            if (sigungu != null){
            sigunguInput.value = sigungu;
            }
            form.appendChild(sigunguInput);

// form을 문서 body에 추가 (필요 시 다른 곳에 추가해도 됨)
            document.body.appendChild(form);
            form.submit();
        });
    })


</script>
</html>
