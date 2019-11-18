<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<body>
	<!-- (1) LoginWithNaverId Javscript SDK -->
	<script type="text/javascript"
		src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"
		charset="utf-8"></script>


	<!-- (2) LoginWithNaverId Javscript 설정 정보 및 초기화 -->
	<script>
		var naverLogin = new naver.LoginWithNaverId({
			clientId : "0zCIC0Sx6RMZmIPHK9kY",
			callbackUrl : "http://localhost:8080/user/callback",
			isPopup : false,
			callbackHandle : true
		/* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */
		});

		/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
		naverLogin.init();

		/* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */
		window.addEventListener('load', function() {
			naverLogin.getLoginStatus(function(status) {

				if (status) {
					var name = naverLogin.user.getName();
					var email = naverLogin.user.getEmail();
					var birth = naverLogin.user.getBirthday();

					var isRequire = true;
					if (name == undefined || name == null) {
						alert("이름은 필수정보입니다. 정보제공을 동의해주세요.");
						isRequire = false;
					} else if (email == undefined || email == null) {
						alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
						isRequire = false;
					} else if (birth == undefined || birth == null) {
						alert("생일은 필수정보입니다. 정보제공을 동의해주세요.");
						isRequire = false;
					}

					if (isRequire == false) {
						naverLogin.reprompt();
						return false;
					}
					naverIdCheck(email,name,birth);
					alert(name+"님 로그인되었습니다.");
				} else {
					console.log("callback 처리에 실패하였습니다.");
					window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/user/login");
				}
			});
		});

		naverLogin.getLoginStatus(function(status) {
			if (status) {
				var name = naverLogin.user.getName();
				var email = naverLogin.user.getEmail();
				var birth = naverLogin.user.getBirthday();
			} else {
				console.log("AccessToken이 올바르지 않습니다.");
			}
		});
		
		function naverIdCheck(email,name,birth) {
			// DataBase 에 등록되어 있는 회원정보가 있는지 조회한다.
			var url = '${path}/user/naverIdCheck';
			$.ajax({
				url :  url,
				type : 'POST',
				dataType : 'text',
				data : {
					sns_id : email,
					sns_name : name,
					sns_birth : birth,
					'${_csrf.parameterName}' : '${_csrf.token}'
				},
				success : function(data) {
					console.log("${userInfo}");
					submit(email);
				},
				error : function(req, message){
					alert(req.status);
					alert(message);
				}
			});
		}
		
		function submit(email){
			
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "/user/login");
			
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "u_id")
			hiddenField.setAttribute("value", email);
			form.appendChild(hiddenField);
			
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "u_pw")
			hiddenField.setAttribute("value", "asdf123");
			form.appendChild(hiddenField);
			
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "${_csrf.parameterName}")
			hiddenField.setAttribute("value", "${_csrf.token}");
			form.appendChild(hiddenField);

			document.body.appendChild(form);
			form.submit();
		}
	</script>

</body>
</html>