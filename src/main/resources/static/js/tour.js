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