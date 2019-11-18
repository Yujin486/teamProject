<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="${path}/resources/css/common.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${path}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${path}/resources/js/common.js"></script>  
<script src="${path}/resources/js/jquery.smooth-scroll.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script> 
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="member" property="principal.member"/>
</sec:authorize>
</head>
<body>
	<div class="bodytext_area box_inner">
		<fieldset>
			<ul class="app_list">
				<li class="clear">
					<div class="app_content"><textarea id="data" rows="18" class="w100p" style="resize:none;" readonly></textarea></div>
				</li>
				<li class="clear">
					<div class="app_content"><input type="text" class="w100p" id="message"/></div>
				</li>
				<p class="btn_line">
				<a href="#"  id="sendBtn" class="btn_baseColor">등록</a>
				</p>
			</ul>
		</fieldset>
	</div>
	<script>
	$(function(){
		$("#sendBtn").click(function(){
			event.preventDefault();
			sendMessage();
			$("#message").val('');
		});
		
		$("#message").keydown(function(key){
			if(key.keyCode == 13){
				sendMessage();
				$(this).val('');
			}
		});
	});
	
	var sock = new SockJS("/echo");
	sock.onmessage = onmessage;
	sock.onclose = onclose;
	
	function sendMessage(){
		var userName = "${member.u_name}";
		var message = $("#message").val();
		console.log(userName+' : '+message);
		sock.send(userName+", "+message);
	}
	
	function onmessage(message){
		var data = message.data;
		$("#data").append(data+"\r\n");
		$("#data").focus();
		$("#message").focus();
	}
	
	function onclose(){
		$("#data").append("연결 끊김");
	}
	</script>
</body>
</html>