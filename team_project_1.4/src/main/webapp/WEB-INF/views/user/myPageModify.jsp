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
		<p class="location">MEMBER <span class="path">/</span> 회원 정보 수정</p>
		<ul class="page_menu clear">
			<li><a href="javascript:;" class="on">회원 정보 수정</a></li>
		</ul>
	</div>
 </div>	
</div>
<!-- //location_area -->

<!-- bodytext_area -->
<div class="bodytext_area box_inner">
	<!-- appForm -->
	<form action="/user/profileModify" id="profileForm" name="profileForm"  class="appForm" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="hidden" name="u_no" value="${member.u_no}"/>
	<input type="hidden" name="u_pw" value="${member.u_pw}"/>
		<fieldset>
			<legend>회원가입 정보 수정 </legend>
			<p class="info_pilsoo pilsoo_item">필수입력</p>
			<ul class="app_list">
				<li class="clear">
                          <label for="u_id" class="tit_lbl pilsoo_item" >아이디</label>
                          <div class="app_content email_area">    
                          <br>${member.u_id}                
                              <div class="result"></div>	
                           </div>	                          								                          
                 </li>
				<li class="clear">
					<label for="u_name" class="tit_lbl pilsoo_item">이름</label>
					<div class="app_content">
					<input type="text" class="w100p" id="u_name" name="u_name" value="${member.u_name}" required/>
					<div class="result"></div>	
					</div>
					
				</li>
				<c:choose>
				<c:when test="${member.u_category == 'naver'}">
					<li class="clear">
						<label for="phone" class="tit_lbl pilsoo_item">연락처</label>
						<div class="app_content"><input type="tel" class="w100p" id="u_phone" name="u_phone"  value="" required/>
						<div class="result"></div></div>
					</li>
				</c:when>
				<c:otherwise>
					<li class="clear">
						<label for="phone" class="tit_lbl pilsoo_item">연락처</label>
						<div class="app_content"><input type="tel" class="w100p" id="u_phone" name="u_phone"  value="${member.u_phone}" required/>
						<div class="result"></div></div>
					</li>
				</c:otherwise>
				</c:choose>
				<li class="clear">
					<label for="u_addr" class="tit_lbl pilsoo_item">주소</label>
					<div class="app_content">
						<div class="row">
							<div class="col-md-4">
								<input type="text" style="width:40%; display:inline;" id="u_addr_post" name="u_addr_post" value="${member.u_addr_post}" required/>
								<input type="button" class="form-control btn_postColor" onclick="sample6_execDaumPostcode();" value="우편번호 찾기" />
							</div>
							<div class="col-md-4">
							   
							</div>
						</div>
						<br/>
						<input type="text" class="w100p"  name="u_addr" id="u_addr"  value="${member.u_addr}" required />
						 <br/>
						 <input type="text" class="w100p"   name="u_addr_detail" id="u_addr_detail"  value="${member.u_addr_detail}" required/>
					</div>
				</li>
				<li class="clear">
					<label for="u_birth" class="tit_lbl pilsoo_item">생년월일</label>
					<div class="app_content"><input type="text" class="w100p" name="u_birth" id="u_birth"  value="${member.u_birth}" required/>
						<div class="result"></div>
					</div>
				</li>				
			</ul>					
			<p class="btn_line"><a href="javascript:;"  id="profileModifyBtn" class="btn_baseColor">확인</a></p>	
		</fieldset>
		
	</form>
	<!-- //appForm -->
	
</div>
<!-- //bodytext_area -->


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- //container -->
<script type="text/javascript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  <script>
      function sample6_execDaumPostcode(){
      	new daum.Postcode({
      		oncomplete : function(data){
      			//주소검색결과
      			console.log(data);
      			
      			var fullAddr='';
      			var extraAddr='';
      			
      			if(data.userSelectedType ==='R'){
      				fullAddr = data.roadAddress;
      			}else{
      				fullAddr = data.jibunAddress;
      			}
      			if(data.userSelectedType === 'R'){
      				if(data.bname !== ''){
      					extraAddr += data.bname;
      				}
      			
      			if(data.buildingName !==''){
      				extraAddr += (extraAddr !== '' ?',' +
      						data.buildingName :
      							data.buildingName);
      			}
      			fullAddr += (extraAddr !== '' ? ' ('+extraAddr+')' :'');
      		}
      	
      	    $("#u_addr_post").val(data.zonecode);
      	    $("#u_addr").val(fullAddr);
      	    $("#u_addr_detail").focus();
               }
      	}).open();
      }
      
  </script>
<script>
     $(function(){
    	
    	$("#u_id").focus();
    	
    	var boolUName = true;
    	var boolUPhone = true;
    	var boolUAddress = true; 
    	var boolUBirth = true;
    	              	
        var regexName = /^[\uac00-\ud7a3]{2,6}$/;							// 한글 영문 포함 2~6자 이내 
        var regexPhone = /^[0-9]{3,4}[0-9]{3,4}[0-9]{4}$/;							// mobile -표시 없이 숫자만
        var regexBirth = /^[0-9]{4}[0-9]{2}[0-9]{2}$/;							// 생년월일  19820607
        
        //유효성 검사
        function checkRegex(elP, valP, regexP, messageP,ajaxP){
        	if(regexP.test(valP) === false){
        		showErrorMessage(elP,messageP,false);
        		return false;
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
       
        $("#u_name").on("input",function(){
        	var tempVal = $(this).val();
        	var elP = $(this).parent().find(".result");
        	var message = "한글 2~6자 이내 작성";
        	boolUName = checkRegex(elP,tempVal,regexName,message,null);
        });
        
        $("#u_phone").on("input",function(){
        	var tempVal = $(this).val();
			var elP = $(this).parent().find(".result");
			var message = "-제외 숫자만 작성";
			boolUPhone = checkRegex(elP,tempVal,regexPhone,message,null);
		});
        
        
        $("#u_birth").on("input",function(){
        	var tempVal = $(this).val();
        	var elP = $(this).parent().find(".result");
        	var message = "숫자만 입력해주세요 ex)19990101";
            boolUBirth = checkRegex(elP,tempVal,regexBirth,message,null);
        });
        
        function checkAddr(){
        	console.log($("#u_addr_post").val() !=='');
        	console.log($("#u_addr").val() !=='');
        	console.log($("#u_addr_detail").val() !=='');
        	if(
        	          ($("#u_addr_post").val() !== '')
        	          &&
        	          ($("#u_addr").val() !=='')
        	          &&
        	          ($("#u_addr_detail").val() !=='')
        	){
        		boolUAddress = true;
        	}else{
        		boolUAddress = false;
        	}
        	console.log(boolUAddress);
        }
               
        
        $("#profileModifyBtn").click(function(event){
        	event.preventDefault();
        	checkAddr();
        	
        	 if(!boolUName){
           		 alert("이름 정보를 확인해주세요");
           		 $("#u_name").focus();
           	 }else if(!boolUPhone){
           		 alert("전화번호를 확인해주세요");
           		 $("#u_phone").focus();
           	 }else if(!boolUBirth){
           		 alert("생년월일을 확인해주세요");
           		 $("#u_birth").focus();
           	 }else if(!boolUAddress){
           		 console.log(boolUAddress);
           		 alert("주소를 확인해주세요");
           		 $("#u_addr_post").focus();
           	 }else{
           		alert("수정하시겠습니까?");
            	$("#profileForm").submit(); 
           	 }
        });
    });

</script>
    