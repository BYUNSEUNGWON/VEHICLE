<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/navBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style type="text/css">

.content {
  margin-left: 10%;
  margin-bottom: 3%;
}

.grid-item {
  background-color: white;
  padding: 20px;
  text-align: center;
  height: 200px;
}

.grid-detail {
  background-color: #f1f1f1;
  padding: 20px;
  text-align: center;
  height: 180px;
}

.paging-list {
	text-align: center;
  	margin-left: 10%;
  	margin-bottom: 5%;
}

.page-number {
  cursor: pointer;
  color: gray;
}

.page-number.active {
  font-weight: bold;
  color: black;
}

.paging-list {
    position: relative;
}

.write-button {
    position: absolute;
    left: 2%;
    height: 35px;
}
</style>
</head>
<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
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
        type: "POST",
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
    
    <c:url value="/vehicle/promotion/write.ex" var="url" />

   	$(".write-button").click(function() {
   	    console.log("여기서 세션에 따른 기업회원, 일반 회원 구분");
   	    
   	    // 여기서부터는 기업회원일 경우
   	    var url = "${url}";
   	 	window.open(url, "_blank", "width=1000, height=3000, left=10, top=10, menubar=no, titlebar=no, toolbar=no, status=no, location=no, scrollbars=yes, resizable=yes");

   	});
  });
  

</script>
<body>
	<div class="content">
		${gridItem}
	</div>

  
	<div class="paging-list" style="">
	  <button class="write-button"><span class="ui-icon ui-icon-pencil"></span>글쓰기</button>
	  <c:forEach items="${pageNumbers}" var="pageNumber" varStatus="status">
	    <span class="page-number ${pageNumber == currentPage ? 'active' : ''}" 
	          data-page-number="${pageNumber}">${pageNumber}</span>
	    <c:if test="${not status.last}">,</c:if>
	  </c:forEach>
	</div>
</body>
</html>