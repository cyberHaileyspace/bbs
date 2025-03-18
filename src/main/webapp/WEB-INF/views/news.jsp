<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .news-wrap{
            margin: 20px;
            border: 2px solid indianred;
        }
    </style>
</head>
<body>
<h1>News data --</h1>
 <div id="news-container"></div>
    <button id="more-btn">More</button>
</body>
<script>
window.onload = () =>{
   getNews();
}

    function getNews() {


        let date = new Date();
        console.log(date);

        let year = date.getFullYear();
        let month = (date.getMonth() + 1).toString().padStart(2, '0'); // 두 자릿수로 변환
        let day = date.getDate() - 7;

        day = day.toString().padStart(2, '0'); // 두 자릿수로 변환

        let formattedDate = year + "-" + month + "-" + day; // 원하는 형식으로 합침
        console.log(formattedDate); // 예: 2025-03-16
        var url = 'https://newsapi.org/v2/everything?' +
            'q=japan&from=' + formattedDate + '&searchIn=title&sortBy=popularity' +
            '&apiKey=cac04d3f1ecc479580de012e82548f93';

        var req = new Request(url);

        fetch(req)
            .then(response => response.json()) // JSON 변환 후 반환
            .then(data => {
                console.log(data)
                renderNews(data);
            }) // 변환된 JSON 데이터 출력
    }
let cnt = 5;
    function renderNews(data) {
        const newsContainer = document.querySelector("#news-container");
        let content = "";
        data.articles.forEach(function(news, i) {
            if (i <= cnt){
            content +=
                "<div class='news-wrap'>" +
                "<div>" + news.title + "</div>" +
                "<div><a href="+news.url+">visit</a></div>" +
                "</div>";
            }
        });
        newsContainer.innerHTML = content;
    }

    function loadMore() {
    }
</script>
</html>