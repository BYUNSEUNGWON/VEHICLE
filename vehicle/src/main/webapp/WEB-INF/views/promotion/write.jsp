<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style type="text/css">

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

    // 이미지 업로드 함수
    function uploadImage(file) {
        const formData = new FormData();
        formData.append('image', file);

        $.ajax({
            type: 'POST',
            url: '/vehicle/endpoint.ex',  // 서버 업로드 엔드포인트 변경 필요
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                if (response && response.imageUrl) {
                    insertImageUrl(response.imageUrl); // 이미지 URL 삽입
                    alert("이미지가 정상적으로 업로드되었습니다.");
                } else {
                    alert("이미지 업로드에 실패했습니다.");
                }
            },
            error: function (xhr, status, error) {
                console.error("이미지 업로드 오류:", status, error);
                alert("이미지 업로드 중 오류가 발생했습니다.");
            }
        });
    }

    // 이미지 URL을 에디터에 삽입하는 함수
    function insertImageUrl(url) {
	    const imgTag = '<img alt="Uploaded Image" src="' + url + '">';
	    document.execCommand('insertHTML', false, imgTag);
	    editor.focus();  // 에디터에 포커스를 다시 줍니다
	}

    // 클립보드 데이터를 감지하여 이미지 업로드하는 함수
    function handlePaste(event) {
        const clipboardData = (event.clipboardData || window.clipboardData);
        const items = clipboardData.items;
        for (let i = 0; i < items.length; i++) {
            const item = items[i];
            if (item.type.indexOf('image') !== -1) {
                event.preventDefault();
                const file = item.getAsFile();
                uploadImage(file);
            }
        }
    }

    // 에디터에 붙여넣기 이벤트 핸들러 등록
    const editor = document.getElementById('editor');
    editor.addEventListener('paste', handlePaste);

    const btnBold = document.getElementById('btn-bold');
    const btnItalic = document.getElementById('btn-italic');
    const btnUnderline = document.getElementById('btn-underline');
    const btnStrike = document.getElementById('btn-strike');
    const btnOrderedList = document.getElementById('btn-ordered-list');
    const btnUnorderedList = document.getElementById('btn-unordered-list');
    const title = document.getElementById('title');

    btnBold.addEventListener('click', function() { setStyle('bold'); });
    btnItalic.addEventListener('click', function() { setStyle('italic'); });
    btnUnderline.addEventListener('click', function() { setStyle('underline'); });
    btnStrike.addEventListener('click', function() { setStyle('strikeThrough'); });
    btnOrderedList.addEventListener('click', function() { setStyle('insertOrderedList'); });
    btnUnorderedList.addEventListener('click', function() { setStyle('insertUnorderedList'); });

    const wriSubmit = document.getElementById('wri-submit');
    const wriReset = document.getElementById('wri-reset');
    
    // 제출하기 버튼 클릭 시
    const contentEditor = document.getElementById('editor');

	// 제출하기 버튼 클릭 시
	wriSubmit.addEventListener('click', function () {
	    const titleValue = title.value;
	    const contents = contentEditor.innerHTML;  // 에디터 내용 확인
	    const formData = new FormData();
	    
	    formData.append('title', titleValue);
	    formData.append('contents', contents);
	
	    $.ajax({
	        type: 'POST',
	        url: '/vehicle/promotion/submit.ex',
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function (response) {
	            if (response === "성공") {
	                alert("성공적으로 제출되었습니다. 추후 관리자 승인 시 게시글이 올라갈 예정입니다.");
	                window.close();
	            } else {
	                alert("제출에 실패하였습니다.");
	                window.close();
	            }
	        },
	        error: function (xhr, status, error) {
	            alert("요청 오류: " + xhr.status + " " + xhr.statusText + "\n상태: " + status);
	            window.close();
	        }
	    });
	});

    // 초기화 버튼 클릭 시
    wriReset.addEventListener('click', function () {
        editor.blur(); // 에디터에서 포커스 제거
        title.blur();  // 헤더에서 포커스 제거
        editor.innerHTML = ""; // 에디터 내용 비우기
        title.value = ""; // 제목 입력 필드 비우기
        editor.innerHTML = editor.dataset.placeholder;
        editor.classList.add('empty');
    });

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

    editor.addEventListener('keydown', function () { checkStyle(); });
    editor.addEventListener('mousedown', function () { checkStyle(); });
    editor.addEventListener('focus', function () {
        if (editor.classList.contains('empty')) {
            editor.innerHTML = '';
            editor.classList.remove('empty');
        }
    });
    editor.addEventListener('blur', function () {
        if (editor.innerHTML.trim() === '') {
            editor.innerHTML = editor.dataset.placeholder;
            editor.classList.add('empty');
        }
    });

    if (editor.innerHTML.trim() === '') {
        editor.innerHTML = editor.dataset.placeholder;
        editor.classList.add('empty');
    }

    // 스타일 상태를 체크하여 버튼 스타일을 업데이트하는 함수
    function checkStyle() {
        toggleStyleButton('bold', btnBold);
        toggleStyleButton('italic', btnItalic);
        toggleStyleButton('underline', btnUnderline);
        toggleStyleButton('strikeThrough', btnStrike);
        toggleStyleButton('insertOrderedList', btnOrderedList);
        toggleStyleButton('insertUnorderedList', btnUnorderedList);
    }

    // 스타일이 적용된지 여부를 확인하는 함수
    function toggleStyleButton(style, button) {
        if (document.queryCommandState(style)) {
            button.classList.add('active');
        } else {
            button.classList.remove('active');
        }
    }
});
</script>
<body>
    <div class="body-back">
        <div class="header">
            <input id="title" type="text" placeholder=" 제목을 입력하세요..." style="width: 100%; border: 1px solid; border-radius: 5px; height: 30px; padding: 0;">
        </div>

        <div class="middle">
            <div class="editor-menu">
                <button id="btn-bold" class="btnCommon"><b>B</b></button>
                <button id="btn-italic" class="btnCommon"><i>I</i></button>
                <button id="btn-underline" class="btnCommon"><u>U</u></button>
                <button id="btn-strike" class="btnCommon"><s>S</s></button>
                <button id="btn-ordered-list" class="btnCommon">OL</button>
                <button id="btn-unordered-list" class="btnCommon">UL</button>
                <button id="btn-image" class="btnCommon">썸네일</button>
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