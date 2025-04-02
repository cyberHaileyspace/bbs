<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>ディアスポラ</title>
    <link rel="stylesheet" href="/resources/css/default.css"/>
    <link rel="stylesheet" href="/resources/css/user_info.css"/>
    <link rel="stylesheet" href="/resources/css/board.css"/>
    <link rel="stylesheet" href="/resources/css/main.css"/>
    <link rel="stylesheet" href="/resources/css/tour.css"/>
    <link rel="stylesheet" href="/resources/css/tour_place.css"/>
    <link rel="stylesheet" href="/resources/css/board.css">
    <link rel="stylesheet" href="/resources/css/tourBoard.css">
    <script src="/resources/js/sample.js"></script>
  </head>
  <body>
    <div style="margin: 0 auto">
      <div class="header">
        <div
          style="
            display: flex;
            flex-direction: row;
            align-items: center;
            position: absolute;
            left: 5%;
          "
        >
          <img
            width="50px"
            src="/resources/css/Diaspora.png"
            class="panel-btn"
          />
        </div>
        <div
          onclick="location.href='/'"
          style="cursor: pointer; position: absolute; left: 39.5%; display: flex; align-items: center; gap: 15px"
        >
            <img src="/resources/img/refugee_7439891.png" style="width: 40px; height: 40px">ディアスポラ
        </div>
        <c:choose>
          <c:when test="${user ne null}">
            <div style="font-size: 20px; position: absolute; right: 5%">
              <span onclick="location.href='/mypage'" style="cursor: pointer"
                >${user.user_nickname} 様のマイページ</span
              >
              &nbsp;|&nbsp;
              <span onclick="location.href='/logout'" style="cursor: pointer"
                >ログアウト</span
              >
            </div>
          </c:when>
          <c:otherwise>
            <div style="font-size: 20px; position: absolute; right: 5%">
              <span onclick="location.href='/login'" style="cursor: pointer"
                >ログイン</span
              >
              &nbsp;|&nbsp;
              <span onclick="location.href='/user'" style="cursor: pointer"
                >新規登録</span
              >
            </div>
          </c:otherwise>
        </c:choose>
      </div>

        <div class="panel">
            <c:choose>
                <c:when test="${user ne null}">
                    <div onclick="location.href='/main/news'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/117/117965.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>海外ニュース</span>
                    </div>
                    <div onclick="location.href='/main/free'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/12094/12094191.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>自由掲示板</span>
                    </div>
                    <div onclick="location.href='/main/life'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/4943/4943739.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>生活掲示板</span>
                    </div>
                    <div onclick="location.href='/main/tour'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/5333/5333434.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>観光掲示板</span>
                    </div>
                    <div onclick="document.getElementById('defaultTourForm').submit()" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/7813/7813703.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>観光情報</span>
                    </div>
                    <div onclick="location.href='/main/toilet'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/4671/4671636.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>みんなのマップ</span>
                    </div>
                    <div>
              <span onclick="location.href='/mypage'" style="cursor: pointer"
              >${user.user_nickname} 様のマイページ</span
              >
                    </div>
                    <div>
              <span onclick="location.href='/logout'" style="cursor: pointer"
              >ログアウト</span
              >
                    </div>
                    <div
                            onclick="location.href='https://www.kr.emb-japan.go.jp/itprtop_ko/index.html'"
                            style="cursor: pointer"
                    >
                        在大韓民国日本国大使館
                    </div>
                </c:when>
                <c:otherwise>
                    <div onclick="location.href='/main/news'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/117/117965.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>海外ニュース</span>

                    </div>
                    <div onclick="location.href='/main/free'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/12094/12094191.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>自由掲示板</span>
                    </div>
                    <div onclick="location.href='/main/life'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/4943/4943739.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>生活掲示板</span>
                    </div>
                    <div onclick="location.href='/main/tour'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/5333/5333434.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>観光掲示板</span>
                    </div>
                    <div onclick="document.getElementById('defaultTourForm').submit()" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/7813/7813703.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>観光情報</span>
                    </div>
                    <div onclick="location.href='/main/toilet'" style="cursor: pointer" class="menu_container">
                        <img src="https://cdn-icons-png.flaticon.com/128/4671/4671636.png" style="width: 20px;
    height: 20px;
    margin-right: 5px;">
                        <span>みんなのマップ</span>
                    </div>
                    <div onclick="location.href='/login'" style="cursor: pointer">
                        ログイン
                    </div>
                    <div onclick="location.href='/user'" style="cursor: pointer">
                        新規登録
                    </div>
                    <div
                            onclick="location.href='https://www.kr.emb-japan.go.jp/itprtop_ko/index.html'"
                            style="cursor: pointer"
                    >
                        在大韓民国日本国大使館
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="main">
        <div class="main-cnt">
            <jsp:include page="${content}"></jsp:include>
        </div>
    </div>
    <div class="footer">
        <div style="font-size: 12px">
            ディアスポラを通じて、韓国での生活やビジネスに役立つ最新のヒントを共有しましょう。
        </div>
        <div>
            <h4>© 2025年 ディアスポラ 韓国在住日本人のための生活情報コミュニティ</h4>
        </div>
    </div>
</div>
        <form id="defaultTourForm" action="/main/tourInfo/loc" method="get">
            <input type="hidden" name="areaCode" value="6"/>
            <input type="hidden" name="sigungu" value=""/>
            <input type="hidden" name="sort" value="R"/>
            <input type="hidden" name="pageNo" value="1"/>
        </form>
</body>
</html>