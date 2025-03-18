
function generateToken() {
    const now = new Date();
    return now.getMinutes() + ":" + now.getSeconds();  // "mm:ss" 형식
}

function goToPost(postId) {
    const token = generateToken();
    sessionStorage.setItem("viewToken", token);
    location.href = "life/" + postId + "?token=" + token;
}

function logincheck(user) {
    if (user)
        location.href = "life/reg";
    else {
        alert("먼저 로그인을 해주세요.");
        location.href = "/login"
    }
}

async function loadData() {
    try {
        let data = await $.ajax({
            url: "/main/life/all"
        });
        return data;
    } catch (error) {
        console.error("데이터 로드 실패:", error);
        return [];  // ❗ 오류 발생 시 빈 배열 반환
    }
}

function paging(data) {
    console.log("paging 실행됨, 데이터 개수:", data.length);

    // 기존 페이지네이션 및 게시글 목록 초기화
    $("#pagination-container").empty();
    $("#post-container").empty();

    const itemsPerPage = 5; // 한 페이지당 게시글 수
    const totalItems = data.length;

    if (totalItems === 0) {
        console.log("게시글 없음. 페이지네이션 숨김.");
        $("#post-container").html("<p>게시글이 없습니다.</p>");  // 게시글 없음 메시지 표시
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
    $("#post-container").empty();  // 기존 게시글 제거
    let postHtml = "";
    posts.forEach(p => {
        postHtml +=
            "<div class='item'>" +
            "<div class='post-life' onclick='goToPost(" + p.post_id + ")'>" +
            "<div class='life-kind'>" +
            "<div class='life-no'>번호: " + p.post_id + "</div>&nbsp;/&nbsp;" +
            "<div class='life-cate'>카테고리: " + p.post_category + "</div>&nbsp;/&nbsp;" +
            "<div class='life-menu'>지역: " + p.post_menu + "</div>" +
            "</div>" +
            "<div class='life-title'>" + p.post_title + "</div>" +
            "<div class='life-context'>" +
            "<div class='life-text'><span>" + p.post_context + "</span></div>" +
            "<div class='life-image'><img alt='' src='img/post/" + p.post_image + "'></div>" +
            "</div>" +
            "<div class='life-info'>" +
            "<div style='display: flex'>" +
            "<div class='info-name'>작성자: " + p.user_nickname + "</div>&nbsp;/&nbsp;" +
            "<div class='info-date'>작성일: " + p.post_date + "</div>" +
            "</div>" +
            "<div style='display: flex'>" +
            "<div class='info-view'>조회수: " + p.post_view + "</div>&nbsp;/&nbsp;" +
            "<div class='info-like'>추천수: " + p.post_like + "</div>" +
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
            url: 'life/option',
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
            url: 'life/category',
            type: 'GET',
            data: {category: category},
            async: true,
        })
            .done(function (resData) {
                console.log("응답 데이터:", resData);
                if (resData.length !== 0) {
                    paging(resData);
                } else {
                    $("#post-container").text("게시글이 없습니다.");
                }
            })
            .fail(function (xhr) {
                console.error("요청 실패:", xhr);
            });
    });
}

$(document).ready(async function () {

    let data = await loadData();
    categoryHandler();
    optionHandler();
    paging(data);
});
