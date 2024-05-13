<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>서울 구별 지도 표시</title>
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">

    <style>
        #map {
            width: 100%;
            height: 1000px;
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
        	width: 200px;
        	height: 100px;
            padding: 5px;
        }
        .title {
        	padding-left: 5px;
        	font-size: 17px;
            font-weight: bold;
        }
        .maemae{
        	padding-left: 5px;
        	font-size: 14px;
        	padding-top:10px
        }
        .chamgo{
        	padding-left: 5px;
        	font-size: 11px;
        	color: #007bff;
        	padding-top:8px
        }
    </style>
</head>
<body>

<div id="map"></div>
<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=#######카카오 자바스크립트키######"></script>
<script>
    var areas = []; // 지역 데이터를 담을 배열
    
    function getMaemaeData() {
        return $.getJSON('https://raw.githubusercontent.com/Blackcatnero1/boodongsan/main/Seojun98/maemaega.json');
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
            level: 8 // 지도의 확대 레벨
        };

        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 객체 생성
        var customOverlay = new kakao.maps.CustomOverlay({}); // 커스텀 오버레이 생성
        var infowindow = new kakao.maps.InfoWindow({removable: true}); // 인포윈도우 생성

        getMaemaeData().then(function(maemaeData) {
            for (var i = 0, len = areas.length; i < len; i++) {
                var area = areas[i];
                var maemaePrice = maemaeData.find(item => item.자치구명 === area.name).평당매매가; // 해당 지역의 평당매매가

                // 다각형을 생성합니다 
                var polygon = new kakao.maps.Polygon({
                    map: map, // 다각형을 표시할 지도 객체
                    path: area.path,
                    strokeWeight: 3,
                    strokeColor: '#ff69b4',
                    strokeOpacity: 0.8,
                    fillColor: '#f0f0f0',
                    fillOpacity: 0.6 
                });

                // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
                // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
                kakao.maps.event.addListener(polygon, 'mouseover', (function(polygon, area) {
                    return function(mouseEvent) {
                        polygon.setOptions({fillColor: '#09f'});

                        customOverlay.setContent('<div class="area">' + area.name + '</div>');
                        
                        customOverlay.setPosition(mouseEvent.latLng); 
                        customOverlay.setMap(map);
                    };
                })(polygon, area));

                // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다
                kakao.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
                    customOverlay.setPosition(mouseEvent.latLng); 
                });

                // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
                // 커스텀 오버레이를 지도에서 제거합니다 
                kakao.maps.event.addListener(polygon, 'mouseout', (function(polygon, area) {
                    return function(mouseEvent) {
                        polygon.setOptions({fillColor: '#f0f0f0'});
                        customOverlay.setMap(null);
                    };
                })(polygon, area));

                // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 평당매매가를 인포윈도우에 표시합니다 
                kakao.maps.event.addListener(polygon, 'click', (function(polygon, area, maemaePrice) {
                    return function(mouseEvent) {
                        var content = '<div class="info">' + 
                                    '   <div class="w3-border-bottom title">' + area.name + '</div>' +
                                    '   <div class="w3-padding-top maemae">평당 매매가 : ' + maemaePrice + ' 만원</div>' +
                                    ' 	<div class="chamgo">* 2023년 평균 매매가 기준 *</div>'
                                    '</div>';

                        infowindow.setContent(content); 
                        infowindow.setPosition(mouseEvent.latLng); 
                        infowindow.setMap(map);
                    };
                })(polygon, area, maemaePrice));
            }
        });
    }
</script>
</body>
</html>