<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<style>
  body, html {
    margin: 0;
    padding: 0;
    height: 100%;
  }
  .back {
    background-image: url("https://cdn.pixabay.com/photo/2014/11/13/17/47/skyscrapers-529684_1280.jpg");
    background-size: cover;
    background-position: center;
    height: 100vh; 
    position: relative;
    margin: 0;
    padding:0;
  }
  .front {
  	z-index:1;
    position: absolute;
    top: 80%;
    left: 50%;
    
  }
  .frtop {
  	z-index:1;
    position: absolute;
    top: 20%;
    left: 50%;
  }
</style>
</head>
<body class="w3-content">

<div class="w3-row">
<div class=" w3-white w3-container w3-center">
	<div>
     	<img src="https://github.com/Blackcatnero1/boodongsan/blob/branch/minkyung/%EC%9B%B0%EC%BB%B4%EB%B8%94%EB%A1%9D1%20%EC%9D%B4%EB%AF%B8%EC%A7%80.png?raw=true" style="width: 750px;" class="frtop">
    </div>
	<div class="w3-padding-64">
	 <img src="https://cdn.pixabay.com/photo/2014/11/13/17/47/skyscrapers-529684_1280.jpg" class="back">
<c:if test="${empty kakaoID}">
			<a href="https://kauth.kakao.com/oauth/authorize">
				<img src="https://developers.kakao.com/tool/resource/static/img/button/login/full/ko/kakao_login_medium_wide.png" class="front">
			</a>
</c:if>
<c:if test="${not empty kakaoID}">
			<div class="w3-yellow front" style="height: 360px; width: 60px;">챗봇 상담</div>
</c:if>
		</div>
	</div>
</div>
</body>
</html>
