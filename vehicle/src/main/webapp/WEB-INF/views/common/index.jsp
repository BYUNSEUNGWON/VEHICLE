<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/navBar.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>포항 자동차 정비 업체 모아보기</title>
<style>

.secNav {
  margin-left: 10%;
  background-color: white;
  position: fixed;
  height: 100%;
  width: 18%;
  border-right: #cdcdcd solid 1px;
  text-align: center;
  overflow-y: auto;
}

.search {
  position: relative;
  width: 80%;
  margin-left: 5%;
  margin-top: 5%;
}

input {
  width: 100%;
  border: 1px solid #bbb;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 14px;
}

img {
  position: absolute;
  width: 17px;
  top: 10px;
  right: 0;
  margin: 0;
  margin-right: -5px; /* 필요에 따라 값을 조정하세요 */
}

#searchResults {
  width: 100%;
  margin-left: 5%;
  margin-top: 5%;
}

.keywordList {
  cursor: pointer;
  color: black;
}

.keywordList:hover {
  background-color: #D3D3D3;
}

.active {
  background-color: #D3D3D3;
}
.infobox {
   padding: 10px; 
   border: 2px solid black; 
   background: white; 
   border-radius: 5px;
   font-size: 14px; /* 텍스트 크기 */
   box-shadow: 3px 3px 5px rgba(0,0,0,0.3); /* 그림자 효과 */
}
.copyable {
  cursor: pointer;
  color: black;
  position: relative;
}

.copyable:hover {
  color: blue;
}

.tooltip {
  visibility: hidden;
  width: 80px;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 5px;
  padding: 5px;
  position: absolute;
  z-index: 1;
  bottom: 100%; /* 위로 위치 */
  left: 50%;
  margin-left: -40px; /* 중앙 정렬 */
  opacity: 0;
  transition: opacity 0.3s;
}

.copyable:hover .tooltip {
  visibility: visible;
  opacity: 1;
}
</style>
</head>
<body>
    <div class="secNav">
	    <div class="search">
			<input type="text" id="searchInput" placeholder="주소, 이름을 입력하여 주세오.">
		 	<img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
	 	    <div id="searchResults">
	 	    </div> 	
		</div>
		
		<!-- 해당 api가 위도, 경도 구해주는 정확도가 많이 떨어져서... 일단은 주석 처러.. -->
		<!-- <button id="getCurrentLocationButton">내위치찾기</button>  -->
    </div>

    <div id="map" style="margin-left:28%;padding:1px 16px;height:1000px;">
    </div>

<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>    
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e41c2ad46b1eb9e6f6108f89aca1da7c"></script>
<script>

function getCurrentLocation() {
	var options = {
	  enableHighAccuracy: true,
	  maximumAge: 30000,
	  timeout: 27000
	};

	if (navigator.geolocation) {
	  navigator.geolocation.getCurrentPosition(function(position) {
	    var lat = position.coords.latitude;
	    var lng = position.coords.longitude;

	    console.log("lat ===> " + lat);
	    console.log("lng ===> " + lng);
	    
	    var mapContainer = document.getElementById('map');
	    var mapOption = { 
	      center: new kakao.maps.LatLng(lat, lng),
	      level: 2
	    };

	    var map = new kakao.maps.Map(mapContainer, mapOption);
	  }, function(error) {
	    console.log('Error occurred: ' + error.code);
	  }, options);
	} else {
	  alert("Geolocation is not supported by this browser.");
	}
  }

function makePosition(itemList) {
	
	// 마커를 표시할 위치와 title 객체 배열입니다
	var position = [];
	
	for(var i = 0; i < itemList.length; i++){
		
		var item = itemList[i];
	    var lat = item.latitude;
	    var lng = item.hardness;
	    var title = item.company;
	    
	    var pos = {
	        title: title,
	        latlng: new kakao.maps.LatLng(lat, lng)
	    };
	    
	    position.push(pos);
	}
	
	callKakao(position, null, null)
}

function makeDiv(title, number, addr, bizDt){
	
	if(title == null || title == ""){
		title = "미등록";
	}
	if(number == null || number == ""){
		number = "미등록";
	}
	if(addr == null || addr == ""){
		addr = "미등록";
	}
	if(bizDt == null || bizDt == ""){
		bizDt = "미등록";
	}
	// 현재 날짜 객체 생성
	var currentDate = new Date();
	// 현재 연도 가져오기
	var currentYear = currentDate.getFullYear();
	
	var career = bizDt.substr(0,4);
	
	career = currentYear - career + 1;
	
    var result = '<div style="padding:5px; border:1px solid black; background:white; width: 200px; text-align: center;">' +
    '<div style="margin-top: 10px;">' + title + '</div>' + '<hr/>' +
    '<div class="copyable" style="margin: 5%;" onclick="copyToClipboard(\'' + number + '\')">전화번호 : ' + number + 
      '<span class="tooltip">복사하기</span>' + 
    '</div>' +
    '<div class="copyable" style="margin: 5%; word-break: break-word; white-space: normal;" onclick="copyToClipboard(\'' + addr + '\')">주소 : ' + addr + 
      '<span class="tooltip">복사하기</span>' + 
    '</div>' +
    '<div style="margin: 5%; word-break: break-word; white-space: normal;">사업자등록 : ' + bizDt + '</div>' +
    '<div style="margin: 5%; word-break: break-word; white-space: normal;">오픈(만) : ' + career + '년 </div>' +
    '</div>';

  return result;
}

function copyToClipboard(text) {
  navigator.clipboard.writeText(text).then(function () {
	  alert("복사가 완료되었습니다.");
  }, function (err) {
	  alert("복사실패 이유 : " + err);
  });
}

function callKakao(positions, lat, hard){
	
	if(lat == null) lat = 36.0134925;
	if(hard == null) hard = 129.3479143;
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(lat, hard), // 지도의 중심좌표
	        level: 2 // 지도의 확대 레벨
	    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	var lastOpenedInfobox = null;

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	 	// 새로운 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title: positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image: markerImage // 마커 이미지
	    });

	    // 마커에 클릭 이벤트를 추가합니다
	    kakao.maps.event.addListener(marker, 'click', function () {
	    	
	        var title = this.getTitle();
	        var position = this.getPosition();
	        
	        $.ajax({
	            url: "/vehicle/itemSel.ex",
	            type: "GET",
	            dataType : "json",
	            data : { 'title': title },
	            success: function(response){
	            	
	    			var number = response[0].number;		// 매장 전화번호
	    			var addr = response[0].map_addr_nm;		// 매장 주소
	    			var bizDt = response[0].biz_regist_dt;	// 사업자 등록 일자
	    			
	    			// 인포박스 내용을 설정합니다
	    	        var infoboxContent = makeDiv(title, number, addr, bizDt);
	                          
	    	        var infobox = new kakao.maps.CustomOverlay({
	    	            content: infoboxContent,
	    	            map: null,  // 초기에는 인포박스를 보이지 않도록 설정합니다.
	    	            position: position,
	    	            xAnchor: 0.5,
	    	            yAnchor: 1.2
	    	        });
	    	        
	    	        // 기존에 열려있던 인포박스가 있다면 닫습니다
	    	        if (lastOpenedInfobox !== null) {
	    	            lastOpenedInfobox.setMap(null);
	    	        }

	    	        // 새 인포박스를 열고, 이를 마지막으로 열린 인포박스로 갱신합니다
	    	        infobox.setMap(map);
	    	        lastOpenedInfobox = infobox;
	             },
	            error: function(xhr, status, error){
	              console.log(error);
	            }
	          });
	        
	                  
           
	    });
	   
	}
}

$(document).ready(function(){
	
	$.ajax({
        url: "/vehicle/item.ex",
        type: "POST",
        success: function(response){
			makePosition(response);
         },
        error: function(xhr, status, error){
          console.log(error);
        }
      });
	

    var getCurrentLocationButton = document.querySelector('#getCurrentLocationButton');
    getCurrentLocationButton.addEventListener('click', getCurrentLocation);
   
});

var currentTag = null;

function keywordClick(element, paramList){
	
    if (currentTag !== null) {
        currentTag.classList.remove("active");
    }

    element.classList.add("active");
    currentTag = element;
	
    var arr = paramList.split(",");
    var company = arr[0];  // 상호명
    var latitude = arr[1]; // 위도
    var hardness = arr[2]; // 경도
    
    var position = [];
    
    var pos = {
	        title: company,
	        latlng: new kakao.maps.LatLng(latitude, hardness)
	    };
    
    position.push(pos);
    

	console.log("position -->", position);
	console.log("latitude -->", latitude);
	console.log("hardness -->", hardness);
    
    callKakao(position, latitude, hardness);

}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('searchInput').addEventListener('input', function() {
    var keyword = this.value;

    fetch('/vehicle/search.ex?keyword=' + keyword)
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            var searchResultsHtml = '';
            // 검색 데이터
			console.log("data --> " , data);
            for (var i = 0; i < data.length; i++) {
            	var paramList = []
            	paramList.push(data[i].company)
            	paramList.push(data[i].latitude)
            	paramList.push(data[i].hardness)
            	searchResultsHtml += '<div class="keywordList" style="margin:5%;" onclick="keywordClick(this, \'' + paramList + '\');"> ' + data[i].company + '</div>';
            }
            document.getElementById('searchResults').innerHTML = searchResultsHtml;
        });
    });
});



</script>
</body>
</html> 