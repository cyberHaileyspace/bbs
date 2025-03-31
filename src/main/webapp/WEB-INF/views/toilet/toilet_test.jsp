<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Geolocation Test</title>
</head>
<body>
<h1>내 위치 테스트</h1>
<button onclick="getLocation()">위치 확인</button>
<p id="result"></p>

<script>
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(pos) {
                document.getElementById("result").innerText =
                    "위도: " + pos.coords.latitude + ", 경도: " + pos.coords.longitude;
            }, function(error) {
                document.getElementById("result").innerText =
                    "오류 발생: " + error.message;
            });
        } else {
            document.getElementById("result").innerText = "이 브라우저는 위치 정보를 지원하지 않음";
        }
    }
</script>
</body>
</html>
