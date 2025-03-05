
window.onload = () => {
    loadPosts();
}

// 전체조회 -> select
function loadPosts(){
       const noEL = document.querySelector('.no');
       const idEL = document.querySelector('.id');
       const nameEL = document.querySelector('.name');
       const beginEL = document.querySelector('.begin');
       const titleEL = document.querySelector('.title');
       const textEL = document.querySelector('.text');
       const dateEL = document.querySelector('.date');
       const obj = {
           p_no : noEL.value,
           p_id : idEL.value,
           p_name : nameEL.value,
           p_begin : beginEL.value,
           p_title : titleEL.value,
           p_text : textEL.value,
           p_date : dateEL.value
       }
    fetch("/boardFree/all")
        .then(response => response.json())
        .then(posts => {
            const postList = document.querySelector("#post-list");
            console.log(posts);
            postList.innerHTML="";
            posts.forEach(post => {
                console.log(post)
                const item = document.querySelector(".item.temp").cloneNode(true);
                item.querySelector(".no").innerText = post.p_no;
                item.querySelector(".no").dataset.no = post.p_no;
                item.querySelector(".no").dataset.id = post.p_id;
                item.querySelector(".no").dataset.name = post.p_name;
                item.querySelector(".no").dataset.begin = post.p_begin;
                item.querySelector(".no").dataset.title = post.p_title;
                item.querySelector(".no").dataset.text = post.p_text;
                item.querySelector(".no").dataset.date = post.p_date;

                item.querySelector(".id").innerText = post.p_id;
                item.querySelector(".name").innerText = post.p_name;
                item.querySelector(".begin").innerText = post.begin;
                item.querySelector(".title").innerText = post.p_title;
                // item.querySelector(".img").innerText = post.p_img;
                item.querySelector(".text").innerText = post.p_text;
                item.querySelector(".date").innerText = post.p_date;

                item.querySelector("a").href=`boardFree/detail?p_no=${post.p_no}`;

                item.classList.remove("temp");
                postList.appendChild(item);

            })


        })
}

