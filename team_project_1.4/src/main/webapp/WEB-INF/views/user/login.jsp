<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="${path}/resources/js/jquery.validate.js"></script>	
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<div id="container">
		<!-- location_area -->
<div class="location_area ticket">
	<div class="box_inner">
		<h2 class="tit_page">부산 맛집</h2>
		<p class="location">MEMBER <span class="path">/</span> 로그인</p>
		<ul class="page_menu clear">
			<li><a href="javascript:;" class="on">로그인</a></li>
		</ul>
	</div>
 </div>	
</div>
<!-- //location_area -->
<!-- bodytext_area -->
<div class="bodytext_area box_inner">
	<!-- appForm -->
	<form action="/user/login" id="loginForm" name="loginForm" class="appForm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<fieldset>
			<ul class="app_list">
				<li class="clear ">
					<label for="u_id" class="tit_lbl">아이디</label>
					<div class="app_content email_area">
						<input type="text" class="w40p" id="u_id" name="u_id" placeholder="이메일 주소" />
						<div class="result"></div>
					</div>
				</li>
				<li class="clear">
					<label for="u_pw" class="tit_lbl">비밀번호</label>
					<div class="app_content">
						<input type="password" class="w40p" id="u_pw" name="u_pw" placeholder="비밀번호를 입력해주세요" />
						<div class="result">
						<c:if test="${!empty error}"><label style="color: red;">${error}</label></c:if>
						</div>
					</div>
				</li>
				<li class="clear">
					<div class="app_content checkbox_area">
						<input type="checkbox" class="css-checkbox" id="userCookie" name="userCookie" />
						<label for="userCookie">로그인 정보 저장</label>
					</div>
				</li> 
				<li class="clear">
					<label for="u_pw" class="tit_lbl"></label>
					<div class="app_content">
						<a href="#" id="naverIdLogin"><strong>네이버</strong> 로그인</a>
					</div>
				</li>
			</ul>
			<!-- <div class="bodytext_area box_inner">
				login-wrap -->
	
			<!-- </div> -->
			<p class="btn_line">
				<a href="#" id="loginBtn" class="btn_baseColor">로그인</a>
				<!-- <button type="submit" id="loginBtn" onsubmit="return" class="btn_baseColor">로그인</button> -->
			</p>
		</fieldset>
	</form>
	<!-- //appForm -->

</div>
<!-- //bodytext_area -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- //container -->
<script>
	var boolUId = false;
	var boolPassword = false;
	
	var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	var regexPass = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	
	$(function(){
		$("#u_id").focus();
		
		function checkRegex(elP, valP, regexP, messageP, ajaxP){
			if(regexP.test(valP) === false){
				showErrorMessage(elP, messageP, false);
				return false;
			}else if(regexP.test(valP) != false && ajaxP === null){
				showErrorMessage(elP, '', true);
				return true;
			}else{
				if(ajaxP !== null){
					ajaxP(elP);
				}
			}
		}
		
		function showErrorMessage(elP, messageP, isChecked){
			var html = '<span style="margin-left:5px;font-size:12px;';
				html += isChecked ? 'color:green;' : 'color:red';
				html += '">';
				html += isChecked ? '' : messageP;
				html += '</span>';
			$(elP).html(html);
		}
		
		$("#u_id").on("input", function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "올바른 이메일 형식이 아닙니다";
			boolUId = checkRegex(elP, tempVal, regexEmail, message, null);
		});
		
		$("#u_pw").on("input", function(){
			var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "영문/숫자를 사용해 6~20자 이내로 입력해주세요"
			boolUPassword = checkRegex(elP, tempVal, regexPass, message, null);
		});
		
		$("#loginBtn").click(function(){
			/* if(!boolUId){
				alert("아이디를 확인해주세요.");
				$("#u_id").focus();
			}else if(!boolUPassword){
				alert("비밀번호를 확인해주세요!");
				$("#u_pw").focus();
			}else{
				$("#loginForm").submit();
			} */
			event.preventDefault();
			$("#loginForm").submit();
		});
	});
	
	var message = "${message}";
	if(message != null && message != ""){
		alert(message);
	}

	/* 네이버 로그인 */
	var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "0zCIC0Sx6RMZmIPHK9kY",
			callbackUrl: "http://localhost:8080/user/callback",
			isPopup: false, /* 팝업을 통한 연동처리 여부 */
			loginButton: {color: "green", type: 3, height: 50} /* 로그인 버튼의 타입을 지정 */
		}
	);
	
	/* 설정정보를 초기화하고 연동을 준비 */
	naverLogin.init();
	
</script>

</body>
</html>
    