<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/navBar.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>

.outer {
	width: 800px;
	margin: auto;
}

.notice_title {
	border-bottom: 1px solid #282A35;
}

.notice_area {
	height: 1000px;
	margin-bottom: 5%;
	
}

.listAll {
	display: inline-block;
}

table{
	width: 100%;
	border-top: 1px solid;
	border-collapse: collapse;
	
}	

th, td {
	border-bottom: 1px solid;
	text-align: center;
	padding: 10px;
}

#itemTitle {
  cursor: pointer;
}

#itemTitle:hover {
  color: red;
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

.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  max-width: 600px;
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	function showData(data) {
	    console.log("Clicked data: " + data);
	    openModal();
	}
	
	function openModal() {
	  var modal = document.getElementById("myModal");
	  modal.style.display = "block";
	}

	function closeModal() {
	  var modal = document.getElementById("myModal");
	  modal.style.display = "none";
	}

	window.onclick = function(event) {
	  var modal = document.getElementById("myModal");
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
	
	$(document).ready(function(){
		
		// 첫 화면 들어갈 경우 페이징 1번에 css 주기
		$(".page-number").removeClass("active"); 
		$(".page-number[data-page-number='" + 1 + "']").addClass("active");
		  
	    $("body").on("click", ".page-number", function(){
	      var pageNumber = $(this).data("page-number"); // 클릭한 페이지 번호
	      console.log("pageNum ==>" , pageNumber);
	      // 페이지 데이터를 가져오는 Ajax 요청
	      $.ajax({
	        url: "/vehicle/notice/paging.ex",
	        type: "POST",
	        data: {page: pageNumber},
	        success: function(response){
			  	console.log(response);
			  	var noticeListContainer = document.getElementById("notice-list-container");

				 // 기존 내용 지우기
				 var existingRows = noticeListContainer.getElementsByTagName("tr");
				 while (existingRows.length > 0) {
				   noticeListContainer.removeChild(existingRows[0]);
				 }
	
				 // 새로운 데이터 추가
				 for (var i = 0; i < response.length; i++) {
				   var notice = response[i];
				   var listItem = document.createElement("tr");
				   var listItemContent = '<td><p class="listAll" onclick="showData(\'' + notice.bno + '\')">' + notice.bno + '</p></td>' +
				     '<td><p class="listAll" id="itemTitle" onclick="showData(\'' + notice.title + '\')">' + notice.title + '</p></td>' +
				     '<td><p class="listAll" onclick="showData(\'' + notice.regist_user_nm + '\')">' + notice.regist_user_nm + '</p></td>' +
				     '<td><p class="listAll" onclick="showData(\'' + notice.date + '\')">' + notice.date + '</p></td>';
				   listItem.innerHTML = listItemContent;
				   noticeListContainer.appendChild(listItem);
				 }
				 
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
	<div class="outer">
		<div class="wrap">
			<div class="notice_area">
				<div class="notice_title">
					<h1 style="text-align: center;">공지사항</h1>
				</div>
				
				<div class="notice_contents">
					<table>
					  <thead>
					    <tr>
					      <th id="bno">번호</th>
					      <th id="title">제목</th>
					      <th id="regist_user_nm">작성자</th>
					      <th id="date">날짜</th>
					    </tr>
					  </thead>
					  <tbody class="notice_list" id="notice-list-container">
					    <c:forEach var="notice" items="${listNotice}">
					      <tr>
					        <td>
					          <p class="listAll" onclick="showData('${notice.bno}')">${notice.bno}</p>
					        </td>
					        <td>
					          <p class="listAll" id="itemTitle" onclick="showData('${notice.title}')">${notice.title}</p>
					        </td>
					        <td>
					          <p class="listAll" onclick="showData('${notice.regist_user_nm}')">${notice.regist_user_nm}</p>
					        </td>
					        <td>
					          <p class="listAll" onclick="showData('${notice.date}')">${notice.date}</p>
					        </td>
					      </tr>
					    </c:forEach>
					  </tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="paging-list">
	  <button class="write-button"><span class="ui-icon ui-icon-pencil"></span>글쓰기</button>
	  <c:forEach items="${pageNumbers}" var="pageNumber" varStatus="status">
	    <span class="page-number ${pageNumber == currentPage ? 'active' : ''}" 
	          data-page-number="${pageNumber}">${pageNumber}</span>
	    <c:if test="${not status.last}">,</c:if>
	  </c:forEach>
	</div>
	
	<div class="modal" id="myModal">
	  <div class="modal-content">
	    <span class="close" onclick="closeModal()">&times;</span>
	    <h2>Modal Title</h2>
	    <p>This is the content of the modal.</p>
	  </div>
	</div>
</body>
</html>