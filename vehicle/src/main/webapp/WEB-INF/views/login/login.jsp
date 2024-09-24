<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="styles.css">
    
<style type="text/css">
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.login-container {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    text-align: center;
}

.login-container h2 {
    margin-bottom: 20px;
    color: #333;
}

.login-container label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #666;
}

.login-container input {
    width: 90%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.login-container button:hover {
    background-color: #999;
}

.foot-option {
    display: flex;
    justify-content: space-between;
    gap: 10px;
}

.login-option {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    background-color: #666;
    color: #fff;
    font-size: 16px;
    cursor: pointer;
    flex-grow: 1;
}
</style>
</head>
<body>
    <div class="login-container">
        <h2>로그인</h2>
        <form action="/vehicle/login.ex" method="post">
            <label for="userId">아이디</label>
            <input type="text" id="userId" name="userId" required>
            
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required>
            <div class="foot-option">
	            <button type="submit" class="login-option">로그인</button>
            </div>
            <a href="/vehicle/regist.ex"><p>아직도 계정이 없다면?</p></a>
        </form>
    </div>
</body>
</html>