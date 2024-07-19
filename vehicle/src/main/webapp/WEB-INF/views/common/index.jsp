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
  position : absolute;
  width: 17px;
  top: 10px;
  right: 1%;
  margin: 0;
}

</style>
</head>
<body>

    <div class="secNav">
	    <div class="search">
			<input type="text" placeholder="검색어를 입력하여 주세오.">
		 	<img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
		</div>
    </div>

    <div id="map" style="margin-left:28%;padding:1px 16px;height:1000px;"></div>
    
    
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e41c2ad46b1eb9e6f6108f89aca1da7c"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(36.0134925, 129.3479143), // 지도의 중심좌표
        level: 2 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 title 객체 배열입니다 
var positions = [
    {
        title: '배용식자동차병원', 
        latlng: new kakao.maps.LatLng(36.01448903, 129.347004)
    },
    {
        title: '생태연못', 
        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
    },
    {
        title: '텃밭', 
        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
    },
    {
        title: '근린공원',
        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
    }
];

// 마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
}
</script>
</body>
</html> 