function deletePost(no) {
    if (confirm('本当に削除しますか？')) {
        fetch('/main/free/' + no, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        })
            .then(response => response.json())  // JSON 응답을 받음
            .then(data => {
                if (data.success) {
                    alert('削除されました.');
                    location.href = '/main/free';
                } else {
                    alert('로그인이 필요합니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
}

function generateToken() {
    const now = new Date();
    return now.getMinutes() + ":" + now.getSeconds();  // "mm:ss" 형식
}

function goToPost(postId) {
    const token = generateToken();
    sessionStorage.setItem("viewToken", token);
    location.href = "free/" + postId + "?token=" + token;
}

/* -------------------- 조회수 증가 로직 -------------------- */

function logincheck(user) {
    if (user)
        location.href = "free/reg";
    else {
        alert("先にログインしてください。");
        location.href = "/login"
    }
}

/* -------------------- 로그인 체크 -------------------- */

async function loadData(title) {

    try {
        let data = await $.ajax({
            url: "/main/free/all",
            data: {title}
        });
        return data;
    } catch (error) {
        console.error("데이터 로드 실패:", error);
        return [];  // ❗ 오류 발생 시 빈 배열 반환
    }
}

/* -------------------- 뉴스 -------------------- */

function paging(data) {
    console.log("paging 실행됨, 데이터 개수:", data.length);

    // 기존 페이지네이션 및 게시글 목록 초기화
    $("#pagination-container").empty();
    $("#post-container").empty();

    const itemsPerPage = 5; // 한 페이지당 게시글 수
    const totalItems = data.length;

    if (totalItems === 0) {
        console.log("게시글 없음. 페이지네이션 숨김.");
        $("#post-container").html("<p>まだ投稿がありません。</p>");  // 게시글 없음 메시지 표시
        return;  // ⛔ 데이터가 없으면 페이지네이션 생성 X
    }

    if (totalItems > itemsPerPage) {
        // 페이지네이션 설정
        $('#pagination-container').pagination({
            dataSource: data,
            pageSize: itemsPerPage,
            showPageNumbers: true,
            showNavigator: true,
            callback: function (data, pagination) {
                let postHtml = renderPosts(data);
                $("#post-container").html(postHtml)
            }
        });
    } else {
        let postHtml = renderPosts(data);
        $("#post-container").html(postHtml)
    }
}

function renderPosts(posts) {

    $("#post-container").empty(); // 기존 게시글 제거
    let postHtml = "";

    posts.forEach(p => {
        const formattedDate = new Date(p.post_date).toISOString().split('T')[0];
        console.log(posts);
        postHtml +=
            "<div class='item'>" +
            "<div class='post-life' onclick='goToPost(" + p.post_id + ")'>" +
            "<div class='life-kind'>" + "<div class='life_northWest'>" +
            "<div class='life-no'>番号 : " + p.post_id + "</div>" +

            "</div>" +
            "<div class='lift_northEast'>" +
            "<div class='info-name'>投稿者 : " + p.user_nickname + "</div>" +
            "<div class='info-date'>投稿日 : " + formattedDate + "</div>" +
            "</div>" +
            "</div>" +
            "<div class='life-title'>" + p.post_title + "</div>" +

            "<div class='life-info'>" +
            "<div class='life_southWest'>" +
            "<div class='life-cate'>カテゴリー : " + p.post_category + "</div>" +
            "<div class='life-menu'>地域 : " + p.post_menu + "</div>" +
            "</div>" +

            "<div class='life_southEast'>" +
            "<div class='info-view'>閲覧数 : " + p.post_view + "</div>" +
            "<div class='info-like'>いいね数 : " + p.post_like + "</div>" +
            "<div class='info-reply'>コメント数 : " + p.reply_count + "</div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "</div>";
    });
    console.log("새로운 데이터 추가 완료");
    return postHtml;

}

function optionHandler() {
    $("input[name='option']").change(function () {
        let option = $("input[name='option']:checked").val();
        console.log("선택된 정렬 옵션:", option);

        $.ajax({
            url: 'free/option',
            type: 'GET',
            data: {option: option},
            async: true,
        })
            .done(function (resData) {
                console.log("응답 데이터:", resData);
                if (resData.length !== 0) {
                    paging(resData);
                }
            })
            .fail(function (xhr) {
                console.error("요청 실패:", xhr);
            });
    });
}

function categoryHandler() {
    $(".menu").click(function () {
        let category = $(this).data("val");  // 클릭된 span 태그에서 data-val 값을 가져옴
        console.log("선택된 카테고리:", category);

        // Ajax 요청 보내기
        $.ajax({
            url: 'free' +
                '/category',
            type: 'GET',
            data: {category: category},
            async: true,
        })
            .done(function (resData) {
                console.log("응답 데이터:", resData);
                if (resData.length !== 0) {
                    paging(resData);
                } else {
                    $("#post-container").text("投稿がありません。");
                }
            })
            .fail(function (xhr) {
                console.error("요청 실패:", xhr);
            });
    });
}

$(document).ready(async function () {

    let data = await loadData("");
    categoryHandler();
    optionHandler();
    paging(data);
    searchHandler();
});

/* -------------------- 페이징 -------------------- */

function searchHandler() {
    const searchBtn = document.querySelector("#search-btn");
    const searchInput = document.querySelector("#search-input");

    searchBtn.addEventListener("click", async () => {
        console.log(searchInput.value);
        let data = await loadData(searchInput.value);
        console.log(data)
        paging(data);

        searchInput.focus();
    });

    searchInput.addEventListener("keydown", (e) => {
        if (e.key === "Enter") {
            searchBtn.click();
        }
    })
}

/* -------------------- 검색 -------------------- */
