<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
<sec:authentication var="member" property="principal.member"/>
</sec:authorize>

<div id="container">
		<!-- location_area -->
<div class="location_area ticket">
	<div class="box_inner">
		<h2 class="tit_page">부산 맛집</h2>
		<p class="location">MEMBER <span class="path">/</span> 비밀번호 수정</p>
		<ul class="page_menu clear">
			<li><a href="javascript:;" class="on">비밀번호 수정</a></li>
		</ul>
	</div>
 </div>	
</div>
<!-- //location_area -->

<!-- bodytext_area -->
<div class="bodytext_area box_inner">
	<!-- appForm -->
	<form action="/user/passwordModify" id="passForm" name="passForm"  class="appForm" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="u_no" value="${member.u_no}"/>
	<input type="hidden" name="u_pwChange" value="${member.u_pwChange}" />
		<fieldset>
			<legend>비밀번호 수정 </legend>
			<p class="info_pilsoo pilsoo_item">필수입력</p>
			<ul class="app_list">				
				<c:if test="${member.u_pwChange == '1'}">
					<li class="clear">
						<label for="u_pw" class="tit_lbl pilsoo_item">현재 비밀번호</label>
						<div class="app_content">
						 <input type="password" class="w40p" id="now_u_pw" name="now_u_pw" value="" required/>
						<div class="result"></div>	
						</div>					
					</li>
				</c:if>
				<li class="clear">
					<label for="u_pw" class="tit_lbl pilsoo_item">새 비밀번호</label>
					<div class="app_content">
					 <input type="password" class="w40p" id="new_u_pw" name="u_pw" value="" required/>
					<div class="result"></div>	
					</div>					
				</li>
				<li class="clear">
					<label for="u_pw" class="tit_lbl pilsoo_item">새 비밀번호 확인</label>
					<div class="app_content">
					 <input type="password" class="w40p" id="new_u_repw" name="u_repw" value="" required/>
					<div class="result"></div>	
					</div>					
				</li>
			</ul>	
			<c:choose>
				<c:when test="${member.u_pwChange == '1'}">
					<p class="btn_line"><a href="javascript:;"  id="passModifyBtn" class="btn_baseColor">확인</a></p>	
				</c:when>
				<c:otherwise>
					<p class="btn_line"><a href="javascript:;"  id="ModifyBtn" class="btn_baseColor">확인</a></p>	
				</c:otherwise>
			</c:choose>
		</fieldset>
		
	</form>
	<!-- //appForm -->
	
</div>
<!-- //bodytext_area -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>

var header = "${_csrf.headerName}";
var token = "${_csrf.token}"; 

$(function(){
	
	$("#now_u_pw").focus();
	
	var boolUPassword = false;
	var boolUPwCheck = false;
	
	var regexPass = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;					// 영문,숫자를 혼합하여 6~20자 이내

    //유효성 검사
    function checkRegex(elP, valP, regexP, messageP, ajaxP){
    	if(regexP.test(valP) === false){
    		showErrorMessage(elP,messageP,false);
    		return true;
    	}else if(regexP.test(valP) !== false && ajaxP === null){
    		showErrorMessage(elP,'사용가능합니다.' , true);
    		return true;
    	}else{
    		if(ajaxP !==null){
    			ajaxP(elP);
    		}
    	}
    }

    function showErrorMessage(elP,messageP,isChecked){
    	var html = '<span style="margin-left:5px;font-size:12px;';
    	html += isChecked ? 'color:green;' :'color:red;';
    	html +='">';
    	html += messageP;
    	html += '</span>';
    	
    	$(elP).html(html);
    }
    
	$("#now_u_pw").on("input", function(){
		var tempVal = $(this).val();
		console.log(tempVal);
		var elP = $(this).parent().find(".result");
		var message = "영문/숫자 조합하여 6~20자 이내 작성해주세요.";
		boolUPassword = checkRegex(elP, tempVal, regexPass, message, checkUPwAjax);
	});
 
	function checkUPwAjax(elP){
		$.ajax({
			type:"post",
			url:'${path}/user/uPwCheck',
			dataType:'json',
			beforeSend : function(xhr){
				  xhr.setRequestHeader(header, token);
			}, 
			data:{ 
				now_u_pw : $("#now_u_pw").val()
			},
			success: function(data, jqXHR){
				console.log("isChecked :" +data);
				if(data){		
					showErrorMessage(elP,"비밀번호 일치", true);
					boolUPwCheck = true;
				}else{
					showErrorMessage(elP,"비밀번호 불일치",false);
					boolUPwCheck = false;
				}
			}
	    });
	}

	$("#new_u_pw").on("input", function(){
		var tempVal = $(this).val();
		var elP = $(this).parent().find(".result");
		var message = "영문/숫자 조합하여 6~20자 이내 작성";
		boolUPassword = checkRegex(elP,tempVal,regexPass, message, null);
	});

	$("#new_u_repw").on("input",function(){
		var tempVal = $(this).val();
		var originVal = $("#new_u_pw").val();
		var elP = $(this).parent().find(".result");
		var message = "";
		
		if(boolUPassword){
			if(tempVal == originVal){
				boolUPasswordCheck = true;
				message = "비밀번호가 일치합니다.";
			}else{
				boolUPasswordCheck = false;
				message = "비밀번호가 일치하지 않습니다.";
			}
		}else{
			boolUPasswordCheck = false;
			message = "비밀번호를 확인해주세요";
		}
		showErrorMessage(elP,message,boolUPasswordCheck);
	});

	$("#passModifyBtn").click(function(event){
		 event.preventDefault();
		 if(!boolUPwCheck){
			 alert("비밀번호가 틀립니다.");
			 $("#now_u_pw").focus();
		 }else if(!boolUPassword){
			 alert("새 비밀번호를 확인해주세요");
			 $("#new_u_pw").focus();
		 }else if(!boolUPasswordCheck){
			 alert("새 비밀번호와 일치하지 않습니다");
			 $("#new_u_repw").focus();
		 }else{
			 $("#passForm").submit(); 
		 }
	});
	
	$("#ModifyBtn").click(function(event){
		 event.preventDefault();
		 if(!boolUPassword){
			 alert("새 비밀번호를 확인해주세요");
			 $("#new_u_pw").focus();
		 }else if(!boolUPasswordCheck){
			 alert("새 비밀번호와 일치하지 않습니다");
			 $("#new_u_repw").focus();
		 }else{
			 $("#passForm").submit(); 
		 }
	});
});
</script>