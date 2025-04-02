  document.addEventListener("DOMContentLoaded", function () {
    // 1. 기본 변수 및 요소 선택
    const locWrap = document.querySelector(".location-wrap");
    const locationInput = document.querySelector(".location-input");
    const closeBtn = document.querySelector(".close-btn");
    const mainCategories = document.querySelectorAll(
      ".panel_2depth .place_items li a"
    );
    const allSubPanels = document.querySelectorAll(".sub-panel");
    const subLinks = document.querySelectorAll(".sub-panel .place_items a");
    const searchAreas = document.querySelectorAll(".search-area");
    const commentForm = document.getElementById("commentForm");

    document.querySelectorAll(".sort").forEach((sort) => {
      sort.addEventListener("click", (e) => {
        // 기존 시군구, 지역코드, 솔팅
        const params = e.target.dataset;

        const form = document.createElement("form");
        form.method = "get";
        form.action = "/main/tourInfo/loc";

        const inputAreaCode = document.createElement("input");
        inputAreaCode.type = "hidden";
        inputAreaCode.name = "areaCode";
        inputAreaCode.value = params.areaCode;
        form.appendChild(inputAreaCode);

        const inputSigungu = document.createElement("input");
        inputSigungu.type = "hidden";
        inputSigungu.name = "sigungu";
        inputSigungu.value = params.sigungu;
        form.appendChild(inputSigungu);

        const inputSort = document.createElement("input");
        inputSort.type = "hidden";
        inputSort.name = "sort";
        inputSort.value = params.sort;
        form.appendChild(inputSort);

        document.body.appendChild(form);
        form.submit();
      })
    })

    if (locationInput) {
      // 2. 위치 입력 필드 포커스/블러 이벤트 처리
      locationInput.addEventListener("focus", () => {
        locWrap.classList.add("show");
      });
      locationInput.addEventListener("blur", () => {
        setTimeout(() => {
          if (!locWrap.contains(document.activeElement)) {
            locWrap.classList.remove("show");
          }
        }, 100);
      });
    }
    if (closeBtn) {
      closeBtn.addEventListener("click", () => {
        locWrap.classList.remove("show");
      });
    }
    if (allSubPanels) {
      // 3. 메인 카테고리 클릭 시 하위 패널 토글
      allSubPanels.forEach((panel) => {
        if (!panel.classList.contains("selected")) {
          panel.style.display = "none";
        }
      });
    }
    mainCategories.forEach((category) => {
      category.addEventListener("click", function (event) {
        event.preventDefault();
        const targetId = this.getAttribute("href").replace("#", "");
        allSubPanels.forEach((panel) => {
          panel.style.display = "none";
          panel.classList.remove("selected");
        });
        const targetPanel = document.getElementById(targetId);
        if (targetPanel) {
          targetPanel.style.display = "block";
          targetPanel.classList.add("selected");
        }
      });
    });


    // 5. 검색 영역 클릭 시 폼 제출 (지역, sigungu 정보 전송)
    searchAreas.forEach((atag) => {
      atag.addEventListener("click", (e) => {
        // extraInfo 영역을 보여주기 위한 플래그 저장 (예: sessionStorage)
        sessionStorage.setItem("showExtraInfo", "true");

        const areaCode = e.target.parentElement.dataset.areacode;
        const sigungu = e.target.parentElement.dataset.sigungu;
        console.log(areaCode, sigungu);

        const form = document.createElement("form");
        form.method = "get";
        form.action = "/main/tourInfo/loc";

        const areaCodeInput = document.createElement("input");
        areaCodeInput.type = "hidden";
        areaCodeInput.name = "areaCode";
        areaCodeInput.value = areaCode;
        form.appendChild(areaCodeInput);

        const sigunguInput = document.createElement("input");
        sigunguInput.type = "hidden";
        sigunguInput.name = "sigungu";
        if (sigungu != null) {
          sigunguInput.value = sigungu;
        }
        form.appendChild(sigunguInput);

        document.body.appendChild(form);
        form.submit();
      });
    });


    // 6. 페이징 기능 (동적 생성 및 항목 표시)
    // 페이징 관련 DOM 요소는 #tourContainer 안의 .tour_img_container와 .pagination이어야 함.
    const pagingContainer = document.querySelector(
      "#tourContainer .tour_img_container"
    );
    const paginationDiv = document.querySelector(".pagination");
    let items = []; // 페이징 대상 항목 배열 (폼 제출 시 갱신 필요)
    const itemsPerPage = 12; // 한 페이지에 보여줄 항목 수
    let totalPages = 0;
    let currentPage = 1;

    // console.log(currentPage)

    // 동적 페이징 링크 생성 함수 (페이지 번호를 10개씩 그룹화)
    function setupPagination() {
      console.log("pagination called..");
      if(paginationDiv){

      paginationDiv.innerHTML = ""; // 기존 페이징 링크 초기화

      const blockSize = 10; // 한 그룹에 보여줄 페이지 번호 개수 (예: 10)

      // 현재 페이지 그룹 계산
      const currentBlock = Math.floor((currentPage - 1) / blockSize);
      const startPage = currentBlock * blockSize + 1;
      const endPage = Math.min(startPage + blockSize - 1, totalPages);

      // "first" 링크 생성
      const firstLink = document.createElement("a");
      firstLink.href = "#";
      firstLink.innerHTML = "&laquo; first";
      if (currentPage === 1) {
        firstLink.classList.add("disabled");
        firstLink.addEventListener("click", (e) => e.preventDefault());
      } else {
        firstLink.addEventListener("click", function (e) {
          e.preventDefault();
          currentPage = 1;
          // sessionStorage.setItem("page", currentPage);
          showPage(currentPage);
          setupPagination();
        });
      }
      paginationDiv.appendChild(firstLink);

      // "prev" 링크 생성: 이전 블록의 마지막 페이지로 이동
      const prevLink = document.createElement("a");
      prevLink.href = "#";
      prevLink.innerHTML = "&lsaquo; prev";
      if (currentBlock === 0) {
        prevLink.classList.add("disabled");
        prevLink.addEventListener("click", (e) => e.preventDefault());
      } else {
        prevLink.addEventListener("click", function (e) {
          e.preventDefault();
          // 이전 블록의 마지막 페이지는 현재 블록의 시작페이지 - 1
          currentPage = startPage - 1;
          //  sessionStorage.setItem("page", currentPage);
          showPage(currentPage);
          setupPagination();
        });
      }
      paginationDiv.appendChild(prevLink);

      // 현재 그룹의 페이지 번호 링크 생성 (startPage ~ endPage)
      for (let i = startPage; i <= endPage; i++) {
        const pageLink = document.createElement("a");
        pageLink.href = "#";
        pageLink.innerHTML = i;
        if (i == currentPage) {
          pageLink.classList.add("active");
        }
        pageLink.addEventListener("click", function (e) {
          e.preventDefault();
          //    sessionStorage.setItem("page", i);
          //     currentPage = sessionStorage.getItem("page");
          currentPage = i;
          console.log(i);
          showPage(currentPage);
          setupPagination();
        });
        paginationDiv.appendChild(pageLink);
      }

      // "next" 링크 생성: 다음 블록의 첫 페이지로 이동
      const nextLink = document.createElement("a");
      nextLink.href = "#";
      nextLink.innerHTML = "next &rsaquo;";
      // 다음 블록의 첫 페이지 계산
      const nextBlockFirst = (currentBlock + 1) * blockSize + 1;
      if (nextBlockFirst > totalPages || totalPages === 0) {
        nextLink.classList.add("disabled");
        nextLink.addEventListener("click", (e) => e.preventDefault());
      } else {
        nextLink.addEventListener("click", function (e) {
          e.preventDefault();
          currentPage = nextBlockFirst;
          // sessionStorage.setItem("page", currentPage);
          showPage(currentPage);
          setupPagination();
        });
      }
      paginationDiv.appendChild(nextLink);

      // "last" 링크 생성
      const lastLink = document.createElement("a");
      lastLink.href = "#";
      lastLink.innerHTML = "last &raquo;";
      if (currentPage === totalPages || totalPages === 0) {
        lastLink.classList.add("disabled");
        lastLink.addEventListener("click", (e) => e.preventDefault());
      } else {
        lastLink.addEventListener("click", function (e) {
          e.preventDefault();
          currentPage = totalPages;
          // sessionStorage.setItem("page", currentPage);
          showPage(currentPage);
          setupPagination();
        });
      }
      paginationDiv.appendChild(lastLink);
    }
    }
    // 페이징 대상 항목을 갱신하는 함수
    function updateItems() {
      const container = document.querySelector(
        "#tourContainer .tour_img_container"
      );
      if (container) {
        items = Array.from(container.querySelectorAll(".tour_img_box"));
        totalPages = Math.ceil(items.length / itemsPerPage);
      }
    }

    // 특정 페이지 항목들만 표시하는 함수
    function showPage(page) {
      // 만약 폼에 hidden input이 있다면 페이지 번호 값을 업데이트
      const pageNoField = document.getElementById("pageNoField");
      if (pageNoField) {
        pageNoField.value = page;
      }

      // 나머지 로직: 모든 항목 숨기고, 해당 페이지에 해당하는 항목만 표시
      if (!items.length) return;
      items.forEach((item) => {
        item.style.display = "none";
      });
      const start = (page - 1) * itemsPerPage;
      const end = Math.min(start + itemsPerPage, items.length);
      for (let i = start; i < end; i++) {
        items[i].style.display = "block";
        if (!items[i].children[0].querySelector("img")) {
          const img = document.createElement("img");
          img.src = items[i].dataset.imgUrl;
          items[i].children[0].prepend(img);
        }
      }

      document.querySelectorAll(".jp-title").forEach(el => {
        const original = el.dataset.title;
        const matched = original.match(/^(.*?)（(.*?)）/);

        if (matched) {
          const beforeParen = matched[1];
          const insideParen = matched[2];
          el.innerHTML = `${beforeParen}<br>（${insideParen}）`;
        } else {
          el.textContent = original;
        }
      });


      updateState(page);
    }

    // 페이징 초기 실행 (페이지 로드 후 데이터가 이미 있다면)
    updateItems();
    showPage(currentPage);
    setupPagination();
    loadReplies();
    // 페이지를 로드한 후 현재 상태 저장 (초기 상태: 1페이지)
    window.addEventListener("load", function () {
      // 만약 이전 상태가 없으면 기본 상태(페이지 1) 설정
      if (!history.state) {
        history.replaceState({ pageNo: 1 }, "", window.location.href);
      }
      // 페이지 번호를 복원하고 페이징 함수 호출
      const state = history.state;
      currentPage = state.pageNo;
    });

    // 페이징 상태가 변경될 때마다 URL과 history 상태 업데이트
    function updateState(pageNo) {
      // 현재 상태를 업데이트 (pushState 대신 replaceState 사용하면 뒤로가기 동작에 문제가 덜 생깁니다)
      history.replaceState({ pageNo: pageNo }, "", updateUrl(pageNo));
    }

    // 예: URL에 pageNo를 반영하는 함수 (다른 파라미터는 그대로 둠)
    function updateUrl(pageNo) {
      const url = new URL(window.location);
      url.searchParams.set("pageNo", pageNo);
      return url.toString();
    }

    // 뒤로 가기(또는 포워드) 이벤트 처리: history state를 복원하여 페이지 표시
    window.addEventListener("popstate", function (event) {
      if (event.state && event.state.pageNo) {
        currentPage = event.state.pageNo;
        showPage(currentPage);
        setupPagination();
      }
    });


  });




  // -------------------------------------------------------------------------------

  window.handleTourReplySubmit = function (user_nickname) {
    console.log(user_nickname);
    if (user_nickname) {
      // 사용자가 로그인된 경우, 댓글을 등록하는 함수 호출
      submitReply();
    } else {
      alert("ログイン後に投稿できます。");
      // 로그인되지 않은 경우, 로그인 페이지로 리다이렉트
      window.location.href = "/login"; // 필요에 따라 URL을 수정하세요
    }
  }

  function submitReply() {
    const replyContent = document.getElementById("replyContent").value;
    console.log(replyContent);
    // 댓글 내용이 비어있으면 경고 메시지
    if (!replyContent) {
      alert("コメント内容を入力してください。");
      return;
    }
    // console.log(post_id)
    // 댓글을 서버로 전송하는 fetch 요청 (서버 경로는 실제 경로로 수정해야 합니다)
    fetch(`/main/locReply`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        contentid: post_id,
        r_context: replyContent,
        r_writer: user_nickname,
      }),
    })
        .then((response) => response.json())
        .then((data) => {
          if (data) {
            alert("コメントが登録されました。");
            loadReplies(); // 댓글을 성공적으로 등록한 후 댓글을 다시 불러옴
            document.getElementById("replyContent").value = "";
          } else {
            alert("コメントの登録に失敗しました。もう一度お試しください。");
          }
        })
        .catch((error) => {
          console.error("コメントの登録に失敗しました:", error);
        });
  }

  function editReply(r_id, r_writer, r_date, r_context) {
    console.log("修正するコメントID:", r_id); // r_id 확인
    const commentDiv = document.getElementById(`reply-${r_id}`);
    const originalContent = r_context;

    // 기존 내용 저장
    commentDiv.setAttribute("data-original", originalContent);

    // 댓글을 textarea로 변경
    commentDiv.innerHTML = `
          <div>
          <div class="reply_form">
          <span>作成者 : ${r_writer}</span>
          <span style="margin-left: auto">作成日 : ${r_date}</span>
          </div>
          <textarea id="edit-text-${r_id}" class="edit-textarea">${originalContent}</textarea>
          </div>
          <div style="display: flex; gap: 15px">
          <button onclick="saveEdit('${r_id}', '${r_writer}', '${r_date}', '${originalContent}')" class="reply_my_button">修正完了</button>
          <button onclick="cancelEdit()" class="reply_my_button">キャンセル</button></div>
      `;
  }

  function cancelEdit(r_id, r_writer, r_date, originalContent) {
    if (confirm("修正をキャンセルしますか？")) {
      loadReplies();
    }
  }
  function saveEdit(r_id, r_writer, r_date, originalContent) {
    const newText = document.getElementById(`edit-text-${r_id}`).value;

    console.log("saveEdit 実行", r_id, r_writer, newText); // 실행 여부 확인

    // 텍스트 영역이 비어있는지 확인
    if (!newText.trim()) {
      alert("コメント内容を入力してください。");
      return; // 텍스트가 비어 있으면 수정하지 않음
    }

    fetch(`/main/locReply`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        r_id: r_id, // 수정할 댓글의 ID 포함
        r_context: newText, // 새로운 댓글 내용
      }),
    })
        .then((response) => response.json())
        .then((data) => {
          console.log("サーバーの応答データ", data); // 응답 데이터 확인

          if (data === 1) {
            alert("コメントが修正されました。");
            loadReplies(); // 수정 성공 후 댓글 목록 갱신
          } else {
            alert("修正に失敗しました。サーバーの応答: " + JSON.stringify(data));
            loadReplies(); // 수정 실패 후 댓글 목록 갱신
          }
        })
        .catch((error) => {
          console.error("修正中にエラーが発生しました:", error);
          alert("修正に失敗しました。ネットワークエラーです。");
          loadReplies(); // 오류 발생 시에도 댓글 목록 갱신
        });
  }

  function deleteReply(r_id) {
    if (confirm("本当にこのコメントを削除しますか？")) {
      // DELETE 요청으로 데이터를 보냄
      fetch(`/main/locReply/${r_id}`, {
        method: "DELETE", // HTTP method를 DELETE로 설정
        headers: {
          "Content-Type": "application/json", // JSON 형식으로 데이터 전송
        },
      })
          .then((response) => response.json()) // 서버에서 응답을 JSON 형태로 받음
          .then((data) => {
            if (data === 1) {
              alert("コメントが削除されました。");
              loadReplies(); // 댓글 삭제 후 댓글 목록 갱신
            } else {
              alert("コメントの削除に失敗しました。サーバーの応答: " + JSON.stringify(data));
            }
          })
          .catch((error) => {
            console.error("コメント削除中にエラーが発生しました:", error);
            alert("コメントの削除に失敗しました。ネットワークエラーです。");
          });
    }
  }
