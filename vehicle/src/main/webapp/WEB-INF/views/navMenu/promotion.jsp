<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/navBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홍보 목록</title>
<style>
body {
  margin: 0;
  margin-bottom: 3%;
}

.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 20px;
  padding: 20px;
  margin-left: 10%;
}

.grid-item {
  background-color: #f1f1f1;
  padding: 20px;
  text-align: center;
  height: 300px;
}

.paging-list {
	text-align: center;
  	margin-left: 10%;
}

.page-number {
  cursor: pointer;
  color: gray;
}

.page-number.active {
  font-weight: bold;
  color: black;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script>
  $(document).ready(function(){
	
	// 첫 화면 들어갈 경우 페이징 1번에 css 주기
	$(".page-number").removeClass("active"); 
    $(".page-number[data-page-number='" + 1 + "']").addClass("active");

	  
    $("body").on("click", ".page-number", function(){
      var pageNumber = $(this).data("page-number"); // 클릭한 페이지 번호
      console.log("pageNum ==>" , pageNumber);
      // 페이지 데이터를 가져오는 Ajax 요청
      $.ajax({
        url: "/vehicle/promotion/paging.ex",
        type: "GET",
        data: {page: pageNumber},
        success: function(response){
          // 성공적으로 데이터를 가져온 경우
          //$("#promotion-container").html(response);
          console.log("success");
          console.log(response);
          $(".page-number").removeClass("active"); // 모든 페이지 번호에서 active 클래스 제거
          $(".page-number[data-page-number='" + pageNumber + "']").addClass("active"); // 클릭한 페이지 번호에 active 클래스 추가

         },
        error: function(xhr, status, error){
          // 데이터 가져오기 실패한 경우 에러 처리
          console.log(error);
        }
      });
    });
  });
</script>
<body>

  <div class="container">
    <div class="grid-item">홍보 1</div>
    <div class="grid-item">홍보 2</div>
    <div class="grid-item">홍보 3</div>
    <div class="grid-item">홍보 4</div>
    <div class="grid-item">홍보 5</div>
    <div class="grid-item">홍보 6</div>
    <div class="grid-item">홍보 7</div>
    <div class="grid-item">홍보 8</div>
    <div class="grid-item">홍보 9</div>
  </div>
  
	<div class="paging-list">
	  <c:forEach items="${pageNumbers}" var="pageNumber" varStatus="status">
	    <span class="page-number ${pageNumber == currentPage ? 'active' : ''}" 
	          data-page-number="${pageNumber}">${pageNumber}</span>
	    <c:if test="${not status.last}">,</c:if>
	  </c:forEach>
	</div>
</body>
</html>