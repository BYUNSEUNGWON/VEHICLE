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


</style>
</head>

<script type="text/javascript">
  // 현재 URL에서 파일명 부분만 추출하는 함수
  function getFileNameFromUrl(url) {
    var fileName = url.substring(url.lastIndexOf('/') + 1);
    return fileName;
  }

  // 홈 버튼이나 홍보하기 버튼에 검은색 스타일을 지정하는 함수
  function setNavLinkActive(linkUrl, targetLink) {
    var currentFileName = getFileNameFromUrl(linkUrl);
    if (currentFileName === targetLink.href.substring(targetLink.href.lastIndexOf('/') + 1)) {
      targetLink.classList.add("active");
      targetLink.style.backgroundColor = '#555';
      targetLink.style.color = 'white';
    }
  }

  // onload 이벤트 핸들러
  window.onload = function() {
    var links = document.querySelectorAll("ul li a");
    
    for (var i = 0; i < links.length; i++) {
      links[i].classList.remove("active");
      links[i].style.backgroundColor = '';
      setNavLinkActive(window.location.href, links[i]);
    }
  };
</script>

<body>
	<ul>
	  <li><a id="homeLink" href="/vehicle/index.ex">홈</a></li>
	  <li><a id="promotion" href="/vehicle/promotion.ex">홍보하기</a></li>
	  <li><a id="transaction" href="/vehicle/transaction.ex">차량용품거래</a></li>
	  <li><a id="notice" href="/vehicle/notice.ex">공지사항</a></li>
	</ul>
</body>
</html>