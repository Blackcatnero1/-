<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/css/w3.css">
<link rel="stylesheet" type="text/css" href="/css/user.css">
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
            "강남구": "/image/graph/gangnam.png",
            "강동구": "/image/graph/gangdong.png",
            "강북구": "/image/graph/gangbook.png",
            "강서구": "/image/graph/gangseo.png",
            "관악구": "/image/graph/gwanak.png",
            "광진구": "/image/graph/gwangjin.png",
            "구로구": "/image/graph/guro.png",
            "금천구": "/image/graph/geumcheon.png",
            "노원구": "/image/graph/nowon.png",
            "도봉구": "/image/graph/dobong.png",
            "동대문구": "/image/graph/dongdeamoon.png",
            "동작구": "/image/graph/dongjak.png",
            "마포구": "/image/graph/mapo.png",
            "서대문구": "/image/graph/seodeamoon.png",
            "서초구": "/image/graph/seocho.png",
            "성동구": "/image/graph/seongdong.png",
            "성북구": "/image/graph/seongbook.png",
            "송파구": "/image/graph/songpa.png",
            "양천구": "/image/graph/yangcheon.png",
            "영등포구": "/image/graph/yeongdeungpo.png",
            "용산구": "/image/graph/yongsan.png",
            "은평구": "/image/graph/eunpyeong.png",
            "종로구": "/image/graph/jongno.png",
            "중구": "/image/graph/junggu.png",
            "중랑구": "/image/graph/junglang.png",
        };

        $.ajax({
            url: 'http://58.72.151.124:6012/getNums/', //서준님 IP주소(장고)/함수 위치경로 변경 필요
            type: 'get',
            dataType: 'json',
            success: function(obj){
                console.log('obj : ' + obj);
                jdata = obj['CAGR'];

                var kList = Object.keys(jdata);

                for(var i = 0 ; i < kList.length ; i++ ){
                    var key = kList[i];
                    var value = jdata[key];

                    arr[i+1] = [key, value];
                }

                setChart(arr);
            }
        });

        function setChart(ar){
            google.charts.load('current', {'packages':['bar']});
            google.charts.setOnLoadCallback(drawStuff);

            function drawStuff() {
                // 데이터
                var data = new google.visualization.arrayToDataTable(ar);

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
                            console.log("이미지가 존재하지 않습니다.");
                        }
                    }
                });
            }
        }
    });
</script>
</head>
<body>
    <div id="top_x_div" style="width: 800px; height: 600px;"></div>

    <!-- 모달 추가 -->
    <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
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
