<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="boo/css/w3.css">
<link rel="stylesheet" type="text/css" href="boo/css/user.css">
<script type="text/javascript" src="boo/js/jquery-3.7.1.min.js"></script>
<style type="text/css">
    #map {
         width: 100%;
         height: 863px;
         padding:0px;
         margin:0px;
     }
     
</style>
</head>
<body>

<div id="map"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=35379a3118419781fdc5be592d7fe272&libraries=services"></script>
<script>

	var SwInfowindow = new kakao.maps.InfoWindow({zIndex:1});
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(0, 0), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨

        };  
    
    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption); 
    
	// 지도에 확대 축소 컨트롤을 생성한다
	var zoomControl = new kakao.maps.ZoomControl();

	// 지도의 우측에 확대 축소 컨트롤을 추가한다
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
    
    
    
    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();
    
 	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(map);
 	var juso = "${DATA.juso}";
    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(juso, function(result, status) {
    
        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {
    
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
    
            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

    
            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0; font-weight: bold;">' + result[0].road_address.building_name + '</div>'
            });
            infowindow.open(map, marker);
            
    	    kakao.maps.event.addListener(marker, 'click', function() {
    	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
    	        infowindow.setContent('<div style="width:150px;text-align:center;padding:6px 0; font-weight: bold;">' + result[0].road_address.building_name + '</div>');
    	        infowindow.open(map, marker);
    	    });
            

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
            
         // 카테고리로 지하철을 검색합니다
        	ps.categorySearch('SW8', placesSearchCB, {location: coords, radius: 1100}); 
        	
        	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
        	function placesSearchCB (data, status, pagination) {
        	    if (status === kakao.maps.services.Status.OK) {
        	        for (var i=0; i<data.length; i++) {
        	            displayMarker(data[i]);    
        	        }       
        	    }
        	}
        	
        	// 지도에 마커를 표시하는 함수입니다
        	function displayMarker(place) {
        		
        		
        		var markerImageUrl = 'https://t1.daumcdn.net/localimg/localimages/07/2012/img/marker_p.png', 
    		    markerImageSize = new kakao.maps.Size(35, 37), // 마커 이미지의 크기
    		    markerImageOptions = { 
    		        offset : new kakao.maps.Point(11, 37)// 마커 좌표에 일치시킬 이미지 안의 좌표
    		    };
        		
        		var markerImage = new kakao.maps.MarkerImage(markerImageUrl, markerImageSize, markerImageOptions);
        		
        	    // 마커를 생성하고 지도에 표시합니다
        	    var marker = new kakao.maps.Marker({
        	        map: map,
        	        image : markerImage,
        	        position: new kakao.maps.LatLng(place.y, place.x) 
        	    });
        	
        	    // 마커에 클릭이벤트를 등록합니다
        	    kakao.maps.event.addListener(marker, 'click', function() {
        	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        	        infowindow.setContent('<div style="padding:5px;text-align:center;font-size:12px;">' + place.place_name + '</div>');
        	        infowindow.open(map, marker);
        	    });
        	}
            
            
            
            
        }        
    });

</script>
</body>
</html>