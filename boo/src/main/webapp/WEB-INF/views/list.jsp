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
    <style>
        .center-container {
            margin: 0 auto;
            max-width: 700px;
            text-align: center;
            padding-top: 32px;
        }
    </style>
    <script>
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
<div class="w3-container center-container">
    <form name="myForm" class="w3-container w3-card-4 w3-light-grey w3-padding-16" action="" method="post" onsubmit="return validateForm()">
        <h1 class="w3-text-teal">강남구 부동산 매매 정보</h1>
        
        <!-- 첫 번째 옵션 선택 섹션 -->
        <div class="w3-section w3-half">
            <label class="w3-text-teal"><b>동 선택</b></label>
            <select class="w3-select w3-border" name="option1">
                <option value="" disabled selected>동을 선택하세요</option>
                <option value="1">옵션 1</option>
                <option value="2">옵션 2</option>
                <option value="3">옵션 3</option>
            </select>
        </div>

        <!-- 두 번째 옵션 선택 섹션 -->
        <div class="w3-section w3-half">
            <label class="w3-text-teal"><b>예산 범위선택</b></label>
            <select class="w3-select w3-border" name="option2">
                <option value="" disabled selected>예산 범위를 선택하세요</option>
                <option value="A">옵션 A</option>
                <option value="B">옵션 B</option>
                <option value="C">옵션 C</option>
            </select>
        </div>

        <!-- 제출 버튼 -->
        <button class="w3-button w3-teal w3-section w3-padding" type="submit">등록</button>
    </form>
</div>

</body>
</html>
