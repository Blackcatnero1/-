<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>W3.CSS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" type="text/css" href="/boo/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/boo/css/user.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="/boo/js/jquery-3.7.1.min.js"></script>
    <style>
        .center-container {
			  margin: 0 auto;
			  max-width: 800px;
			  text-align: center;
			  padding-top: 32px;
			  background-size: 800px;
			  background-repeat: no-repeat;
			  background-position: bottom; /* 배경 이미지를 아래쪽으로 이동 */
			  color: black; /* 텍스트의 색상을 검은색으로 설정 */
			}

		
		
		.w3-border-bottom {
		  border-bottom-color: black!important; /* 밑줄 색상을 설정 */
		}
		
		.form-container {
            display: flex;
            justify-content: center;
            align-items: flex-end; /* 하단 정렬로 변경 */
            gap: 10px;
            flex-wrap: wrap;
        }
        .form-container .w3-section {
            margin: 0;
        }
		
		.form-header {
            display: flex;
            align-items: center;
        }
        
		.form-header img {
            margin-right: 10px; /* 이미지와 텍스트 사이 간격 설정 */
        }
        .vertical-center {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
    </style>
<script type="text/javascript">

$(document).ready(function() {

    // 페이지 로드 시 로컬 스토리지에서 값 읽기
    function loadSelectedValues() {
        var selectedDong = localStorage.getItem('selectedDong');
        var selectedGrade = localStorage.getItem('selectedGrade');
        
        

        if (selectedDong) {
            $("select[name='bjdong_nm']").val(selectedDong);
        } else {
        	$("select[name='bjdong_nm']").prop('selectedIndex', 0);
        }

        if (selectedGrade) {
            $("select[name='grade']").val(selectedGrade);
        } else {
        	$("select[name='grade']").prop('selectedIndex', 0);
        }
    }
    $("select[name='bjdong_nm']").prop('selectedIndex', 0);

    $("select[name='grade']").prop('selectedIndex', 0);
    
    loadSelectedValues();
    
    $('#selbtn').click(function(event) {
        event.preventDefault(); // 기본 폼 제출 방지

        var selectedDong = $("select[name='bjdong_nm']").val();
        var selectedGrade = $("select[name='grade']").val();
        var selectedGu = "${DATA.sgg_nm}";
        alert(selectedGu);
        
        if (!selectedDong || !selectedGrade) {
            alert("옵션을 선택해야 합니다.");
            return;
        }
        
        // 선택된 값을 로컬 스토리지에 저장
        localStorage.setItem('selectedDong', selectedDong);
        localStorage.setItem('selectedGrade', selectedGrade);
        

        // 보낼 데이터 객체 생성
        var data = {
            bjdong_nm: selectedDong,
            grade: selectedGrade,
            sgg_nm: selectedGu
        };
        
        // Ajax 요청
        $.ajax({
            type: "POST", // 요청 방식
            url: "/boo/list/list.boo", // 요청할 URL
            data: data, // 보낼 데이터
            success: function(response) {
                // 성공 시 처리할 코드 작성
                $('body').html(response);
            },
            error: function(xhr, status, error) { // 요청이 실패했을 때의 콜백 함수
                alert("요청이 실패하였습니다.");
            }
        });
    });
    
    $('.pageBtn').click(function(event) {
        event.preventDefault(); // 기본 링크 동작 방지

        // 이동할 페이지 번호 알아내기
        var nowPage = $(this).attr('id');
        
        // 선택된 동과 등급 값 가져오기
        var selectedDong = $("select[name='bjdong_nm']").val();
        var selectedGrade = $("select[name='grade']").val();
        var selectedGu = "${DATA.sgg_nm}";

        if (!selectedDong || !selectedGrade) {
            alert("옵션을 선택해야 합니다.");
            return;
        }

        // 로컬 스토리지에 현재 페이지 저장
        localStorage.setItem('nowPage', nowPage);

        // Ajax 요청
        var data = {
            bjdong_nm: selectedDong,
            grade: selectedGrade,
            sgg_nm: selectedGu,
            nowPage: nowPage
        };

        $.ajax({
            type: "POST",
            url: "/boo/list/list.boo",
            data: data,
            success: function(response) {
                // 성공 시 처리할 코드 작성
                $('body').html(response);
            },
            error: function(xhr, status, error) {
                alert("요청이 실패하였습니다.");
            }
        });
    });
    $(window).on('beforeunload', function() {
        localStorage.removeItem('selectedDong');
        localStorage.removeItem('selectedGrade');
    });
});

</script>
</head>
<body>
<form method="POST" action="/boo/list/list.boo" id="pageFrm" name="pageFrm">
	<input type="hidden" name="nowPage" id="nowPage">
</form>
<!-- https://thumb.ac-illust.com/9e/9e56ebb6b768858aa6d122ac902563ce_t.jpeg -->
<!-- 폼 컨테이너 -->
<div class="w3-container center-container" style="padding-top: 8px; padding-bottom: 8px;">
    <form id= "myForm" name="myForm" class="w3-container w3-light-grey w3-padding-16" action="/boo/list/list.boo" method="post">
    	<input type="hidden" name="sgg_nm" value="${DATA.sgg_nm}">
	    <div class="vertical-center w3-border-bottom">
		    <div class="form-header" style="text-align: center;">
		        <img src="/boo/image/aptimgimgimg.png" alt="s" style="width: 100px; height: 80px;">
		        <h1 class="w3-text-teal" style="margin-top: 0; margin-bottom: 5px;">${DATA.sgg_nm} 부동산 매매 정보</h1>
		    </div>
		</div>
        
        <div class="form-container">
		    <!-- 첫 번째 옵션 선택 섹션 -->
		    <div class="w3-section" style="width: 40%;">
		        <label class="w3-text-teal" style="text-align: left; display: block;"><b>동 선택</b></label>
		        <select class="w3-select w3-border" name="bjdong_nm">
		            <option value="" disabled selected>동을 선택하세요</option>
<c:forEach var="DATA" items="${DongLIST}" varStatus="st">
			<option value="${DATA.bjdong_nm}">${DATA.bjdong_nm}</option>
</c:forEach>
		        </select>
		    </div>
		
		    <!-- 두 번째 옵션 선택 섹션 -->
		    <div class="w3-section" style="width: 40%;">
		        <label class="w3-text-teal" style="text-align: left; display: block;"><b>예산 범위 선택</b></label>
		        <select class="w3-select w3-border" name="grade">
		            <option value="" disabled selected>예산 범위를 선택하세요</option>
<c:forEach var="DATA" items="${GradeLIST}" varStatus="st">
				<option value="${DATA.grade}">${DATA.grade}</option>
</c:forEach>
		        </select>
		    </div>
		
		    <!-- 제출 버튼 -->
		    <div class="w3-section" style="text-align: center;">
		        <button id="selbtn" class="w3-button w3-teal w3-padding" type="button" style="padding: 8px 8px;">검색</button>
		    </div>
		</div>
    </form>
    
   <div class="w3-col">
			<div class="w3-center w3-margin-top">
				<div class="w3-col m1 w3-border-right w3-blue-gray" >글번호</div>
				<div class="w3-col m1 w3-border-right w3-blue-gray" >자치구</div>
				<div class="w3-col m1 w3-border-right w3-blue-gray" >법정동</div>
				<div class="w3-col m4 w3-border-right w3-blue-gray" >아파트</div>
				<div class="w3-col m2 w3-border-right w3-blue-gray">평균 매매가</div>
				<div class="w3-col m1 w3-border-right w3-blue-gray" >거래량</div>
				<div class="w3-col m2 w3-blue-gray">평균 면적(평)</div>
			</div>
			
<c:if test="${not empty AptLIST}">
	
	<c:forEach var="AptDATA" items="${AptLIST}">

			<div class="w3-col w3-center w3-border-bottom" id="${AptDATA.rno}">
				<div class="w3-col m1 w3-border-right" style="height:45px; line-height:45px" >${AptDATA.rno}</div>
				<div class="w3-col m1 w3-border-right" style="height:45px; line-height:45px">${AptDATA.sgg_nm}</div>
				<div class="w3-col m1 w3-border-right" style="height:45px; line-height:45px">${AptDATA.bjdong_nm}</div>
				<div class="w3-col m4 w3-border-right" style="height:45px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;font-size:14px;line-height:45px">${AptDATA.bldg_nm}</div>
				<div id="avgapt" class="w3-col m2 w3-border-right" style="height:45px; line-height:45px">${AptDATA.avg_amt}</div>
				<div class="w3-col m1 w3-border-right" style="height:45px; line-height:45px">${AptDATA.deal_cnt}</div>
				<div class="w3-col m2 " style="height:45px; line-height:45px">${AptDATA.avg_area}</div>
			</div>
	</c:forEach>
	
		<div class="w3-col w3-center w3-margin-top">
			<div class="w3-bar w3-border w3-border w3-border-blue w3-round">
<c:if test="${DATA.startPage eq 1}">
				<span class="w3-bar-item w3-pale-blue">&laquo;</span>
</c:if>
<c:if test="${DATA.startPage ne 1}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
													id="${DATA.startPage - 1}">&laquo;</span>
</c:if>
<c:forEach var="pno" begin="${DATA.startPage}" end="${DATA.endPage}">
	<c:if test="${DATA.nowPage eq pno}"><!-- 현재 보고있는 페이지인 경우 -->
				<span class="w3-bar-item w3-btn w3-pink w3-hover-blue pageBtn" 
																id="${pno}">${pno}</span>
	</c:if>
	<c:if test="${DATA.nowPage ne pno}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
																id="${pno}">${pno}</span>
	</c:if>
</c:forEach>
<c:if test="${DATA.endPage ne DATA.totalPage}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
													id="${DATA.endPage + 1}">&raquo;</span>
</c:if>
<c:if test="${DATA.endPage eq DATA.totalPage}">
				<span class="w3-bar-item w3-pale-blue">&raquo;</span>
</c:if>
			</div>
		</div>
</c:if> <!-- 리스트가 비어있지 않은 경우 방명록 리스트 조건처리 닫는 태그 -->
<c:if test="${empty AptLIST}">
			<div class="w3-col w3-border-bottom w3-margin-top">
				<h3 class="w3-center w3-text-gray">* 동 or 예산을 선택해 주세요. *</h3>
			</div>
</c:if>
		</div>
</div>
</body>
</html>
