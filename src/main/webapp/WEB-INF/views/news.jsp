<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .news-wrap {
            margin: 20px;
            /*border: 2px solid indianred;*/
        }
    </style>
</head>
<body>
<h1>오늘의 일본 해외 인기 뉴스</h1>
<div id="news-container"></div>
<button id="more-btn">More</button>
</body>
<script>
    window.onload = () => {
        getNews();
        panel();
    }

    function getNews() {

        let date = new Date();
        console.log(date);
        let year = date.getFullYear();
        let month = (date.getMonth() + 1).toString().padStart(2, '0'); // 두 자릿수로 변환
        let day = date.getDate() - 7;

        day = day.toString().padStart(2, '0'); // 두 자릿수로 변환

        let formattedDate = year + "-" + month + "-" + day; // 원하는 형식으로 합침
        console.log(formattedDate); // 예: 2025-03-17
        var url = 'https://newsapi.org/v2/everything?' +
            'q=japan&from=' + formattedDate + '&searchIn=title&sortBy=popularity' +
            '&apiKey=cac04d3f1ecc479580de012e82548f93';

        var req = new Request(url);

        fetch(req)
            .then(response => response.json()) // JSON 변환 후 반환
            .then(data => {
                renderNews(data);
                newsData = data;
                loadMore()
            }) // 변환된 JSON 데이터 출력
    }

    let cnt = 10; // 처음에 표시할 개수
    let currentIndex = 0; // 현재까지 로드된 뉴스 개수
    let newsData = null; //

    function renderNews(data) {
        const newsContainer = document.querySelector("#news-container");
        // 새로 추가할 뉴스만 가져오기
        const newArticles = data.articles.slice(currentIndex, currentIndex + cnt);
        console.log(currentIndex+cnt)
        let content = "";
        newArticles.forEach((news, i) => {
            const newsWrap = document.createElement("div");
            newsWrap.classList.add("news-wrap");
            newsWrap.innerHTML =
                "<div class='news-wrap'>" + (currentIndex + i + 1) +
                "<div>" + news.title + "</div>" +
                "<div>" + news.title + "</div>" +
                "<div><a href='" + news.url + "' target='_blank'>visit</a></div>" +
                "</div>";
            newsContainer.appendChild(newsWrap);
        });

        // 현재 인덱스 업데이트
        currentIndex += cnt;
    }

    function loadMore() {
        document.querySelector("#more-btn").addEventListener("click", () => {
            if (newsData) {
                renderNews(newsData); // 🔥 전역 변수 사용하여 데이터 전달
            } else {
                console.error("No data loaded yet!");
            }
        });
    }
</script>
</html>