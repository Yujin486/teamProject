<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<sec:authorize access="isAuthenticated()">
<sec:authentication var="member" property="principal.member"/>
</sec:authorize>   
<div id="container">
		<!-- location_area -->
		<div class="location_area package">
			<div class="box_inner">
				<h2 class="tit_page">부산 맛집</h2>
				<p class="location">MYPAGE <span class="path">/</span> 개인 정보 수정</p>
				<ul class="page_menu clear">
					<li><a href="#" class="on">개인 정보 수정</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<!-- myinfo -->
			<dl class="myinfo">
				<dt>내 정보</dt>
				<dd>
					<!-- appForm -->
					<form action="#" class="regForm">
						<fieldset>
							<legend>내정보 입력 양식</legend>
							<ul class="reg_list">
								<li class="clear">
									<span class="tit_lbl">이름</span>
									<div class="reg_content">${member.u_name}</div>
								</li>
								<li class="clear">
									<span class="tit_lbl">아이디</span>
									<div class="reg_content">${member.u_id}</div>
								<li class="clear">
									<label class="tit_lbl">생년월일</label>
									<div class="reg_content">${member.u_birth}</div>
								</li>
								<c:if test="${member.u_addr_post != null}">
									<li class="clear">
										<span class="tit_lbl">우편번호</span>
										<div class="reg_content">${member.u_addr_post}</div>
									</li>	
								</c:if>	
								<c:if test="${member.u_addr_detail != null}">	
								<li class="clear">
									<span class="tit_lbl">주소</span>
									<div class="reg_content">${member.u_addr} ${member.u_addr_detail}</div>
								</li>
								</c:if>	
								<c:if test="${member.u_phone != '01000000000'}">	
								<li class="clear">
									<span class="tit_lbl">연락처</span>
									<div class="reg_content">${member.u_phone}</div>
								</li>
								</c:if>						
								<li class="clear">
									<span class="tit_lbl">계정 생성일</span>
									<div class="reg_content"><f:formatDate pattern="yyyy-MM-dd hh:mm" value="${member.u_date}"/></div>
								</li>
								<li class="clear">
									<span class="tit_lbl">마지막 로그인 날짜</span>
									<div class="reg_content"><f:formatDate pattern="yyyy-MM-dd hh:mm" value="${member.u_visit_date}"/></div>
								</li>
								<li class="clear">
		                            <span class="tit_lbl pilsoo_item">개인정보 활용동의</span>
									<div class="reg_content checkbox_area">
									<!-- 체크박스를 못 건드리게 하려면 disabled속성을 주면 되지만 선택된 값을 넘길수가 없게 된다. -->
										<input type="checkbox" class="css-checkbox" id="u_info" name="u_info" checked onclick="return false;" />
										<label for="u_info">동의함</label>
									</div>
								</li> 
							</ul>
							<p class="btn_line">
							<a href="javascript:;" onclick="location.href='/user/profileModify'" class="btn_baseColor">수정</a>
							<a href="javascript:;" onclick="location.href='/user/passwordModifyPage'" class="btn_baseColor">비밀번호 변경</a>
							
							<a href="javascript:;" onclick="profileWithdraw();" class="btn_deleteColor">탈퇴</a>
							</p>	
						</fieldset>
					</form>
					<!-- //appForm -->
				</dd>
			</dl>
			<!-- //myinfo -->			
			
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->
		<form id="myPageForm" method="post">				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="u_no" value="${member.u_no}"/>
		</form>
<script>
	function profileWithdraw(){
		alert("정말로 탈퇴하시겠습니까?");
	
		$("#myPageForm").attr("action", "/user/profileDelete");
		$("#myPageForm").attr("method", "get");
		$("#myPageForm").submit();
	}
	
	var message = "${message}";
	if(message != null && message != ""){
		alert(message);
	}
</script>	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>