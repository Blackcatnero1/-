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
        .w3-container.w3-white {
            margin-bottom: 16px;
            padding: 16px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
    </style>
    <script>
        var currentPage = 1; // 현재 페이지 번호
        var contentsPerPage = 5; // 페이지 당 보여줄 컨텐츠 수
        var totalContents = 25; // 전체 컨텐츠 수
        var totalPage = Math.ceil(totalContents / contentsPerPage); // 전체 페이지 수

        // 페이지를 변경하는 함수
        function changePage(page) {
            currentPage = page;
            // 여기에 페이지 변경에 따른 컨텐츠 로딩 등의 작업 수행
            // 이 예시에서는 단순히 페이지 번호를 출력하는 것으로 대체
            document.getElementById("currentPage").innerText = currentPage;
        }

        // 페이지 번호를 클릭하여 해당 페이지로 이동하는 함수
        function goToPage(page) {
            if (page >= 1 && page <= totalPage) {
                changePage(page);
                updateContent(); // 페이지 이동 시 컨텐츠 업데이트
            }
        }

        // 컨텐츠를 업데이트하는 함수
        function updateContent() {
            // 여기에서는 예시로 단순히 컨텐츠를 출력할 뿐입니다.
            var startIdx = (currentPage - 1) * contentsPerPage + 1;
            var endIdx = Math.min(currentPage * contentsPerPage, totalContents);

            var contentContainer = document.getElementById("contentContainer");
            contentContainer.innerHTML = ""; // 컨텐츠를 초기화합니다.

            for (var i = startIdx; i <= endIdx; i++) {
                var contentDiv = document.createElement("div");
                contentDiv.className = "w3-container w3-white";
                contentDiv.style.marginTop = "8px";
                contentDiv.style.marginBottom = "8px";
                contentDiv.innerHTML = "<p><b>Lorem Ipsum " + i + "</b></p><p>Praesent tincidunt sed tellus ut rutrum. Sed vitae justo condimentum, porta lectus vitae, ultricies congue gravida diam non fringilla.</p>";

                contentContainer.appendChild(contentDiv);
            }
        }

        // 페이지 로드 시 컨텐츠 업데이트
        window.onload = function () {
            updateContent();
        };
    </script>
</head>
<body>

<!-- 폼 컨테이너 -->
<div class="w3-container center-container">
    <form name="myForm" class="w3-container w3-card-4 w3-light-grey w3-padding-16" action="" method="post">
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
            <label class="w3-text-teal"><b>예산 범위 선택</b></label>
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

<!-- 포트폴리오 텍스트 컨텐츠 -->
<div class="w3-container center-container" id="contentContainer">
    <!-- 여기에 동적으로 컨텐츠가 추가될 것입니다. -->
</div>

<!-- 페이지 번호 표시 -->
<div class="w3-container center-container">
    <div class="w3-section">
        현재 페이지: <span id="currentPage">1</span>
    </div>

    <!-- 페이지 이동 버튼 -->
    <div class="w3-section">
        <c:forEach begin="1" end="${totalPage}" var="page">
            <span class="w3-button w3-teal" onclick="goToPage(${page})">${page}</span>
        </c:forEach>
    </div>
</div>

</body>
</html>
