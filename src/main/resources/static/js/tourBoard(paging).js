$(document).ready(async function () {
    let data = await loadTourPosts();  // 게시글 불러오기
    setupPagination(data);
});

/** 게시글 목록 불러오기 (전체 조회) */
async function loadTourPosts() {
    try {
        let data = await $.ajax({
            url: "/main/tour/all",  // 이 URL에 맞는 컨트롤러 추가 필요
            method: "GET"
        });
        return data;
    } catch (err) {
        console.error("게시글 로딩 실패:", err);
        return [];
    }
}

/** 페이징 처리 함수 */
function setupPagination(data) {
    $("#pagination-container").pagination({
        dataSource: data,
        pageSize: 5,
        showPageNumbers: true,
        showNavigator: true,
        callback: function (pageData) {
            let postHtml = renderPosts(pageData);
            $("#post-container").html(postHtml);
        }
    });
}

/** 게시글 HTML 렌더링 */
function renderPosts(posts) {
    let html = "";

    posts.forEach(p => {
        const date = new Date(p.post_date).toISOString().split('T')[0];

        html += `
        <div class="item">
            <div class="post-life" onclick="gotoPost(${p.post_id})">
                <div class="life-kind">
                    <div style="display: flex; gap: 15px">
                        <div class="life-no">番号 : ${p.post_id}</div>
                        <div class="life-menu">地域 : ${p.post_menu}</div>
                    </div>
                    <div style="display: flex; margin-left: auto; gap: 15px">
                        <div class="info-name">投稿者 : ${p.user_nickname}</div>
                        <div class="info-date">投稿日 : ${date}</div>
                    </div>
                </div>
                <div class="life-title">${p.post_title}</div>
                <div class="life-info" style="display: flex; justify-content: space-between;">
                    <div class="life_southWest">
                        <div class="info-view">閲覧数 : ${p.post_view}</div>
                        <div class="info-like">いいね : ${p.post_like}</div>
                    </div>
                </div>
            </div>
        </div>`;
    });

    return html;
}
