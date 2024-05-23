<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>서울 구별 지도 표시</title>
<link rel="stylesheet" type="text/css" href="/boo/css/w3.css">
<link rel="stylesheet" type="text/css" href="/boo/css/user.css">

    <style>
        #map {
            width: 100%;
            height: 863px;
        }
        .area {
            position: absolute;
            background: #fff;
            border: 1px solid #888;
            border-radius: 3px;
            font-size: 12px;
            top: -5px;
            left: 15px;
            padding: 2px;
        }
        .info {
        	padding-left: 5px;
        	width: 200px;
        	height: 300px;
            padding: 5px;
        }
        .title {

        	font-size: 17px;
            font-weight: bold;
        }
        .maemae{

        	font-size: 14px;
        	padding-top:10px
        }
        .chamgo{
        	padding-left: 5px;
        	padding-bottom: 5px;
        	font-size: 11px;
        	color: #007bff;
        }
        .ingu{
        	font-size: 14px;
        
        }
        #guContent{
        	color: darkslategrey;
        	pointer-events: none;
        
        }
        
        
        #guName{
        	font-weight: bold;
        	font-size: 16px;
        
        }
        

        
    </style>
</head>
<body>

<div id="map"></div>
<script type="text/javascript" src="/boo/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=35379a3118419781fdc5be592d7fe272"></script>
<script>
    var areas = []; // 지역 데이터를 담을 배열
    var customOverlays = []; // CustomOverlay 객체를 담을 배열

    function getMaemaeData() {
        return $.getJSON('https://raw.githubusercontent.com/Blackcatnero1/boodongsan/branch/Seojun98/maemaega.json');
    }

    // 서울시 행정구역 데이터를 불러오는 함수
    $.getJSON('https://raw.githubusercontent.com/Blackcatnero1/boodongsan/main/Seojun98/seoul_municipalities_geo_simple.json', function(data) {
        var features = data.features;
        for (var i = 0; i < features.length; i++) {
            var name = features[i].properties.name; // 지역 이름
            var coordinates = features[i].geometry.coordinates[0].map(function (coord) {
                return new kakao.maps.LatLng(coord[1], coord[0]); // 경위도 좌표로 변환
            });
            
            areas.push({ name: name, path: coordinates }); // areas 배열에 지역 데이터 추가
        }

        // 서울시 행정구역 데이터를 기반으로 지도에 영역데이터를 폴리곤으로 표시합니다 
        displayAreas();
    });

    function displayAreas() {
        var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
        var mapOption = { 
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 8, // 지도의 확대 레벨
            minLevel: 6,
            maxLevel: 9
        };

        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 객체 생성
        
        var infowindow = new kakao.maps.InfoWindow({removable: true}); // 인포윈도우 생성

        getMaemaeData().then(function(maemaeData) {
            for (var i = 0, len = areas.length; i < len; i++) {
                var area = areas[i];
                var maemaePrice = maemaeData.find(item => item.자치구명 === area.name).평당매매가; // 해당 지역의 평당매매가
                var guIngu = maemaeData.find(item => item.자치구명 === area.name).인구;

                var overlayContent = document.createElement('div');
                overlayContent.className = 'overlay-content';
                overlayContent.innerHTML = '<div class="w3-center" style="font-weight: bold; font-size: 16px; color:rgb(255, 255, 225);">' + area.name + '</div>' +
                                           '</div>';

                var polygonCenter = getPolygonCenter(area.path);

                var customOverlay2 = new kakao.maps.CustomOverlay({
                    position: polygonCenter,
                    content: overlayContent,
                    xAnchor: 0.3,
                    yAnchor: 0.91
                });
                customOverlay2.setMap(map); // 다각형 생성 후 customOverlay2를 지도에 추가
                customOverlays.push(customOverlay2); // 배열에 추가
                
                // 다각형을 생성합니다 
                var polygon = new kakao.maps.Polygon({
                    map: map, // 다각형을 표시할 지도 객체
                    path: area.path,
                    strokeWeight: 3,
                    strokeColor: 'springgreen',
                    strokeOpacity: 0.8,
                    fillColor: 'purple',
                    fillOpacity: 0.17 * (guIngu / 100000)
                });

                // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
                // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
                kakao.maps.event.addListener(polygon, 'mouseover', (function(polygon, area, customOverlay2) {
                    return function(mouseEvent) {
                        polygon.setOptions({fillColor: '#09f'});

                        var customOverlay = new kakao.maps.CustomOverlay({
                            content: '<div class="area">' + area.name + '</div>',
                            position: mouseEvent.latLng,
                            map: map
                        });

                        customOverlay2.setMap(null);
                        customOverlay.setMap(map);

                        kakao.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
                            customOverlay.setPosition(mouseEvent.latLng);
                        });

                        kakao.maps.event.addListener(polygon, 'mouseout', function() {
                            polygon.setOptions({fillColor: 'purple'});
                            customOverlay.setMap(null);
                            customOverlay2.setMap(map); // mouseout 시 customOverlay2 다시 추가
                        });
                    };
                })(polygon, area, customOverlay2));

                // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 평당매매가를 인포윈도우에 표시합니다 
                kakao.maps.event.addListener(polygon, 'click', (function(polygon, area, maemaePrice) {
                    return function(mouseEvent) {
                        var content = '<div class="info">' + 
                                    '   <div class="w3-border-bottom title">' + area.name + '</div>' +
                                    '   <div class="w3-padding-top maemae">평당 매매가 : ' + Number(maemaePrice).toLocaleString() + ' 만원</div>' +
                                    ' 	<div class="chamgo">* 2023년 평균 매매가 기준 *</div>' + 
                                    '	<div class="ingu"> 인구 : ' + Number(guIngu).toLocaleString() + '명</div>' +
                                    '</div>';

                        infowindow.setContent(content); 
                        infowindow.setPosition(mouseEvent.latLng); 
                        infowindow.setMap(map);
                    };
                })(polygon, area, maemaePrice));
            }
        });
    }

    function getPolygonCenter(path) {
        var sumLat = 0;
        var sumLng = 0;
        var len = path.length;

        for (var i = 0; i < len; i++) {
            sumLat += path[i].getLat();
            sumLng += path[i].getLng();
        }

        return new kakao.maps.LatLng(sumLat / len, sumLng / len - 0.005);
    }
</script>
</body>
</html>