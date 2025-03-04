<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="resources/css/main.css">
    <link rel="stylesheet" href="resources/css/tour.css">
    <script src="resources/js/tour.js"></script>
</head>
<body>
<div>
    <div class="header">header</div>
    <div class="content">
        <c:import url="${content}"></c:import>
    </div>
    <div class="footer">footer</div>
</div>
</body>
</html>