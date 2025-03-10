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
        link.addEventListener("click", function(e) {
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