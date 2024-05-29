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
        padding-left: 0px;
        width: 220px;
        height: 145px;
        padding: 0px;
    }
    .title {
        font-size: 17px;
        font-weight: bold;
    }
    .price {
        font-size: 14px;
        padding-top: 10px;
        padding-bottom: 9px;
        
    }
    .note {
    
    	padding-top:10px;
    	padding-bottom: 12px;
        font-size: 11px;
        color: #007bff;
    }
    .population {
        font-size: 14px;
        padding-bottom:5px;
        
    }
    #guContent {
        color: darkslategrey;
        pointer-events: none;
    }
    #guName {
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

    // 지도에 표시할 데이터들의 배열
    var combinedData = [];

    // JSTL을 사용하여 서버 데이터를 JavaScript 객체로 변환
    <c:forEach var="item" items="${AreaDATA}">
        combinedData.push({
            sgg_nm: "${item.sgg_nm}",
            avg_per_area: ${item.avg_per_area},
            p_total: ${item.p_total}
        });
    </c:forEach>;

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

        // 서울시 행정구역 데이터를 기반으로 지도에 영역데이터를 폴리곤으로 표시 
        displayAreas();
    });

    function displayAreas() {
        var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
        var mapOption = { 
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 8, // 지도의 확대 레벨
            minLevel: 6, // 지도의 최소 확대 레벨 
            maxLevel: 9 // 지도의 최대 확대 레벨 
        };

        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 객체 생성
        
        var infowindow = new kakao.maps.InfoWindow({removable: true}); // 인포윈도우 생성

        for (var i = 0, len = areas.length; i < len; i++) {
            var area = areas[i];
            var dataItem = combinedData.find(item => item.sgg_nm === area.name);
            if (dataItem) {
                var price = dataItem.avg_per_area; // 해당 지역의 평당매매가
                var population = dataItem.p_total; // 해당 지역의 총 인구수

                
                // 자치구 이름 오버레이
                var overlayContent = document.createElement('div');
                overlayContent.className = 'overlay-content';
                overlayContent.innerHTML = '<div class="w3-center" style="font-weight: bold; font-size: 16px; color:rgb(255, 255, 225);">' + area.name + '</div>' +
                                           '</div>';

                var polygonCenter = getPolygonCenter(area.path);

                
                var customOverlay2 = new kakao.maps.CustomOverlay({
                    position: polygonCenter,
                    content: overlayContent,
                    xAnchor: 0.3,
                    yAnchor: 0.91,
                    zIndex: -1
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
                    fillColor: '#E91E63',
                    fillOpacity: 0.17 * (population / 100000)
                });

                // 다각형에 mouseover 이벤트를 등록
                // 지역명을 표시하는 커스텀오버레이를 지도위에 표시
                kakao.maps.event.addListener(polygon, 'mouseover', (function(polygon, area, customOverlay2) {
                    return function(mouseEvent) {
                        polygon.setOptions({fillColor: '#09f'});

                        
                        // 커서가 올라갔을때 구이름 표시 오버레이 내용
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
                            polygon.setOptions({fillColor: '#E91E63'});
                            customOverlay.setMap(null);
                            customOverlay2.setMap(map); // mouseout 시 customOverlay2 다시 추가
                        });
                    };
                })(polygon, area, customOverlay2));

                // 다각형에 click 이벤트 등록
                kakao.maps.event.addListener(polygon, 'click', (function(polygon, area, price, population) {
                    return function(mouseEvent) {
                    	// 클릭시 보여줄 데이터
                        var content = '<div class="info w3-card-4 w3-border-pink w3-border w3-thick">' + 
                                    '   <div class="w3-border w3-border-pink w3-pink w3-padding title">' + area.name + '</div>' +
                                    '   <div class="w3-padding-top price" style="padding-left:8px;">평당 매매가 : ' + Number(price).toLocaleString() + ' 만원</div>' +
                                    '   <div class="population" style="padding-left:8px;"> 인구 : ' + Number(population).toLocaleString() + '명</div>' +
                                    '   <div class="note w3-center">* 2023년 서울시 데이터 포털 기준 *</div>' + 
                                    '</div>';
                                
		                        infowindow.setContent(content); 
		                        infowindow.setPosition(mouseEvent.latLng); 
		                        infowindow.setMap(map);
                    };
                })(polygon, area, price, population));
            }
        }
    }

    //다각형의 중심을 구하는 함수
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