<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<link rel="stylesheet" href="/resources/css/product.css">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="/resources/js/toilet/toilet.js"></script>
</head>
<body>

<h1>-product reg-</h1>

<div>
    <div>name <input type="text" id="name" name="p_name"></div>
    <div>price <input type="text" id="price" name="p_price"></div>
    <div>
        <button id="add">add</button>
    </div>
</div>

<hr>
<h1>-product update-</h1>
<form action="/products" method="post">
    <input type="text" hidden name="_method" value="put">
    <div>
        <div>
            <select name="p_no">

            </select>
        </div>
        <div><input type="text" name="p_name" id="up-name" placeholder="name"></div>
        <div><input type="text" name="p_price" id="up-price" placeholder="price"></div>
        <div>
            <button id="update-btn">update</button>
        </div>
    </div>
</form>
<hr>
<h1>-product delete-</h1>
<input type="text" name="delPk">
<button id="del-btn">delete</button>
<hr>

<h1>-product list-</h1>
<div>
    <div></div>
    <div class="item">
        <div></div>
        <div></div>
        <div></div>
    </div>
</div>
<%--첨부하길 원하는 템블릿--%>
<div class="item temp">
    <div class="no">${p.p_no}</div>
    <div class="name">${p.p_name}</div>
    <div class="price">${p.p_price}</div>
    <div class="delete">
        <button>del</button>
    </div>
</div>
<div id="product-list"></div>

<!-- 버튼을 클릭하면 모달이 열립니다 -->
<button id="openModal">Open Modal</button>

<!-- dialog 태그로 모달 정의 -->
<dialog id="myModal">
    <h2>Product Modal</h2>
    <div>
        <div class="modal-no"></div>
        <div class="modal-name"></div>
        <div class="modal-price"></div>
    </div>
    <button id="closeModal">Close</button>
</dialog>
</body>
</html>