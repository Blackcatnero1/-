<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>부동산 매매 정보</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" type="text/css" href="/boo/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/boo/css/user.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="/boo/js/jquery-3.7.1.min.js"></script>
    <style>
        .center-container {
			  margin: 0 auto;
			  max-width: 1000px;
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
            margin-right: 10px;
        }
        .vertical-center {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		}
    </style>
<script type="text/javascript">
$(document).ready(function() {
	
	// 검색버튼 클릭이벤트
    $('#selbtn').click(function(event) {
    	
    	//select태그 선택 옵션 저장하고
        var selectedDong = $("select[name='bjdong_nm'] option:selected").val();
        var selectedGrade = $("select[name='grade'] option:selected").val();
        
        //django 요청으로 셋팅된 자치구 이름 기억 
        var selectedGu = "${DATA.sgg_nm}";
        
        // select태그 옵션 선택 안했을 시
        if (!selectedDong || !selectedGrade) {
            alert("옵션을 선택해야 합니다.");
            return;
        }
        
        //ajax로 보낼 데이터
        var data = {
            bjdong_nm: selectedDong,
            grade: selectedGrade,
            sgg_nm: selectedGu
        };
        //비동기 요청하기
        $.ajax({
            type: "POST",
            url: "/boo/list/list.boo",
            data: data,
            //성공시 처리
            success: function(response) {
            	
            	
                if ($(response).find('.apt').length > 0) {
                    $('#getApt').html($(response).find('#getApt').html());
                } else { 	// 성공 했으나 데이터가 없을때
                	$('#getApt').html($(response).find('#getApt').html());
                    $('#dongye').html("조회된 데이터가 없습니다.");
                }
            },
            // 요청에 실패
            error: function(xhr, status, error) {
                alert("요청이 실패하였습니다.");
            }
        });
    });

	//페이지버튼 클릭 이벤트
    $(document).on('click', '.pageBtn', function(event) {
    	//넘겨줘야하는 데이터 저장
        var nowPage = $(this).attr('id');
        var selectedDong = $("select[name='bjdong_nm'] option:selected").val();
        var selectedGrade = $("select[name='grade'] option:selected").val();
        var selectedGu = "${DATA.sgg_nm}";
        
        
        //ajax로 넘겨야 하는 데이터
        var data = {
            bjdong_nm: selectedDong,
            grade: selectedGrade,
            sgg_nm: selectedGu,
            nowPage: nowPage
        };
        
        //ajax 요청
        $.ajax({
            type: "POST",
            url: "/boo/list/list.boo",
            data: data,
            success: function(response) {
                $('#getApt').html($(response).find('#getApt').html());
            },
            error: function(xhr, status, error) {
                alert("요청이 실패하였습니다.");
            }
        });
    });
});

</script>
</head>
<body>
<form method="POST" action="/boo/list/list.boo" id="pageFrm" name="pageFrm">
	<input type="hidden" name="nowPage" id="nowPage">
</form>


<div class="w3-container center-container" style="padding-top: 8px; padding-bottom: 8px;">
    <form id= "myForm" name="myForm" class="w3-container w3-light-grey w3-card-4 w3-padding-16" action="/boo/list/list.boo" method="post">
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
    
    <small class="w3-text-blue w3-right w3-margin-top"> * 2017년 ~ 2024년 자료 기준 통계 *</small>
    
    <div id="getApt">
    
   <div class="w3-col w3-light-grey mgt6 w3-card-4">
			<div class="w3-center">
				<div class="w3-col m1 w3-border-reft w3-border-right w3-blue-gray" style="height:35px; line-height:35px" >거래랭킹</div>
				<div class="w3-col m2 w3-border-right w3-blue-gray" style="height:35px; line-height:35px">법정동</div>
				<div class="w3-col m4 w3-border-right w3-blue-gray" style="height:35px; line-height:35px">아파트</div>
				<div class="w3-col m2 w3-border-right w3-blue-gray" style="height:35px; line-height:35px">매매가 분포 <small>(만원)</small></div>
				<div class="w3-col m1 w3-border-right w3-blue-gray" style="height:35px; line-height:35px">거래량</div>
				<div class="w3-rest w3-blue-gray" style="height:35px; line-height:35px">면적분포 <small>(평)</small></div>
			</div>
			
<c:if test="${not empty AptLIST}">
	
	<c:forEach var="AptDATA" items="${AptLIST}">

			<div class="w3-col w3-center w3-border-bottom apt" id="${AptDATA.rno}">
				<div class="w3-col m1 w3-border-right" style="height:45px; line-height:45px" >${AptDATA.rno}</div>
				<div class="w3-col m2 w3-border-right" style="height:45px; line-height:45px">${AptDATA.bjdong_nm}</div>
				<div class="w3-col m4 w3-border-right" style="height:45px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;font-size:14px;line-height:45px">${AptDATA.bldg_nm}</div>
				<div class="w3-col m2 w3-border-right" style="height:45px; line-height:45px">${AptDATA.range_amt}</div>
				<div class="w3-col m1 w3-border-right" style="height:45px; line-height:45px">${AptDATA.deal_cnt} 건</div>
				<div class="w3-rest " style="height:45px; line-height:45px">${AptDATA.range_area}</div>
			</div>
	</c:forEach>
	

</c:if> 
<c:if test="${empty AptLIST}">
			<div class="w3-col">
				<h3 class="w3-center w3-text-gray pdh20" id="dongye">* 동 or 예산을 선택해 주세요. *</h3>
			</div>
</c:if>

		<br>
			<div class="w3-col w3-blue-gray " style="height:25px"></div>
		</div>
		
<c:if test="${not empty AptLIST}">
		<div class="w3-col w3-center pdh30">
			<div class="w3-bar w3-border w3-border w3-border-blue w3-round">
<c:if test="${DATA.startPage eq 1}">
				<span class="w3-bar-item w3-pale-blue">&laquo;</span>
</c:if>

<c:if test="${DATA.startPage ne 1}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
													id="${DATA.startPage - 1}">&laquo;</span>
</c:if>
<c:forEach var="pno" begin="${DATA.startPage}" end="${DATA.endPage}">
	<c:if test="${DATA.nowPage eq pno}">
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
</c:if>


	</div>
		
</div>
</body>
</html>