<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Promotion Detail</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
    }
    .container {
        max-width: 800px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }
    .title {
        font-size: 2em;
        margin-bottom: 20px;
        color: #333;
        border-bottom: 2px solid #f1f1f1;
        padding-bottom: 10px;
    }
    .contents {
        font-size: 1.1em;
        line-height: 1.6em;
        color: #555;
    }
    .contents p {
        margin-bottom: 20px;
    }
    .comments-section {
        margin-top: 40px;
    }
    .comments-title {
        font-size: 1.5em;
        margin-bottom: 20px;
        color: #333;
        border-bottom: 2px solid #f1f1f1;
        padding-bottom: 10px;
    }
    .comment {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }
    .comment:last-child {
        border-bottom: none;
    }
    .comment-author {
        font-weight: bold;
        margin-bottom: 5px;
    }
    .comment-text {
        margin-bottom: 10px;
    }
    .comment-date {
        font-size: 0.9em;
        color: #888;
    }
    .comment-form {
        margin-top: 20px;
    }
    .comment-form textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        resize: vertical;
    }
    .comment-form button {
        padding: 10px 20px;
        background-color: #f1f1f1;
        color: #333;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .comment-form button:hover {
        background-color: #ddd;
    }
    .source{
    	font-size: small;
    	float: right;
    }
</style>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script type="text/javascript">
    $(document).ready(function () {
        // JavaScript code can be added here if needed
        
        // AJAX 댓글 제출
        $('#commentForm').submit(function(event) {
            event.preventDefault();
            var commentText = $('#commentText').val();
            var promotionId = $('#promotion_id').val();
            $.ajax({
                url: "/vehicle/promotion/comment.ex",
                type: "POST",
                data: {
               		comment: commentText,
               		promotion_id: promotionId
               		},
                success: function(response){
					alert("댓글이 정상적으로 등록되었습니다.");
					window.location.reload();
                 },
                error: function(xhr, status, error){
                  alert(error);
                }
              });
        });
    });
</script>
<body>
	<input type="hidden" id="promotion_id" value="${promotion.promotion_id}">
    <div class="container">
        <div class="title">${promotion.title}
            <div class="source">
            	작성자 : ${promotion.regist_user_id}<br/>
            	작성일시 : ${promotion.regist_dt}
            </div>
        </div>
        <div class="contents">
            ${promotion.contents}
        </div>
        <div class="comments-section">
            <div class="comments-title">Comments</div>
            <div id="commentsList">
		        <c:forEach var="comment" items="${comments}">
		            <div class="comment">
		                <div class="comment-author">${comment.regist_user_id}</div>
		                <div class="comment-text">${comment.comment}</div>
		                <div class="comment-date">${comment.regist_dt}</div>
		            </div>
		        </c:forEach>
            </div>
            <div class="comment-form">
                <form id="commentForm">
                    <textarea id="commentText" placeholder="댓글을 입력하세요..." rows="4"></textarea>
                    <button type="submit">댓글달기</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>