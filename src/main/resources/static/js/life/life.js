function deletePost(no) {
    if (confirm('정말 삭제하시겠습니까?')) {
        fetch('/main/life/' + no, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        })
            .then(response => response.json())  // JSON 응답을 받음
            .then(data => {
                if (data.success) {
                    alert('삭제되었습니다.');
                    location.href = '/main/life';
                } else {
                    alert('로그인이 필요합니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
}

function handleReplySubmit(user_nickname) {
    if (user_nickname) {
        // 사용자가 로그인된 경우, 댓글을 등록하는 함수 호출
        submitReply();
    } else {
        alert("로그인 후 작성 가능합니다.")
        // 로그인되지 않은 경우, 로그인 페이지로 리다이렉트
        window.location.href = "/login"; // 필요에 따라 URL을 수정하세요
    }
}

function submitReply() {
    const replyContent = document.getElementById("replyContent").value;
    console.log(replyContent)
    // 댓글 내용이 비어있으면 경고 메시지
    if (!replyContent) {
        alert("댓글 내용을 입력해주세요.");
        return;
    }
    // console.log(post_id)
    // 댓글을 서버로 전송하는 fetch 요청 (서버 경로는 실제 경로로 수정해야 합니다)
    fetch(`/main/life/reply`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            post_id: post_id,
            r_context: replyContent,
            r_writer: user_nickname
        })
    })
        .then(response => response.json())
        .then(data => {
            if (data) {
                alert("댓글이 등록되었습니다.");
                loadLifeReplies(); // 댓글을 성공적으로 등록한 후 댓글을 다시 불러옴
                document.getElementById("replyContent").value = "";
            } else {
                alert("댓글 등록 실패. 다시 시도해주세요.");
            }
        })
        .catch(error => {
            console.error("댓글 등록 실패:", error);
        });
}

function editReply(r_id, r_writer, r_date, r_context) {
    const commentDiv = document.getElementById(`reply-${r_id}`);
    const originalContent = r_context;

    // 기존 내용 저장
    commentDiv.setAttribute("data-original", originalContent);

    // 댓글을 textarea로 변경
    commentDiv.innerHTML = `
        <div>
        <span>投稿者 : ${r_writer}</span> <br>
        <span>投稿日 : ${r_date}</span> <br>
        <textarea id="edit-text-${r_id}" class="edit-textarea">${originalContent}</textarea>
        </div>
        <button onclick="saveEdit('${r_id}', '${r_writer}', '${r_date}', '${originalContent}')">完了</button>
        <button onclick="cancelEdit()">取消</button>
    `;
}

function cancelEdit(r_id, r_writer, r_date, originalContent) {
    if (confirm("수정을 취소하시겠습니까?")) {
        loadReplies();
    }

    // const commentDiv = document.getElementById(`reply-${r_id}`);
    //
    // // 원래 댓글로 복원
    // commentDiv.innerHTML = `
    //     <div>
    //     <span>작성자 : ${r_writer}</span> <br>
    //     <span>작성일 : ${r_date}</span> <br>
    //     <p id="reply-context" class="edit-textarea">${originalContent}</p>
    //     </div>
    //     <button onclick="editReply('${r_id}', '${r_writer}', '${r_date}', '${originalContent}')">수정</button>
    //     <button onclick="deleteReply(${r_id})">삭제</button>
    //
    // `;
}

function saveEdit(r_id, r_writer, r_date, originalContent) {
    const newText = document.getElementById(`edit-text-${r_id}`).value;

    console.log("saveEdit 실행됨", r_id, r_writer, newText); // 실행 여부 확인

    // 텍스트 영역이 비어있는지 확인
    if (!newText.trim()) {
        alert("댓글 내용을 입력해주세요.");
        return;  // 텍스트가 비어 있으면 수정하지 않음
    }

    fetch(`/main/life/reply`, {
        method: "PUT",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify({
            r_id: r_id, // 수정할 댓글의 ID 포함
            r_context: newText // 새로운 댓글 내용
        })
    })
        .then(response => response.json())
        .then(data => {
            console.log("서버 응답 데이터", data); // 응답 데이터 확인

            if (!data || !data.success) {
                alert("댓글이 수정되었습니다.");
                loadLifeReplies(); // 수정 성공 후 댓글 목록 갱신
            } else {
                alert("수정 실패! 서버 응답: " + JSON.stringify(data));
                loadReplies(); // 수정 실패 후 댓글 목록 갱신
            }
        })
        .catch(error => {
            console.error("수정 중 오류 발생:", error);
            alert("수정 실패! 네트워크 오류.");
            loadReplies(); // 오류 발생 시에도 댓글 목록 갱신
        });
}

function deleteReply(r_id) {
    if (confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
        // DELETE 요청으로 데이터를 보냄
        fetch(`/main/life/reply/${r_id}`, {
            method: 'DELETE',  // HTTP method를 DELETE로 설정
            headers: {
                'Content-Type': 'application/json',  // JSON 형식으로 데이터 전송
            }
        })
            .then(response => response.json())  // 서버에서 응답을 JSON 형태로 받음
            .then(data => {
                if (data || !data.success) {
                    alert("댓글이 삭제되었습니다.");
                    loadReplies();  // 댓글 삭제 후 댓글 목록 갱신
                } else {
                    alert("댓글 삭제 실패! 서버 응답: " + JSON.stringify(data));
                }
            })
            .catch(error => {
                console.error("댓글 삭제 중 오류 발생:", error);
                alert("댓글 삭제 실패! 네트워크 오류.");
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
    location.href = "life/" + postId + "?token=" + token;
}

/* -------------------- 조회수 증가 로직 -------------------- */

function logincheck(user) {
    if (user)
        location.href = "life/reg";
    else {
        alert("先にログインしてください。");
        location.href = "/login"
    }
}

/* -------------------- 로그인 체크 -------------------- */

async function loadData(title) {

    try {
        let data = await $.ajax({
            url: "/main/life/all",
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
        $("#post-container").html("<p>投稿がありません。</p>");  // 게시글 없음 메시지 표시
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

        postHtml +=
            "<div class='item'>" +
            "<div class='post-life' onclick='goToPost(" + p.post_id + ")'>" +
            "<div class='life-kind'>" +
            "<div class='life-no'>番号: " + p.post_id + "</div>&nbsp;/&nbsp;" +
            "<div class='life-cate'>カテゴリー: " + p.post_category + "</div>&nbsp;/&nbsp;" +
            "<div class='life-menu'>地域: " + p.post_menu + "</div>" +
            "</div>" +
            "<div class='life-title'>" + p.post_title + "</div>" +
            "<div class='life-context'>" +
            "<div class='life-text'><span>" + p.post_context + "</span></div>" +
            "<div class='life-image'><img alt='' src='img/post/" + p.post_image + "'></div>" +
            "</div>" +
            "<div class='life-info'>" +
            "<div style='display: flex'>" +
            "<div class='info-name'>投稿者: " + p.user_nickname + "</div>&nbsp;/&nbsp;" +
            "<div class='info-date'>投稿日: " + formattedDate + "</div>" +
            "</div>" +
            "<div style='display: flex'>" +
            "<div class='info-view'>閲覧数: " + p.post_view + "</div>&nbsp;/&nbsp;" +
            "<div class='info-like'>いいね数: " + p.post_like + "</div>" +
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
        console.log("選択されたソートオプション:", option);

        $.ajax({
            url: 'life/option',
            type: 'GET',
            data: {option: option},
            async: true,
        })
            .done(function (resData) {
                console.log("受信データ:", resData);
                if (resData.length !== 0) {
                    paging(resData);
                }
            })
            .fail(function (xhr) {
                console.error("リクエスト失敗:", xhr);
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