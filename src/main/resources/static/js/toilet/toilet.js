function deletePost(no) {
    if (confirm('本当に削除しますか？')) {
        fetch('/main/toilet/' + no, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        })
            .then(response => response.json())  // JSON 응답을 받음
            .then(data => {
                if (data.success) {
                    alert('削除されました.');
                    location.href = '/main/toilet';
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
    location.href = "toilet/" + postId + "?token=" + token;
}

/* -------------------- 조회수 증가 로직 -------------------- */

function logincheck(user) {
    if (user)
        location.href = "toilet/reg";
    else {
        alert("先にログインしてください。");
        location.href = "/login"
    }
}

/* -------------------- 로그인 체크 -------------------- */

async function loadData(title) {

    try {
        let data = await $.ajax({
            url: "/main/toilet/all",
            data: {title}
        });
        return data;
    } catch (error) {
        console.error("データロード失敗:", error);
        return [];  // ❗ 오류 발생 시 빈 배열 반환
    }
}

/* -------------------- 뉴스 -------------------- */

function paging(data) {
    console.log("paging 실행됨, 데이터 개수:", data.length);

    // 기존 페이지네이션 및 게시글 목록 초기화
    $("#pagination-container").empty();
    $("#post-container").empty();

    const itemsPerPage = 6; // 한 페이지당 게시글 수
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
    let postHtml = '<div class="toilet-grid">';

    posts.forEach(p => {
        const formattedDate = new Date(p.post_date).toISOString().split('T')[0];
        const postData = encodeURIComponent(JSON.stringify(p));  // 안전하게 인코딩

        postHtml += `
        <div class="toilet-item">
            <div class="toilet-card" data-post='${postData}'>
                <div class="toilet-meta">
                    <div class="toilet-id">掲示番号：${p.post_id}</div>
                    <div class="toilet-category">カテゴリ：${p.post_category}</div>
                    <div class="toilet-region">地域：${p.post_menu}</div>
                </div>
                <div class="toilet-title">${p.post_title}</div>
                <div class="toilet-body">
                    <div class="toilet-text"><span>${p.post_context}</span></div>
                    <div class="toilet-image">
                        ${p.post_image ? `<img src='img/post/${p.post_image}' alt=''>` : ""}
                    </div>
                </div>
                <div class="toilet-info">
                    <div class="toilet-writer">投稿者：${p.user_nickname}</div>
                    <div class="toilet-date">作成日：${formattedDate}</div>
                    <div class="toilet-stats">
                        閲覧数：${p.post_view} ／ いいね：${p.post_like} ／ コメント：${p.reply_count}
                    </div>
                </div>
            </div>
        </div>`;
    });

    postHtml += '</div>';
    return postHtml;
}

document.addEventListener("click", function (e) {
    const card = e.target.closest(".toilet-card");
    console.log("카드 요소:", card); // ✅ 디버깅용

    if (card && card.dataset.post) {
        try {
            const postData = JSON.parse(decodeURIComponent(card.dataset.post));
            openToiletModal(postData);
        } catch (err) {
            console.error("모달 데이터 파싱 실패:", err);
        }
    }
});



function openToiletModal(p) {
    const formattedDate = new Date(p.post_date).toISOString().split('T')[0];

    const modalHtml = `
        <div class="toilet-modal-overlay" onclick="closeToiletModal()"></div>
        <div class="toilet-modal">
            <h2>${p.post_title}</h2>
            <p class="toilet-modal-meta">${p.user_nickname} ・ ${formattedDate}</p>
            <div class="toilet-modal-content">${p.post_context}</div>
            <div class="toilet-modal-actions">
                <button onclick="toggleLike(${p.post_id}, this)">❤️ いいね：${p.post_like}</button>
                <button onclick="goToPost(${p.post_id})">▶ 詳しく見る</button>
            </div>
        </div>
    `;
    document.body.insertAdjacentHTML("beforeend", modalHtml);
}


function closeToiletModal() {
    document.querySelector(".toilet-modal")?.remove();
    document.querySelector(".toilet-modal-overlay")?.remove();
}



function optionHandler() {
    $("input[name='option']").change(function () {
        let option = $("input[name='option']:checked").val();
        console.log("선택된 정렬 옵션:", option);

        $.ajax({
            url: 'toilet/option',
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
            url: 'toilet/category',
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