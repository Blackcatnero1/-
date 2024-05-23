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
		    /* 배경 이미지 추가 */
		    background-image: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbEwdU_cxLbKqikIV9lxERYoIEc4_IgYzScw&usqp=CAU');
		    /* 배경 이미지 크기 및 반복 설정 */
		    background-size: cover; /* 배경 이미지를 컨테이너에 맞게 자동 조정 */
		    background-repeat: no-repeat; /* 배경 이미지 반복 없음 */
        }
    </style>
<script type="text/javascript">
    $(document).ready(function(){
    	$('.fblist').click(function(){
			var sbno = $(this).attr('id');
			// 현재페이지 셋팅
			$('#nowPage').val('${PAGE.nowPage}');
			
			$('#bno').val(sbno);
			$('#frm').submit();
		});
        
    	/* 페이지 클릭이벤트 */
		$('.pageBtn').click(function(){
			// 이동할 페이지번호 알아내고
			var nowPage = $(this).attr('id');
			// 입력태그에 데이터 채우고
			$('#nowPage').val(nowPage);
			// 글번호 태그 사용불가처리
			$('#bno').prop('disabled', true);
			// 전송 주소 셋팅하고
			$('#frm').attr('action', '/list/list.son');
			
			// 폼태그 전송하고
			$('#frm').submit();
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

<!-- 폼 컨테이너 -->
<div class="w3-container center-container" style="padding-top: 8px; padding-bottom: 8px;">
    <form name="myForm" class="w3-container w3-light-grey w3-padding-16" action="" method="post">
        <h1 class="w3-text-teal" style="margin-top: 0; margin-bottom: 5px;">강남구 부동산 매매 정보</h1>
        
        <!-- 첫 번째 옵션 선택 섹션 -->
        <div class="w3-section" style="display: inline-block; width: 45%; margin-right: 5%; margin-bottom: 8px;">
            <label class="w3-text-teal"><b>동 선택</b></label>
            <select class="w3-select w3-border" name="option1">
                <option value="" disabled selected>동을 선택하세요</option>
                <option value="1">옵션 1</option>
                <option value="2">옵션 2</option>
                <option value="3">옵션 3</option>
            </select>
        </div>

        <!-- 두 번째 옵션 선택 섹션 -->
        <div class="w3-section" style="display: inline-block; width: 45%; margin-bottom: 8px;">
            <label class="w3-text-teal"><b>예산 범위 선택</b></label>
            <select class="w3-select w3-border" name="option2">
                <option value="" disabled selected>예산 범위를 선택하세요</option>
                <option value="A">1억 미만</option>
                <option value="B">1억 이상 3억 이하</option>
                <option value="C">3억 이상 5억 미만</option>
                <option value="D">5억 이상 7억 미만</option>
                <option value="E">7억 이상 10억 미만</option>
                <option value="F">10억 이상 20억 미만</option>
                <option value="G">20억 이상</option>
            </select>
        </div>

        <!-- 제출 버튼 -->
        <div class="w3-section" style="text-align: center; margin-top: 8px;">
            <button class="w3-button w3-teal w3-padding" type="submit" style="padding: 8px 16px;">검색</button>
        </div>
    </form>
    
    <form method="POST" action="/list/listDetail.son" id="frm" name="frm">
		<input type="hidden" name="bno" id="bno">
		<input type="hidden" name="nowPage" id="nowPage">
	</form>
   <div class="w3-col">
			<div class="w3-center w3-margin-top">
				<div class="inblock w3-left pdr5" style="width: 100px;"><div class="w3-blue-gray">글번호</div></div>
				<div class="inblock w3-right" style="width: 50px;"><div class="w3-blue-gray">가격</div></div>
				<div class="inblock w3-right pdr5" style="width: 170px;"><div class="w3-blue-gray">최근 거래 날짜</div></div>
				<div class="inblock w3-right pdr5" style="width: 150px;"><div class="w3-blue-gray">동 이름</div></div>
				<div class="w3-rest pdr5"><div class="w3-blue-gray">아파트 이름</div></div>
			</div>
			
<c:if test="${not empty LIST}">
	<c:forEach var="DATA" items="${LIST}">
		<c:if test="${not empty SID}">
			<div class="w3-col w3-border-bottom fblist" id="${DATA.bno}">
		</c:if>
		<c:if test="${empty SID}">
			<div class="w3-col w3-border-bottom" id="${DATA.bno}">
		</c:if>
				<div class="inblock w3-left pdr5" style="width: 100px;"><div class="w3-center fbno" style="padding: 2px 2px">${DATA.bno}</div></div>
				<div class="inblock w3-right" style="width: 50px;"><div class="w3-center file">${DATA.cnt}</div></div>
				<div class="inblock w3-right pdr5" style="width: 170px;"><small class="w3-center wdate">${DATA.sdate}</small></div>
				<div class="inblock w3-right pdr5" style="width: 150px;"><div class="w3-center writer">${DATA.id}</div></div>
				<div class="w3-rest pdr5">
					<div class="title">${DATA.title}</div>
				</div>
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
</body>
</html>
