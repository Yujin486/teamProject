<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="container">
		<!-- location_area -->
<div class="location_area package">
	<div class="box_inner">
		<h2 class="tit_page">부산 맛집</h2>
		<p class="location">QnA <span class="path">/</span> 게시글 비밀번호 확인</p>
		<ul class="page_menu clear">
			<li><a href="javascript:;" class="on">게시글 비밀번호 확인</a></li>
		</ul>
	</div>
 </div>	
</div>
<!-- //location_area -->

<!-- bodytext_area -->
<div class="bodytext_area box_inner">
	<!-- appForm -->
	<form action="/qnaboard/pwConfirm" id="confirmForm" name="confirmForm" class="appForm" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
 	<input type="hidden" id="boardBno" name="bno" value="${board.bno}"/>
	<input type="hidden" name="page" value="${cri.page}"/>
	<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
	<input type="hidden" name="keyword" value="${cri.keyword}"/>
		<fieldset>
			<legend>비밀번호 수정 </legend>
			<p class="info_notice">게시물 비밀번호</p>
			<ul class="app_list">				
				<li class="clear">
					<label for="u_pw" class="tit_lbl">비밀번호</label>
					<div class="app_content">
					 <input type="password" class="w40p" id="password" name="password" required/>
					<div class="result"></div>	
					</div>					
				</li>
			</ul>	
			<p class="btn_line">
				<a href="javascript:;" id="confirmBtn" class="btn_baseColor">확인</a>
				<a href="javascript:;" id="cancelBtn" class="btn_deleteColor">취소</a>
			</p>	
		</fieldset>
	</form>
	<!-- //appForm -->
	
</div>
<!-- //bodytext_area -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script>
	$("#confirmBtn").click(function(event){
		event.preventDefault();
		$("#confirmForm").submit();
	});
	
	$("#cancelBtn").click(function(event){
		event.preventDefault();
		history.go(-1);
	});
	
	var message = "${message}";
	if(message != null && message != ""){
		alert(message);
		$("#password").focus();
	}
</script>