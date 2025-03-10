<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<div class="tour_info_wrapper">
    <div class="tour_info_container">
        <div class="tour_info_whole_box">
            <h2 style="text-align: center">${result.title}</h2>
            <div class="tour_info_content_box">
                <img src="${result.firstimage}">
                <div>
                    <span>
                        ${result.overview}
                    </span>
                    <div>
                        <p> 주소 : ${result.addr1}</p>
                        <p> 우편번호 : ${result.zipcode}</p>
                    </div>
                </div>
            </div>
            ${result.mapx},${result.mapy}
        </div>
    </div>
    <div></div>
    <div style="text-align: center">리스트로 돌아가기</div>
</div>


</body>
</html>