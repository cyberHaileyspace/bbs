<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>

</head>
<body>
<div style="display: flex; flex-direction: column; align-items: center">
    <span>가고싶은 지역을 골라보세요</span>
    <input type="text" class="location-input"/>
</div>
<div class="location-wrap">
    <div class="panels place_scroll panel_2depth">
        <!-- 🟢 항상 고정되는 대분류 -->
        <div class="tour_panel selected">
            <ul class="place_items">
                <li class="on">
                    <a href="#place01"><span>제주도</span></a>
                </li>
                <li class="on">
                    <a href="#place02"><span>울릉도</span></a>
                </li>
                <li class="on">
                    <a href="#place03"><span>강원</span></a>
                </li>
                <li class="on">
                    <a href="#place04"><span>경상</span></a>
                </li>
                <li class="on">
                    <a href="#place05"><span>전라</span></a>
                </li>
                <li class="on">
                    <a href="#place06"><span>충청</span></a>
                </li>
                <li class="selected on">
                    <a href="#place07"><span>서울/인천/경기</span></a>
                </li>
            </ul>
        </div>
    </div>

    <!-- 🟡 동적으로 변경되는 하위 지역 -->
    <div class="panels place_scroll">
        <div id="place01" class="sub-panel selected">
            <ul class="place_items">
                <li>
                    <a href="#"><span>제주시</span></a>
                </li>
                <li>
                    <a href="#"><span>서귀포시</span></a>
                </li>
            </ul>
        </div>
    </div>

    <div class="panels place_scroll">
        <div id="place02" class="sub-panel">
            <ul class="place_items">
                <li>
                    <a href="#"><span>울릉군</span></a>
                </li>
            </ul>
        </div>
    </div>
    <div class="panels place_scroll">
        <div id="place03" class="sub-panel">
            <ul class="place_items">
                <li>
                    <a href="#"><span>강원도</span></a>
                </li>
            </ul>
        </div>
    </div>
    <div class="panels place_scroll">
        <div id="place04" class="sub-panel">
            <ul class="place_items">
                <li>
                    <a href="#"><span>경상북도</span></a>
                </li>
                <li>
                    <a href="#"><span>경상남도</span></a>
                </li>
                <li>
                    <a href="#"><span>부산</span></a>
                </li>
            </ul>
        </div>
    </div>
    <div class="panels place_scroll">
        <div id="place05" class="sub-panel">
            <ul class="place_items">
                <li>
                    <a href="#"><span>전라북도</span></a>
                </li>
                <li>
                    <a href="#"><span>전라남도</span></a>
                </li>
            </ul>
        </div>
    </div>
    <div class="panels place_scroll">
        <div id="place06" class="sub-panel">
            <ul class="place_items">
                <li>
                    <a href="#"><span>충청북도</span></a>
                </li>
                <li>
                    <a href="#"><span>충청남도</span></a>
                </li>
            </ul>
        </div>
    </div>
    <div class="panels place_scroll">
        <div id="place07" class="sub-panel">
            <ul class="place_items">
                <li>
                    <a href="#"><span>서울</span></a>
                </li>
                <li>
                    <a href="#"><span>인천</span></a>
                </li>
                <li>
                    <a href="#"><span>경기도</span></a>
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
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<div>
    <div>
        <div class="tour_img_container">
            <div class="tour_img_box"><a><img src="https://www.agoda.com/wp-content/uploads/2024/04/Featured-image-Han-River-at-night-in-Seoul-South-Korea-1244x700.jpg"><div>컨텐츠 정보</div> </a></div>
            <div class="tour_img_box"><a><img src="https://www.agoda.com/wp-content/uploads/2024/04/Featured-image-Han-River-at-night-in-Seoul-South-Korea-1244x700.jpg"><div>컨텐츠 정보</div> </a></div>
            <div class="tour_img_box"><a><img src="https://www.agoda.com/wp-content/uploads/2024/04/Featured-image-Han-River-at-night-in-Seoul-South-Korea-1244x700.jpg"><div>컨텐츠 정보</div> </a></div>
            <div class="tour_img_box"><a><img src="https://www.agoda.com/wp-content/uploads/2024/04/Featured-image-Han-River-at-night-in-Seoul-South-Korea-1244x700.jpg"><div>컨텐츠 정보</div> </a></div>
        </div>
        <br>
        <br>

        <div class="tour_img_container">
            <div class="tour_img_box"><a><img src="https://www.agoda.com/wp-content/uploads/2024/04/Featured-image-Han-River-at-night-in-Seoul-South-Korea-1244x700.jpg"><div>컨텐츠 정보</div> </a></div>
            <div class="tour_img_box"><a><img src="https://www.agoda.com/wp-content/uploads/2024/04/Featured-image-Han-River-at-night-in-Seoul-South-Korea-1244x700.jpg"><div>컨텐츠 정보</div> </a></div>
            <div class="tour_img_box"><a><img src="https://www.agoda.com/wp-content/uploads/2024/04/Featured-image-Han-River-at-night-in-Seoul-South-Korea-1244x700.jpg"><div>컨텐츠 정보</div> </a></div>
            <div class="tour_img_box"><a><img src="https://www.agoda.com/wp-content/uploads/2024/04/Featured-image-Han-River-at-night-in-Seoul-South-Korea-1244x700.jpg"><div>컨텐츠 정보</div> </a></div>
        </div>

    </div>
</div>
</body>

</html>





