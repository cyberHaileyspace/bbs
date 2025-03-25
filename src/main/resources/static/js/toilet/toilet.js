window.onload = () => {
    loadToiletlist();
    insertToilet();
    updateProduct();

    const delBtn = document.querySelector("#del-btn");
    const pkEl = document.querySelector('input[name=delPk]');
    delBtn.addEventListener("click", () => {
        deleteProduct(pkEl.value);
        pkEl.value = "";
    })

}


function updateProduct() {
    const updateBtn = document.querySelector("#update-btn");
    const selectEl = document.querySelector("select[name='p_no']");
    const nameEl = document.querySelector("#up-name");
    const priceEl = document.querySelector("#up-price");
    console.log(selectEl);
    console.log(nameEl);
    console.log(priceEl);
    updateBtn.addEventListener("click", ()=>{
        console.log(selectEl.value)

        const obj = {
            p_no : selectEl.value,
            p_name: nameEl.value,
            p_price: priceEl.value
        };
        console.log(obj);
        console.log(JSON.stringify(obj));

        fetch('/api/products', {
            method: "put",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(obj)
        }).then(response => {
            console.log(response);
            loadToiletlist();
            nameEl.value = "";
            priceEl.value = "";
        })
    });
}

// 전체조회 -> select
function loadToiletlist() {

    fetch('/api/product/all')
        .then(response => response.json())
        .then(products => {
            // console.log(products)
            const productList = document.querySelector("#product-list");
            productList.innerHTML = "";
            products.forEach(product => {
                console.log(product)
                const item = document.querySelector(".item.temp").cloneNode(true);
                item.querySelector(".no").innerText = product.p_no;
                item.querySelector(".no").dataset.no = product.p_no;
                item.querySelector(".no").dataset.name = product.p_name;
                item.querySelector(".no").dataset.price = product.p_price;

                item.querySelector(".name").innerText = product.p_name;
                item.querySelector(".price").innerText = product.p_price;

                item.classList.remove("temp");
                productList.appendChild(item);

                item.querySelector(".name").addEventListener("click", () => {
                    getProduct(product.p_no);
                });

                item.lastElementChild.addEventListener("click", () => {
                    console.log(product.p_no);
                    deleteProduct(product.p_no);

                })



            })

            modal()
            const noEl = document.querySelectorAll(".no");
            const selectEl = document.querySelector("select[name='p_no']")
            console.log(selectEl)
            let optionEl;
            noEl.forEach(noDiv => {
                console.log(noDiv.innerText);
                let no = noDiv.innerText;
                optionEl += ` <option value="${no}">no.${no}</option>`;
            })
            selectEl.innerHTML = optionEl;


        })
}


function getProduct(no){
    // get, 비동기 ㄴㄴ
    location.href='/products/api/product/' + no;
}


function deleteProduct(no) {
    fetch(
        `/api/product/${no}`, {
            method: "delete",
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(response => response.json())
        .then(result => {
            console.log(result);
            loadToiletlist();
        })
}

function insertToilet() {
    const nameEl = document.querySelector("#name");
    const priceEl = document.querySelector("input[name='p_price']");
    const addBtn = document.querySelector("#add");
    console.log(nameEl);
    console.log(priceEl);
    console.log(addBtn);

    addBtn.addEventListener("click", () => {
        const obj = {
            p_name: nameEl.value,
            p_price: priceEl.value
        };
        console.log(obj);
        console.log(JSON.stringify(obj));

        fetch('/products/api/product', {
            method: "post",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(obj)
        }).then(response => {
            console.log(response);
            loadToiletlist();
            nameEl.value = "";
            priceEl.value = "";
        })
    })
}
function modal() {
    // 모달 엘리먼트와 버튼을 변수로 지정
    const openModalNo = document.querySelectorAll(".no");
    console.log(openModalNo + "-----------------------");
    const openModalButton = document.getElementById('openModal');
    const closeModalButton = document.getElementById('closeModal');
    const myModal = document.getElementById('myModal');

    openModalNo.forEach(noEl => {
        noEl.addEventListener("click", (e) => {
            console.log("event..")
            myModal.showModal();
            console.log(e.target.dataset);
            console.log(e.target.dataset.no);
            console.log(e.target.dataset.name)
            console.log(e.target.dataset.price);
            document.querySelector(".modal-no").innerText = e.target.dataset.no;
            document.querySelector(".modal-name").innerText = e.target.dataset.name;
            document.querySelector(".modal-price").innerText = e.target.dataset.price;

        })
    })

    // 모달 열기
    openModalButton.addEventListener('click', () => {
        myModal.showModal();  // showModal()을 호출하여 모달을 화면에 표시
        console.log(e.target.dataset);
    });

    // 모달 닫기
    closeModalButton.addEventListener('click', () => {
        myModal.close();  // close()를 호출하여 모달을 닫음
    });
}
