<!-- 
	이 페이지는 메인 페이지입니다.
	@author  전민경, 김유진, 김한민
	@since	 2024.05.29
	@version V.1.0
	 		 2024.05.29 - 페이지 제작 [ 담당자 : 전민경, 김유진, 김한민 ] 
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boo Main</title>
<link rel="stylesheet" type="text/css" href="/boo/css/w3.css">
<link rel="stylesheet" type="text/css" href="/boo/css/user.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="/boo/js/jquery-3.7.1.min.js"></script>
<style type="text/css">
	body, html {height: 100%}
	.menu {display: none}
	.bgimg {
	  background-repeat: no-repeat;
	  background-size: cover;
	  background-image: url("/boo/image/apart.jpg");
	  min-height: 90%;
	}
	#move-up {
		position : realtive;
		top: -100px;
		text-shadow:4px 4px 6px rgba(0, 0, 0, 0.5);
	}
	
	button {
	    padding: 0;
	    border: none;
	    background: none;
	    cursor: pointer;
	    opacity: 0.9;
	}
	
	button:hover {
		opacity: 1;
	}
	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('#logout').click(function(){
			$(location).attr('href', '/boo/rmSession.boo');
		});
		
		$('#schat').click(function(){
			// 원하는 URL로 이동
			window.location.href = "http://pf.kakao.com/_ZdLUG/";
		});
		
	});
	
    Kakao.init("21c363680f2db21df7de0268a3a1f6f0");

    function kakaoLogin(){
        Kakao.Auth.login({
            scope: 'profile_nickname',
            success: function(authObj){
                console.log(authObj);
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function(res) {
                        const kakao_account = res.kakao_account;
                        console.log(kakao_account);

                        // 사용자 정보를 서버로 전송하여 세션 설정
                        fetch('${pageContext.request.contextPath}/setSession.boo', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({
                                nickname: kakao_account.profile.nickname,
                                email: kakao_account.email
                            })
                        }).then(response => {
                            if (response.ok) {
                                // 세션 설정이 완료되면 main.boo로 이동
                                window.location.href = '${pageContext.request.contextPath}/main.boo';
                            } else {
                                console.error('Failed to set session');
                            }
                        }).catch(error => {
                            console.error('Error:', error);
                        });
                    }
                });
            },
            fail: function(err) {
                console.error(err);
            }
        });
    }
</script>
</head>
<body>
<header class="bgimg w3-display-container w3-grayscale-min" id="home">
	<div class="w3-display-middle w3-center">
		<span id="move-up" class="w3-text-white w3-hide-small" style="font-size:25px;text-shadow: -2px 0px black,0px 2px black,2px 0px black,0px -2px black;"><b>아파트 매매정보 챗봇<br></b></span>
		<span id="move-up" class="w3-text-cyan w3-hide-small" style="text-shadow: -1px 0px black,0px 1px black,1px 0px black,0px -1px black;-webkit-text-stroke: 2px black;font-size:90px"><b>APT.집PT</b></span>

	<p style="margin-top: 50px; display; inline-block;"/>
<c:if test="${not empty nickname}">
    <h2 class="w3-text-aqua" style="blod:2px; text-shadow:1px 1px 0 #444;font-weight: bold;">환영합니다. ${nickname} 님!</h2>
    <div id="schat" class="w3-button w3-large w3-black w3-round-large mgw10 mgt20" style="width: 220px">부매랑 챗봇 시작하기</div>
    <div id="logout" class="w3-button w3-large w3-teal w3-round-large mgw10 mgt20" style="width: 220px">로그아웃</div>
</c:if>

<c:if test="${empty nickname}">
	<h2 class="w3-text-black" style="text-shadow: -1px 0px white,0px 1px white,1px 0px white,0px -1px white;font-weight: bold;">로그인을 진행해주세요</h2>
    <button onclick="kakaoLogin()" class="mgw10 mgt20"><img src="/boo/image/kakao_login.png" width="220px"/></button>
    
</c:if>

	</div>
</header>
<div class="w3-left" style="margin-top: 0">
<img src="https://github.com/Blackcatnero1/boodongsan/blob/branch/minkyung/%EC%9B%B0%EC%BB%B4%EB%B8%94%EB%A1%9D1%20%EC%9D%B4%EB%AF%B8%EC%A7%80.png?raw=true" style="height: 90px;">
</div>
<div class="w3-right" style="margin-top: 0">
<img src="https://github.com/Blackcatnero1/boodongsan/blob/branch/yujin/export202405281745267201.png?raw=true" style="height: 90px;">
</div>
</body>
</html>