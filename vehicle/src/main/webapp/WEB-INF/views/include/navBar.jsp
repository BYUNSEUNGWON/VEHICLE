 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>포항 자동차 정비 업체 모아보기</title>
<meta name="viewport" content="width=device-width,initial-scale=1">

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
  top : 0;
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
</style>
</head>
<body>

    <ul>
    <li><a class="active" href="/vehicle/index.ex">홈</a></li>
    <li><a href="/vehicle/promotion.ex">홍보하기</a></li>
    <li><a href="#">차량용품거래</a></li>
    <li><a href="#">공지사항</a></li>
    </ul>

</body>
</html>