<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>W3.CSS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" type="text/css" href="/css/w3.css">
    <link rel="stylesheet" type="text/css" href="/css/user.css">
    <script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
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
    $(document).ready(function(){
    	/* 페이지 클릭이벤트 */
		$('.pageBtn').click(function(){
			// 이동할 페이지번호 알아내고
			var nowPage = $(this).attr('id');
			// 입력태그에 데이터 채우고
			$('#nowPage').val(nowPage);
			// 글번호 태그 사용불가처리
			$('#bno').prop('disabled', true);
			// 전송 주소 셋팅하고
			$('#pageFrm').attr('action', '/boo/list/list.boo');
			
			// 폼태그 전송하고
			$('#pageFrm').submit();
		});
    });
    
    // 폼 유효성 검사 함수
    function validateForm() {
        var option1 = document.forms["myForm"]["option1"].value;
        var option2 = document.forms["myForm"]["option2"].value;
        if (option1 == "" && option2 == "") {
            alert("적어도 하나의 옵션을 선택해야 합니다.");
            return false;
        }
        return true;
    }
</script>
</head>
<body>
<form method="POST" action="/boo/list/list.boo" id="pageFrm" name="pageFrm">
	<input type="hidden" name="nowPage" id="nowPage">
</form>
<!-- https://thumb.ac-illust.com/9e/9e56ebb6b768858aa6d122ac902563ce_t.jpeg -->
<!-- 폼 컨테이너 -->
<div class="w3-container center-container" style="padding-top: 8px; padding-bottom: 8px;">
    <form name="myForm" class="w3-container w3-light-grey w3-padding-16" action="" method="post">
	    <div class="vertical-center w3-border-bottom">
		    <div class="form-header" style="text-align: center;">
		        <img src="https://thumb.ac-illust.com/9e/9e56ebb6b768858aa6d122ac902563ce_t.jpeg" alt="s" style="width: 100px; height: 80px;">
		        <h1 class="w3-text-teal" style="margin-top: 0; margin-bottom: 5px;">강남구 부동산 매매 정보</h1>
		    </div>
		</div>
        
        <div class="form-container">
		    <!-- 첫 번째 옵션 선택 섹션 -->
		    <div class="w3-section" style="width: 40%;">
		        <label class="w3-text-teal" style="text-align: left; display: block;"><b>동 선택</b></label>
		        <select class="w3-select w3-border" name="option1">
		            <option value="" disabled selected>동을 선택하세요</option>
<c:forEach var="DATA" items="${DongLIST}" varStatus="st">
			<option value="D ${st.index + 1}">${DATA.bjdong_nm}</option>
</c:forEach>
		        </select>
		    </div>
		
		    <!-- 두 번째 옵션 선택 섹션 -->
		    <div class="w3-section" style="width: 40%;">
		        <label class="w3-text-teal" style="text-align: left; display: block;"><b>예산 범위 선택</b></label>
		        <select class="w3-select w3-border" name="option2">
		            <option value="" disabled selected>예산 범위를 선택하세요</option>
<c:forEach var="DATA" items="${GradeLIST}" varStatus="st">
				<option value="G${st.index + 1}">${DATA.grade}</option>
</c:forEach>
		        </select>
		    </div>
		
		    <!-- 제출 버튼 -->
		    <div class="w3-section" style="text-align: center;">
		        <button class="w3-button w3-teal w3-padding" type="submit" style="padding: 8px 8px;">검색</button>
		    </div>
		</div>
    </form>
    
   <div class="w3-col">
			<div class="w3-center w3-margin-top">
				<div class="w3-col m1 w3-border-right w3-blue-gray" >글번호</div>
				<div class="w3-col m2 w3-border-right w3-blue-gray" >자치구</div>
				<div class="w3-col m2 w3-border-right w3-blue-gray" >법정동</div>
				<div class="w3-col m2 w3-border-right w3-blue-gray" >아파트</div>
				<div class="w3-col m2 w3-border-right w3-blue-gray">평균 매매가</div>
				<div class="w3-col m2 w3-blue-gray">평균 면적(평)</div>
			</div>
			
<c:if test="${not empty LIST}">
	
	<c:forEach var="DATA" items="${LIST}">
			<div class="w3-col w3-border-bottom" id="${DATA.rno}">
<!-- 수정!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!########## -->
				<div class="inblock w3-left pdr5" style="width: 100px;"><div class="w3-center fbno" style="padding: 2px 2px">${DATA.rno}</div></div>
				<div class="inblock w3-right" style="width: 50px;"><div class="w3-center file">${DATA.goo}</div></div>
				<div class="inblock w3-right pdr5" style="width: 170px;"><small class="w3-center wdate">${DATA.money} 만원</small></div>
				<div class="inblock w3-right pdr5" style="width: 150px;"><div class="w3-center writer">${DATA.dong}</div></div>
				<div class="w3-rest pdr5">
					<div class="title">${DATA.aname}</div>
				</div>
<!-- 수정!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!########## -->
			</div>
	</c:forEach>
	
		<div class="w3-col w3-center w3-margin-top">
			<div class="w3-bar w3-border w3-border w3-border-blue w3-round">
<c:if test="${PAGE.startPage eq 1}">
				<span class="w3-bar-item w3-pale-blue">&laquo;</span>
</c:if>
<c:if test="${PAGE.startPage ne 1}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
													id="${PAGE.startPage - 1}">&laquo;</span>
</c:if>
<c:forEach var="pno" begin="${PAGE.startPage}" end="${PAGE.endPage}">
	<c:if test="${PAGE.nowPage eq pno}"><!-- 현재 보고있는 페이지인 경우 -->
				<span class="w3-bar-item w3-btn w3-pink w3-hover-blue pageBtn" 
																id="${pno}">${pno}</span>
	</c:if>
	<c:if test="${PAGE.nowPage ne pno}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
																id="${pno}">${pno}</span>
	</c:if>
</c:forEach>
<c:if test="${PAGE.endPage ne PAGE.totalPage}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
													id="${PAGE.endPage + 1}">&raquo;</span>
</c:if>
<c:if test="${PAGE.endPage eq PAGE.totalPage}">
				<span class="w3-bar-item w3-pale-blue">&raquo;</span>
</c:if>
			</div>
		</div>
</c:if> <!-- 리스트가 비어있지 않은 경우 방명록 리스트 조건처리 닫는 태그 -->
<c:if test="${empty LIST}">
			<div class="w3-col w3-border-bottom w3-margin-top">
				<h3 class="w3-center w3-text-gray">* 동 or 예산을 선택해 주세요. *</h3>
			</div>
</c:if>
		</div>
</div>
</body>
</html>
