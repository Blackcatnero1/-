<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
<body>
    <button onclick="kakaoLogin()"><img src="https://www.gb.go.kr/Main/Images/ko/member/certi_kakao_login.png" width="200px" /></button>

    <script>
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
                            fetch('/setSession', {
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
                                    // 세션 설정이 완료되면 main.jsp로 이동
                                    window.location.href = 'main.jsp';
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
</body>
</html>
