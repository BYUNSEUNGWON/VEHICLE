<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style type="text/css">
<style>

    div#editor {
        padding: 16px 24px;
        border: 1px solid #D6D6D6;
        border-radius: 4px;
    }
    
    #img-selector {
        display: none;
    }
    
    #editor img {
        max-width: 100%;
    }
    
    button.active {
        background-color: purple;
        color: #FFF;
    }
    .middle {
    	margin-bottom: 10%;
    }
    .header {
    	margin-top: 3%;
    }
    .header input[type="text"]::placeholder {
        font-weight: bold;
    }
    
    .body-back {
    	background-color: white;
    	margin-left: 10%;
    	margin-right: 10%;
    }
    
    .sub-btn {
	    display: flex;
	    justify-content: flex-end;
	}
	
	.sub-btn button {
	    width: 100px;
	    height: 40px;
	    margin-left: 10px;
	}
	
	.editor-menu {
		margin-top: 1%;
		margin-bottom: 1%;
	}
	
	.btnCommon {
		height: 30px;
	}
	
</style>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
        crossorigin="anonymous"></script>
<script type="text/javascript">
    $(document).ready(function () {

        const editor = document.getElementById('editor');
        const btnBold = document.getElementById('btn-bold');
        const btnItalic = document.getElementById('btn-italic');
        const btnUnderline = document.getElementById('btn-underline');
        const btnStrike = document.getElementById('btn-strike');
        const btnOrderedList = document.getElementById('btn-ordered-list');
        const btnUnorderedList = document.getElementById('btn-unordered-list');
        const title = document.getElementById('title');
        
        var uploadedFile = null;


        btnBold.addEventListener('click', function () {
            setStyle('bold');
        });

        btnItalic.addEventListener('click', function () {
            setStyle('italic');
        });

        btnUnderline.addEventListener('click', function () {
            setStyle('underline');
        });

        btnStrike.addEventListener('click', function () {
            setStyle('strikeThrough')
        });

        btnOrderedList.addEventListener('click', function () {
            setStyle('insertOrderedList');
        });

        btnUnorderedList.addEventListener('click', function () {
            setStyle('insertUnorderedList');
        });

        const btnImage = document.getElementById('btn-image');
        const imageSelector = document.getElementById('img-selector');
        
        // 이미지 버튼 클릭 이벤트 핸들러
        btnImage.addEventListener('click', function () {
            imageSelector.click();
        });
        
        // 이미지 선택 시 이벤트 핸들러
        imageSelector.addEventListener('change', function (e) {
            const files = e.target.files;
            if (!!files && files.length > 0) { // 선택된 파일이 있는지 확인합니다.
                insertImageData(files[0]);
            }
            alert("정상적으로 선택되었습니다.");
        });

        // 에디터 키 누름 이벤트 핸들러
        editor.addEventListener('keydown', function () {
            checkStyle();
        });
        
        // 에디터 마우스 클릭 이벤트 핸들러
        editor.addEventListener('mousedown', function () {
            checkStyle();
        });
        
     	// 편집 가능한 요소에 포커스 이벤트 리스너 추가
        editor.addEventListener('focus', function () {
            if (editor.classList.contains('empty')) {
                editor.innerHTML = '';
                editor.classList.remove('empty');
            }
        });

        // 편집 가능한 요소에 포커스 아웃 이벤트 리스너 추가
        editor.addEventListener('blur', function () {
            if (editor.innerHTML.trim() === '') {
                editor.innerHTML = editor.dataset.placeholder;
                editor.classList.add('empty');
            }
        });

        // 초기화 시 비어있는지 체크
        if (editor.innerHTML.trim() === '') {
            editor.innerHTML = editor.dataset.placeholder;
            editor.classList.add('empty');
        }

        // 이미지 데이터를 삽입하는 함수
        function insertImageData(file) {
        	const reader = new FileReader();
            uploadedFile = file; 
            console.log("이미지 파일이 준비되었습니다.");
        }

        // 스타일 설정 함수
        function setStyle(style) {
            document.execCommand(style);
            focusEditor();
            checkStyle();
        }
        

        // 에디터에 포커스를 주는 함수
        function focusEditor() {
            editor.focus({ preventScroll: true });
        }

        // 스타일 상태를 체크하여 버튼 스타일을 업데이트하는 함수
        function checkStyle() {
            if (isStyle('bold')) {
                btnBold.classList.add('active');
            } else {
                btnBold.classList.remove('active');
            }
            if (isStyle('italic')) {
                btnItalic.classList.add('active');
            } else {
                btnItalic.classList.remove('active');
            }
            if (isStyle('underline')) {
                btnUnderline.classList.add('active');
            } else {
                btnUnderline.classList.remove('active');
            }
            if (isStyle('strikeThrough')) {
                btnStrike.classList.add('active');
            } else {
                btnStrike.classList.remove('active');
            }
            if (isStyle('insertOrderedList')) {
                btnOrderedList.classList.add('active');
            } else {
                btnOrderedList.classList.remove('active');
            }
            if (isStyle('insertUnorderedList')) {
                btnUnorderedList.classList.add('active');
            } else {
                btnUnorderedList.classList.remove('active');
            }
        }

        // 스타일이 적용된지 여부를 확인하는 함수
        function isStyle(style) {
            return document.queryCommandState(style);
        }
        
        const wriSubmit = document.getElementById('wri-submit');
        const wriReset = document.getElementById('wri-reset');
        
        // 제출하기 버튼 클릭 시
        wriSubmit.addEventListener('click', function () {
        	
            const title = document.getElementById('title').value;
            const contents = document.getElementById('editor').innerHTML;
            const formData = new FormData();
            
            formData.append('title', title);
            formData.append('contents', contents);
            if (uploadedFile) { // 업로드된 파일이 있는 경우에만 추가합니다.
                formData.append('image', uploadedFile);  
            }
            
            $.ajax({
                type: 'POST',
                url: '/vehicle/promotion/submit.ex',
                data: formData,                    
                processData: false,
                contentType: false,
                success: function (response) {
                    if(response == "성공"){
                        alert("성공적으로 제출되었습니다. 추후 관리자 승인 시 게시글이 올라갈 예정입니다.");
                        window.close();
                    } else{
                    	alert("제출에 실패하였습니다.");
                        window.close();
                    }
                },
                error: function (xhr, status, error) {
                    alert("요청 오류: " + xhr.status + " " + xhr.statusText + "\n" +
                            "상태: " + status);
                      window.close();
                }
            });
        }); 
        
     	// 초기화 버튼 클릭 시
        wriReset.addEventListener('click', function () {
            editor.blur(); // 에디터에서 포커스 제거
            title.blur();	// 헤더에서 포커스 제거
        	editor.innerHTML = ""; // 에디터 내용 비우기
            title.value = ""; // 제목 입력 필드 비우기
            editor.innerHTML = editor.dataset.placeholder;
            editor.classList.add('empty');
        });
        

    });
</script>
<body>
	<div class="body-back">
		<div class="header">
			<input id="title" type="text" placeholder=" 제목을 입력하세요..." style="width: 100%; border: 1px solid; border-radius: 5px; height: 30px; padding: 0;">
		</div>
	
		<div class="middle">
		    <div class="editor-menu">
		        <button id="btn-bold" class="btnCommon">
		            <b>B</b>
		        </button>
		        <button id="btn-italic" class="btnCommon">
		            <i>I</i>
		        </button>
		        <button id="btn-underline" class="btnCommon">
		            <u>U</u>
		        </button>
		        <button id="btn-strike" class="btnCommon">
		            <s>S</s>
		        </button>
		        <button id="btn-ordered-list" class="btnCommon">
		            OL
		        </button>
		        <button id="btn-unordered-list" class="btnCommon">
		            UL
		        </button>
		        <button id="btn-image" class="btnCommon">
		           썸네일
		       </button>
		    </div>
		    <input id="img-selector" type="file" accept="image/*" />
		    
		    <div id="editor" contenteditable="true" style="border: 1px solid; border-radius: 5px; height: 1000px;" data-placeholder="내용을 입력하세요..."></div>
		    
		    <div class="sub-btn">
		        <button type="reset" id="wri-reset" style="margin-top: 3%;">초기화</button>
		        <button type="submit" id="wri-submit" style="margin-top: 3%;">제출하기</button>
		    </div>
	    </div>
    </div>
</body>
</html>