<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<title>포항 자동차 정비 업체 모아보기</title>
<style>
body {
  margin: 0;
}

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 10%;
  background-color: #f1f1f1;
  position: fixed;
  height: 100%;
  overflow: auto;
}

li a {
  display: block;
  color: #000;
  padding: 8px 16px;
  text-decoration: none;
}

li a.active {
  background-color: #555;
  color: white;
}

li a:hover:not(.active) {
  background-color: #555;
  color: white;
}

.secNav {
    margin-left: 10%;
    background-color: white;
    position: fixed;
    height: 100%;
    width: 370px;
    border-right: #cdcdcd solid 1px;
    text-align: center;
}

.search {
  position: relative;
  width: 300px;
  margin-left: 5%;
  margin-top: 5%;
}

input {
  width: 100%;
  border: 1px solid #bbb;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 14px;
}

img {
  position : absolute;
  width: 17px;
  top: 10px;
  right: 12px;
  margin: 0;
}

</style>
</head>

<body>

    <ul>
    <li><a class="active" href="#">홈</a></li>
    <li><a href="#">공지사항</a></li>
    <li><a href="#">소개</a></li>
    <li><a href="#">자유게시판</a></li>
    </ul>

    <div class="secNav">
	    <div class="search">
			<input type="text" placeholder="검색어 입력">
		 	<img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
		</div>
    </div>

    <div style="margin-left:35%;padding:1px 16px;height:1000px;">
        <h1>지도 들어갈 위치</h1>
        <c:forEach var="menuItem" items="${menu}">
            <li>${menuItem}</li>
        </c:forEach>
    </div>
</body>
</html>