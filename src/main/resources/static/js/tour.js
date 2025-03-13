const locWrap = document.querySelector(".location-wrap");
document.querySelector(".location-input").addEventListener("focus", () => {
    locWrap.classList.add("show");
});
document
    .querySelector(".location-input")
    .addEventListener("blur", (event) => {
        // 클릭한 요소가 location-wrap 내부라면 닫지 않음
        setTimeout(() => {
            if (!locWrap.contains(document.activeElement)) {
                locWrap.classList.remove("show");
            }
        }, 100);
    });

document.querySelector(".close-btn").addEventListener("click", () => {
    locWrap.classList.remove("show");
});

document.addEventListener("DOMContentLoaded", function () {



    // 메인 카테고리 리스트 (제주도, 울릉도, 강원 등)
    const mainCategories = document.querySelectorAll(
        ".panel_2depth .place_items li a"
    );

    // 모든 하위 지역 패널을 가져옴
    const allSubPanels = document.querySelectorAll(".sub-panel");

    // 초기 설정: 모든 하위 패널 숨기고 기본 선택된 것만 보이게 함
    allSubPanels.forEach((tour_panel) => {
        if (!tour_panel.classList.contains("selected")) {
            tour_panel.style.display = "none";
        }
    });

    // 메인 카테고리를 클릭하면 해당 지역의 하위 패널 표시
    mainCategories.forEach((category) => {
        category.addEventListener("click", function (event) {
            event.preventDefault(); // a 태그의 기본 동작 방지

            // 현재 클릭한 요소의 href 속성값을 가져옴 (ex: #place01)
            const targetId = this.getAttribute("href").replace("#", "");

            // 모든 하위 패널을 숨김 (대분류는 유지)
            allSubPanels.forEach((tour_panel) => {
                tour_panel.style.display = "none";
                tour_panel.classList.remove("selected");
            });

            // 해당 ID를 가진 패널을 보이게 설정
            const targetPanel = document.getElementById(targetId);
            if (targetPanel) {
                targetPanel.style.display = "block";
                targetPanel.classList.add("selected");
            }
        });
    });
});

document.addEventListener("DOMContentLoaded", function () {
    // 기존: 대분류/소분류 토글 코드
    const locWrap = document.querySelector(".location-wrap");
    document.querySelector(".location-input").addEventListener("focus", () => {
        locWrap.classList.add("show");
    });
    document.querySelector(".location-input").addEventListener("blur", () => {
        setTimeout(() => {
            if (!locWrap.contains(document.activeElement)) {
                locWrap.classList.remove("show");
            }
        }, 100);
    });
    document.querySelector(".close-btn").addEventListener("click", () => {
        locWrap.classList.remove("show");
    });

    const mainCategories = document.querySelectorAll(".panel_2depth .place_items li a");
    const allSubPanels = document.querySelectorAll(".sub-panel");
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

    // 소분류 클릭 시 Ajax 호출
    const subLinks = document.querySelectorAll(".sub-panel .place_items a");
    subLinks.forEach(link => {
        link.addEventListener("click", function (e) {
            e.preventDefault();
            const region = this.textContent.trim(); // 예: "전라북도"
            // 예시: 지역코드를 사용하는 경우 실제 지역코드 값으로 수정 필요 (예: "39")
            fetch(`/tour/region?areaCode=${encodeURIComponent(region)}`)
                .then(response => response.json())
                .then(data => {
                    const container = document.getElementById("tourContainer");
                    container.innerHTML = "";
                    data.forEach(item => {
                        const box = document.createElement("div");
                        box.className = "tour_img_box";
                        const anchor = document.createElement("a");
                        // 상세 페이지로 이동하고 싶으면 아래 주석 해제 및 URL 구성
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
                })
                .catch(err => console.error(err));
        });
    });
});

document.querySelectorAll(".search-area").forEach((atag) => {
    atag.addEventListener("click", (e) => {

        // extraInfo 영역을 보이게 설정 전 플래그 저장 (세션 스토리지 사용 예)
        sessionStorage.setItem("showExtraInfo", "true");

        const areaCode = e.target.parentElement.dataset.areacode;
        const sigungu = e.target.parentElement.dataset.sigungu;
        console.log(areaCode);
        console.log(sigungu);

        const form = document.createElement("form");
        form.method = "post";
        form.action = "/tour/loc"; // 실제 엔드포인트 URL로 변경

// areaCode를 담을 hidden input 생성
        const areaCodeInput = document.createElement("input");
        areaCodeInput.type = "hidden";
        areaCodeInput.name = "areaCode";
        areaCodeInput.value = areaCode;
        form.appendChild(areaCodeInput);

// sigungu를 담을 hidden input 생성
        const sigunguInput = document.createElement("input");
        sigunguInput.type = "hidden";
        sigunguInput.name = "sigungu";
        if (sigungu != null) {
            sigunguInput.value = sigungu;
        }
        form.appendChild(sigunguInput);

// form을 문서 body에 추가 (필요 시 다른 곳에 추가해도 됨)
        document.body.appendChild(form);
        form.submit();
    });
})

document.addEventListener("DOMContentLoaded", function () {
    const container = document.querySelector("#tourContainer .tour_img_container");
    const items = Array.from(container.querySelectorAll(".tour_img_box")); // 배열로 변환
    const paginationDiv = document.querySelector(".pagination");

    const itemsPerPage = 12; // 한 페이지에 보여줄 항목 수
    const totalItems = items.length;
    const totalPages = Math.ceil(totalItems / itemsPerPage);
    let currentPage = 1; // 초기 페이지

    // 초기 실행: 첫 페이지 표시 및 페이징 링크 생성
    showPage(currentPage);
    setupPagination();

    // 특정 페이지의 항목들만 보여주는 함수
    function showPage(page) {
        items.forEach(item => {
            item.style.display = "none";
        });
        const start = (page - 1) * itemsPerPage;
        const end = Math.min(start + itemsPerPage, totalItems);
        for (let i = start; i < end; i++) {
            items[i].style.display = "block";
        }
    }

    // 동적 페이징 링크 생성 함수 (페이지 번호를 10개씩 그룹화)
    function setupPagination() {
        paginationDiv.innerHTML = ""; // 기존 페이징 링크 초기화
        const blockSize = 10; // 한 그룹에 보여줄 페이지 번호 개수 (예: 10)

        // 현재 페이지 그룹 계산
        const startPage = Math.floor((currentPage - 1) / blockSize) * blockSize + 1;
        const endPage = Math.min(startPage + blockSize - 1, totalPages);

        // 항상 "first" 링크 생성
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

        // 항상 "prev" 링크 생성
        // "prev" 링크 수정: 현재 페이지에서 blockSize(10)를 빼도록 함
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

        // 현재 그룹의 페이지 번호 링크 생성 (startPage ~ endPage)
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

        // 항상 "next" 링크 생성
        // "next" 링크 수정: 현재 페이지에 blockSize(10)를 더하도록 함
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

        // 항상 "last" 링크 생성
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

        // 이전 페이지 그룹 ("…") 및 다음 페이지 그룹 ("…") 링크도 필요하면 추가할 수 있습니다.
        // 위 예제에서는 간단하게 first, prev, 페이지번호, next, last만 생성했습니다.
    }
}); // 레디 함수 끝