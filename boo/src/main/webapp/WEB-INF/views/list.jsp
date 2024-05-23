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
    <style>
        .center-container {
            margin: 0 auto;
            max-width: 700px;
            text-align: center;
            padding-top: 32px;
        }
        .w3-container.w3-white {
            margin-bottom: 16px;
            padding: 16px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
    </style>
    <script>
       
    </script>
</head>
<body>

<!-- 폼 컨테이너 -->
<div class="w3-container center-container" style="padding-top: 8px; padding-bottom: 8px;">
    <form name="myForm" class="w3-container w3-card-4 w3-light-grey w3-padding-16" action="" method="post">
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
                <option value="A">옵션 A</option>
                <option value="B">옵션 B</option>
                <option value="C">옵션 C</option>
            </select>
        </div>

        <!-- 제출 버튼 -->
        <div class="w3-section" style="text-align: center; margin-top: 8px;">
            <button class="w3-button w3-teal w3-padding" type="submit" style="padding: 8px 16px;">등록</button>
        </div>
    </form>
</div>



<div class="w3-container center-container">
    <div class="w3-container w3-white" style="margin-top: 8px; margin-bottom: 8px;">
        <p><b>Lorem Ipsum</b></p>
        <p>Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
    </div>
    <div class="w3-container w3-white" style="margin-top: 8px; margin-bottom: 8px;">
        <p><b>Lorem Ipsum</b></p>
        <p>Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
    </div>
    <div class="w3-container w3-white" style="margin-top: 8px; margin-bottom: 8px;">
        <p><b>Lorem Ipsum</b></p>
        <p>Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
    </div>
    <div class="w3-container w3-white" style="margin-top: 8px; margin-bottom: 8px;">
        <p><b>Lorem Ipsum</b></p>
        <p>Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
    </div>
    <div class="w3-container w3-white" style="margin-top: 8px; margin-bottom: 8px;">
        <p><b>Lorem Ipsum</b></p>
        <p>Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
    </div>
    <div class="w3-container w3-white" style="margin-top: 8px; margin-bottom: 8px;">
        <p><b>Lorem Ipsum</b></p>
        <p>Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>
    </div>
</div>

<!-- Pagination -->
	<div class="w3-center w3-padding-32">
		<div class="w3-bar">
			<a href="#" class="w3-bar-item w3-button w3-hover-black">«</a>
			<a href="#" class="w3-bar-item w3-button w3-hover-black">1</a>
			<a href="#" class="w3-bar-item w3-button w3-hover-black">2</a>
			<a href="#" class="w3-bar-item w3-button w3-hover-black">3</a>
			<a href="#" class="w3-bar-item w3-button w3-hover-black">4</a>
			<a href="#" class="w3-bar-item w3-button w3-hover-black">»</a>
		</div>
	</div>

</body>
</html>
