<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/boo/css/w3.css">
<link rel="stylesheet" type="text/css" href="/boo/css/user.css">
<title>서울시 구별 연평균 증가율</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        var jdata = {};
        var arr = [['자치구', '연평균 증가율']];
        var images = { // 각 자치구와 관련된 이미지를 여기에 추가
            "용산구": "/boo/image/graph/yongsan.png",
            "성동구": "/boo/image/graph/seongdong.png",
            "서초구": "/boo/image/graph/seocho.png",
            "송파구": "/boo/image/graph/songpa.png",
            "강남구": "/boo/image/graph/gangnam.png",
            "영등포구": "/boo/image/graph/yeongdeungpo.png",
            "광진구": "/boo/image/graph/gwangjin.png",
            "강동구": "/boo/image/graph/gangdong.png",
            "마포구": "/boo/image/graph/mapo.png",
            "종로구": "/boo/image/graph/jongno.png",
            "양천구": "/boo/image/graph/yangcheon.png",
            "노원구": "/boo/image/graph/nowon.png",
            "금천구": "/boo/image/graph/geumcheon.png",
            "서대문구": "/boo/image/graph/seodeamoon.png",
            "관악구": "/boo/image/graph/gwanak.png",
            "동대문구": "/boo/image/graph/dongdeamoon.png",
            "동작구": "/boo/image/graph/dongjak.png",
            "구로구": "/boo/image/graph/guro.png",
            "성북구": "/boo/image/graph/seongbook.png",
            "중랑구": "/boo/image/graph/junglang.png",
            "강서구": "/boo/image/graph/gangseo.png",
            "은평구": "/boo/image/graph/eunpyeong.png",
            "중구": "/boo/image/graph/junggu.png",
            "도봉구": "/boo/image/graph/dobong.png",
            "강북구": "/boo/image/graph/gangbook.png",
        };

        $.ajax({
            url: 'https://raw.githubusercontent.com/Blackcatnero1/boodongsan/branch/minkyung/python%20code%E2%98%85/cagr_results.json', //서준님 IP주소(장고)/함수 위치경로 변경 필요
            type: 'get',
            dataType: 'json',
            success: function(obj){
                
                jdata = obj;

                var kList = Object.keys(jdata);

                for(var i = 0 ; i < kList.length ; i++ ){
                    var key = kList[i];
                    var value = jdata[key].CAGR;

                    arr[i+1] = [key, value];
                }
                console.log(arr[2])
                

                setChart(arr);
            }
        });

        function setChart(ar){
            google.charts.load('current', {'packages':['bar']});
            google.charts.setOnLoadCallback(drawStuff);

            function drawStuff() {
                // 데이터
                var data = new google.visualization.arrayToDataTable(ar);
                
                data.sort([{column: 1, desc: true}]);

                var options = {
                    width: 1200,
                    legend: { position: 'none' },
                    hAxis: {
                        title: '아파트 매매가 연평균 증가율(%)(2017~2024)',
                        titleTextStyle: { fontSize: 20, bold: true },
                        textStyle: { fontSize: 10 }
                    },
                    vAxis: {
                        textStyle: { fontSize: 10 }
                    },
                    bar: { groupWidth: "100%" }
                };

                var chart = new google.charts.Bar(document.getElementById('top_x_div'));
                chart.draw(data, google.charts.Bar.convertOptions(options));

                // 그래프 막대에 클릭 이벤트 추가
                google.visualization.events.addListener(chart, 'select', function() {
                    var selection = chart.getSelection();
                    if (selection.length > 0) {
                        var rowIndex = selection[0].row;
                        var key = ar[rowIndex + 1][0]; // 행 인덱스에 해당하는 자치구 이름 가져오기
                        var imageUrl = images[key]; // images에서 자치구에 해당하는 이미지 URL 가져오기

                        if (imageUrl) { // 이미지가 존재하는 경우에만 실행
                            $('#modalImage').attr('src', imageUrl); // id가 modalImage인 src 속성을 imageUrl로 설정
                            $('#imageModal').modal('show'); // id가 imageModal인 모달 창을 표시
                        } else {
                            console.log("Error");
                        }
                    }
                });
            }
        }
    });
</script>
</head>
<body>
	<div id="top_x_div" style="width: 800px; height: 600px; margin-left: 40px; margin-top: 50px;"></div> 

    <!-- 모달 추가 -->
    <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document" style="max-width: 500px">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="imageModalLabel">연도별 평균 매매가 추이(2017~2024)</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <img id="modalImage" src="" alt="연도별 매매가 추이를 알고 싶으면 막대그래프를 선택하세요." class="img-fluid">
                </div>
            </div>
        </div>
    </div>
</body>
</html>
