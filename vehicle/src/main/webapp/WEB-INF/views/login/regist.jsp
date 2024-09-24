<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
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
            text-align: left;
            height: auto; /* height를 auto로 변경하여 내용에 따라 높이가 조정되도록 함 */
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }

        .login-container label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #666;
        }

        .login-container input {
            width: 90%; /* 100%로 변경 */
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
        .dup-btn {
        	border: none;
            border-radius: 4px;
            color: #fff;
            background-color: #666;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery CDN 추가 -->
    <script type="text/javascript">
    $(document).ready(function () {
        next(0);
        showMailNumber("hidden");
        
    });

    function next(i) {
        if (!validateForm(i)) {
            alert("빈 값이 있습니다. 모든 필드를 채워주세요.");
            return;
        }
        
        if(document.getElementById("dupCheckValue").value === "false" && i != 0){
            alert("아이디 중복체크를 진행해주세요.");
            return;
        }

		switch (i) {
            case 0:
                document.getElementById("first-contents").style.display = "block";
                document.getElementById("second-contents").style.display = "none";
                document.getElementById("third-contents").style.display = "none";
                break;
            case 1:
                document.getElementById("first-contents").style.display = "none";
                document.getElementById("second-contents").style.display = "block";
                document.getElementById("third-contents").style.display = "none";
                break;
            case 2:
                document.getElementById("first-contents").style.display = "none";
                document.getElementById("second-contents").style.display = "none";
                document.getElementById("third-contents").style.display = "block";
                break;
            case 3:
                alert("완료");
                displayAllData();
                break;
        }
    }

    function validateForm(step) {
        let containerId = '';

        switch (step) {
        	case 0:
        		return true;
            case 1:
                containerId = "first-contents";
                break;
            case 2:
                containerId = "second-contents";
                break;
            case 3:
                containerId = "third-contents";
                break;
            default:
                return false; 
        }

        let inputs = document.querySelectorAll("#" + containerId + " input");

        for (let input of inputs) {
            if (input.value.trim() === "") {
                return false;
            }
        }

        return true;
    }

    function displayAllData() {
        let inputs = document.querySelectorAll('input');
        let data = '';

        for (let i = 0; i < inputs.length; i++) {
            data += inputs[i].name + ": " + inputs[i].value + "\n";
        }

        alert(data);
    }
    
    function dupName(){
        const userId = document.getElementById('userId').value;
        
        $.ajax({
            url: "/vehicle/login/dupCheck.ex",
            type: "POST",
            data: {
            	userId: userId
           		},
            success: function(response){
            	if(response === "false"){
            		document.getElementById("dupCheckValue").value = "false";
            		alert("중복된 아이디입니다.");
                    
            	}else{
                    document.getElementById("dupCheckValue").value = "true";
                    alert("체크 완료.");
            	}
             },
            error: function(xhr, status, error){
              alert(error);
            }
          });
		
    }
    
    function showMailNumber(resultType){
    	if(resultType === "hidden"){
    		document.getElementById("mailNum").style.display = "none";
            document.getElementById("mailNumber").style.display = "none";
    	}else if(resultType === "show"){
    		document.getElementById("mailNum").style.display = "block";
            document.getElementById("mailNumber").style.display = "block";
    	}
    }
</script>
</head>
<body>
    <div class="login-container">
        <h2>회원가입</h2>
        
        <!-- 첫 번째 단계 -->
        <div id="first-contents">
            <form>
                <label for="username">이름</label>
                <input type="text" id="username" name="username" required>
                
                <label for="userId">아이디
                <button id="dupCheck" type="button" class="dup-btn" onclick="dupName()">중복체크</button>
                <input id="dupCheckValue" type="hidden" value="false">
                </label>
                <input type="text" id="userId" name="userId" required>
                
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
                
                <div class="foot-option">
                    <button id="first-button" type="button" class="login-option" onclick="next(1)">다음</button>
                </div>
            </form>
        </div>

        <!-- 두 번째 단계 -->
        <div id="second-contents" style="display: none;">
            <form>
                <label for="email">이메일
                <button id="dupEmail" type="button" class="dup-btn" onclick="dupEmail()">메일인증</button>
                <input id="dupEmailValue" type="hidden" value="false">
                </label>
                <input type="text" id="email" name="email" required>
                
                <label for="mailNum" id="mailNumber">인증번호</label>
                <input type="text" id="mailNum" name="mailNum" required>
                
                <label for="phone">휴대폰</label>
                <input type="text" id="phone" name="phone" required>
                
                <div class="foot-option">
                    <button id="back-button" type="button" class="login-option" onclick="next(0)">이전</button>
                    <button id="next-button" type="button" class="login-option" onclick="next(2)">다음</button>
                </div>
            </form>
        </div>

        <!-- 세 번째 단계 -->
        <div id="third-contents" style="display: none;">
            <form>
                <label for="nickName">닉네임</label>
                <input type="text" id="nickName" name="nickName" required>
                
                <label for="icon">아이콘</label>
                <input type="text" id="icon" name="icon" required>
                
                <div class="foot-option">
                    <button id="back-button" type="button" class="login-option" onclick="next(1)">이전</button>
                    <button type="button" class="login-option" onclick="next(3)">완료</button>
                </div>
            </form>
        </div>

    </div>
</body>
</html>