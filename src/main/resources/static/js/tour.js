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

// 모든 tour_img_box에 클릭 이벤트 리스너 등록
document.querySelectorAll('.tour_img_box').forEach(box => {
    box.addEventListener('click', function(e) {
        // 클릭한 요소에서 컨텐츠 정보를 가져옵니다.
        // 여기서는 a 태그 내부의 div의 텍스트를 사용합니다.
        const content = this.querySelector('a div').innerHTML;
        document.getElementById('modalContent').innerHTML = content;

        // 모달창 활성화
        document.getElementById('modalOverlay').classList.add('active');
    });
});

// 모달 닫기 이벤트
document.getElementById('closeModal').addEventListener('click', function() {
    document.getElementById('modalOverlay').classList.remove('active');
});

// 모달 영역 외부 클릭 시 닫기
document.getElementById('modalOverlay').addEventListener('click', function(e) {
    if (e.target === this) {
        document.getElementById('modalOverlay').classList.remove('active');
    }
});