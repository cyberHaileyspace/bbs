document.addEventListener("DOMContentLoaded", function () {
    // 1. 기본 변수 및 요소 선택
    const locWrap = document.querySelector(".location-wrap");
    const locationInput = document.querySelector(".location-input");
    const closeBtn = document.querySelector(".close-btn");
    const mainCategories = document.querySelectorAll(".panel_2depth .place_items li a");
    const allSubPanels = document.querySelectorAll(".sub-panel");
    const subLinks = document.querySelectorAll(".sub-panel .place_items a");
    const searchAreas = document.querySelectorAll(".search-area");

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
    closeBtn.addEventListener("click", () => {
        locWrap.classList.remove("show");
    });

    // 3. 메인 카테고리 클릭 시 하위 패널 토글
    allSubPanels.forEach(panel => {
        if (!panel.classList.contains("selected")) {
            panel.style.display = "none";
        }
    });
    mainCategories.forEach(category => {
        category.addEventListener("click", function (event) {
            event.preventDefault();
            const targetId = this.getAttribute("href").replace("#", "");
            allSubPanels.forEach(panel => {
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

    // 4. 소분류 클릭 시 Ajax 호출 (관광지 목록 갱신)
    subLinks.forEach(link => {
        link.addEventListener("click", function (e) {
            e.preventDefault();
            const region = this.textContent.trim(); // 예: "전라북도"
            // 실제 지역코드에 맞게 수정 필요
            fetch(`/main/tour/region?areaCode=${encodeURIComponent(region)}`)
                .then(response => response.json())
                .then(data => {
                    const container = document.getElementById("tourContainer");
                    container.innerHTML = "";
                    data.forEach(item => {
                        const box = document.createElement("div");
                        box.className = "tour_img_box";
                        const anchor = document.createElement("a");
                        // 상세 페이지로 이동할 URL 구성 (필요 시 주석 해제)
                        // anchor.href = `/tour/detail?spotId=${item.spot_id}`;
                        const img = document.createElement("img");
                        img.src = item.spot_image || "default.jpg";
                        img.alt = item.spot_name || "";
                        const infoDiv = document.createElement("div");
                        infoDiv.textContent = item.spot_name || "이름없음";
                        anchor.appendChild(img);
                        anchor.appendChild(infoDiv);
                        box.appendChild(anchor);
                        container.appendChild(box);
                    });
                    // 새 데이터 로드 후 페이징 다시 설정 (아래 페이징 함수 호출)
                    setupPagination();
                    showPage(1); // 1페이지부터 표시
                })
                .catch(err => console.error(err));
        });
    });

    // 5. 검색 영역 클릭 시 폼 제출 (지역, sigungu 정보 전송)
    searchAreas.forEach(atag => {
        atag.addEventListener("click", (e) => {
            // extraInfo 영역을 보여주기 위한 플래그 저장 (예: sessionStorage)
            sessionStorage.setItem("showExtraInfo", "true");

            const areaCode = e.target.parentElement.dataset.areacode;
            const sigungu = e.target.parentElement.dataset.sigungu;
            console.log(areaCode, sigungu);

            const form = document.createElement("form");
            form.method = "post";
            form.action = "/main/tour/loc";

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
    const pagingContainer = document.querySelector("#tourContainer .tour_img_container");
    const paginationDiv = document.querySelector(".pagination");
    let items = []; // 페이징 대상 항목 배열 (폼 제출 시 갱신 필요)
    const itemsPerPage = 12; // 한 페이지에 보여줄 항목 수
    let totalPages = 0;
    let currentPage = 1;

    // 페이징 대상 항목을 갱신하는 함수
    function updateItems() {
        const container = document.querySelector("#tourContainer .tour_img_container");
        items = Array.from(container.querySelectorAll(".tour_img_box"));
        totalPages = Math.ceil(items.length / itemsPerPage);
    }

    // 특정 페이지 항목들만 표시하는 함수
    function showPage(page) {
        if (!items.length) return;
        items.forEach(item => { item.style.display = "none"; });
        const start = (page - 1) * itemsPerPage;
        const end = Math.min(start + itemsPerPage, items.length);
        for (let i = start; i < end; i++) {
            items[i].style.display = "block";
        }
    }

    // 동적 페이징 링크 생성 함수 (페이지 번호 그룹화: 10개씩)
    function setupPagination() {
        paginationDiv.innerHTML = "";
        const blockSize = 10;
        const startPage = Math.floor((currentPage - 1) / blockSize) * blockSize + 1;
        const endPage = Math.min(startPage + blockSize - 1, totalPages);

        const firstLink = document.createElement("a");
        firstLink.href = "#";
        firstLink.innerHTML = "&laquo; first";
        if (currentPage === 1) {
            firstLink.classList.add("disabled");
            firstLink.addEventListener("click", e => e.preventDefault());
        } else {
            firstLink.addEventListener("click", function(e) {
                e.preventDefault();
                currentPage = 1;
                showPage(currentPage);
                setupPagination();
            });
        }
        paginationDiv.appendChild(firstLink);

        const prevLink = document.createElement("a");
        prevLink.href = "#";
        prevLink.innerHTML = "&lsaquo; prev";
        if (currentPage === 1) {
            prevLink.classList.add("disabled");
            prevLink.addEventListener("click", e => e.preventDefault());
        } else {
            prevLink.addEventListener("click", function(e) {
                e.preventDefault();
                currentPage = Math.max(1, currentPage - blockSize);
                showPage(currentPage);
                setupPagination();
            });
        }
        paginationDiv.appendChild(prevLink);

        for (let i = startPage; i <= endPage; i++) {
            const pageLink = document.createElement("a");
            pageLink.href = "#";
            pageLink.innerHTML = i;
            if (i === currentPage) {
                pageLink.classList.add("active");
            }
            pageLink.addEventListener("click", function(e) {
                e.preventDefault();
                currentPage = i;
                showPage(currentPage);
                setupPagination();
            });
            paginationDiv.appendChild(pageLink);
        }

        const nextLink = document.createElement("a");
        nextLink.href = "#";
        nextLink.innerHTML = "next &rsaquo;";
        if (currentPage === totalPages || totalPages === 0) {
            nextLink.classList.add("disabled");
            nextLink.addEventListener("click", e => e.preventDefault());
        } else {
            nextLink.addEventListener("click", function(e) {
                e.preventDefault();
                currentPage = Math.min(totalPages, currentPage + blockSize);
                showPage(currentPage);
                setupPagination();
            });
        }
        paginationDiv.appendChild(nextLink);

        const lastLink = document.createElement("a");
        lastLink.href = "#";
        lastLink.innerHTML = "last &raquo;";
        if (currentPage === totalPages || totalPages === 0) {
            lastLink.classList.add("disabled");
            lastLink.addEventListener("click", e => e.preventDefault());
        } else {
            lastLink.addEventListener("click", function(e) {
                e.preventDefault();
                currentPage = totalPages;
                showPage(currentPage);
                setupPagination();
            });
        }
        paginationDiv.appendChild(lastLink);
    }





    // 페이징 초기 실행 (페이지 로드 후 데이터가 이미 있다면)
    updateItems();
    showPage(currentPage);
    setupPagination();


});


