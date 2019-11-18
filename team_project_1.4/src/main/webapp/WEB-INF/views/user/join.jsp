<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <jsp:include page="/WEB-INF/views/asd.jsp" /> --%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
<div id="container">
		<!-- location_area -->
<div class="location_area ticket">
	<div class="box_inner">
		<h2 class="tit_page">부산 맛집</h2>
		<p class="location">MEMBER <span class="path">/</span> 회원가입</p>
		<ul class="page_menu clear">
			<li><a href="javascript:;" class="on">회원가입</a></li>
		</ul>
	</div>
 </div>	
</div>
<!-- //location_area -->

<!-- bodytext_area -->
<div class="bodytext_area box_inner">
	<!-- appForm -->
	<form action="/user/joinPost" id="joinForm" name="joinForm"  class="appForm" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<fieldset>
			<legend>상담문의 입력 양식</legend>
			<p class="info_pilsoo pilsoo_item">필수입력</p>
			<ul class="app_list">
				<li class="clear">
					<label for="u_id" class="tit_lbl pilsoo_item" >아이디</label>
					<div class="app_content email_area">
					<input type="text" class="w100p" id="u_id" name="u_id" placeholder="이메일 주소" />
					<div class="result"></div>	
					</div>	
                </li>
				<li class="clear">
					<label for="u_name" class="tit_lbl pilsoo_item">이름</label>
					<div class="app_content">
					<input type="text" class="w100p" id="u_name" name="u_name" placeholder="이름을 입력해주세요"/>
					<div class="result"></div>	
					</div>
				</li>
				<li class="clear">
					<label for="u_pw" class="tit_lbl pilsoo_item">비밀번호</label>
					<div class="app_content"><input type="password" class="w100p" name="u_pw" id="u_pw" placeholder="비밀번호를 입력해주세요"/>
					<div class="result"></div></div>
				</li>
				<li class="clear">
					<label for="u_repw" class="tit_lbl pilsoo_item">비밀번호 확인</label>
					<div class="app_content"><input type="password" class="w100p" id="u_repw" placeholder="비밀번호를 다시 한번 입력해주세요"/>
					<div class="result"></div></div>
				</li>
				<li class="clear">
					<label for="phone" class="tit_lbl pilsoo_item">연락처</label>
					<div class="app_content"><input type="tel" class="w100p" id="u_phone" name="u_phone" placeholder="휴대폰”-”없이 숫자만 입력하세요"/>
					<div class="result"></div></div>
				</li>
				<li class="clear">
					<label for="u_addr" class="tit_lbl pilsoo_item">주소</label>
					<div class="app_content">
						<div class="row">
							<div class="col-md-4">
								<input type="text" style="width:40%; display:inline;" id="u_addr_post" name="u_addr_post" placeholder="우편번호를 입력해주세요"/>
								<!-- <input type="button" class="form-control btn_postColor" onclick="sample6_execDaumPostcode();" value="우편번호 찾기" /> -->
								<a href="#" class="form-control btn_postColor" onclick="sample6_execDaumPostcode();">우편번호 찾기</a>
							</div>
							<div class="col-md-4">
							   
							</div>
						</div>
						<br/>
						<input type="text" class="w100p"  name="u_addr" id="u_addr" placeholder="주소를 입력해주세요" />
						 <br/>
						 <input type="text" class="w100p"   name="u_addr_detail" id="u_addr_detail" placeholder="상세주소를 입력해주세요"/>
					</div>
				</li>
				<li class="clear">
					<label for="u_birth" class="tit_lbl pilsoo_item">생년월일</label>
					<div class="app_content"><input type="text" class="w100p" name="u_birth" id="u_birth" placeholder="생년월일(ex-19880204)를 입력해주세요"/>
						<div class="result"></div>
					</div>
				</li>
				<li class="clear">
					<span class="tit_lbl pilsoo_item">개인정보 활용동의</span>
					<div class="app_content checkbox_area">
						<input type="checkbox" class="css-checkbox" id="u_info" name="u_info" />
						<label for="u_info">동의함</label>
					</div>
				</li> 
				<li class="clear">
					<label for="content_lbl" class="tit_lbl">문의내용</label>
					<div class="app_content">
						<textarea id="content_lbl" class="w100p" placeholder="간단한 상담 요청 사항을 남겨주시면 보다 상세한 상담이 가능합니다. 전화 상담 희망시 기재 부탁드립니다."></textarea>
					</div>
				</li>
					</ul>
					<!-- <p class="btn_line"><input type="button" id="joinBtn" class="form-control btn btn-prinary" value="회원가입"/></p> -->
			<p class="btn_line"><a href="/joinPost"  id="joinBtn" class="btn_baseColor">회원가입</a></p>	
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

      유효성 검사
     
    <script>
         $(function(){
        	
        	$("#u_id").focus();
        	
        	var boolUId = false;
        	var boolUPassword = false;
        	var boolUPhone = false;
        	var boolUName = false;
        	var boolUBirth = false;
        	var boolUAddress = false;
        	var boolUInfo = false; 
        	
        	var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;       // 이메일
        	var regexPass = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;					// 영문,숫자를 혼합하여 6~20자 이내
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
            
            $("#u_id").on("input", function(){
            	
            	var tempVal = $(this).val();
            	
            	console.log(tempVal);
            	
            	var elP = $(this).parent().find(".result");
            	
            	var message = "올바른 이메일 형식이 아닙니다.";
            	
            	boolUId = checkRegex(elP,tempVal,regexEmail,message,checkUidAjax);
            });
            
            function checkUidAjax(elP){
            	$.ajax({
            		type:"post",
            		url:'${path}/user/uIdCheck',
            		dataType:'json',
            		data:{
            			u_id : $("#u_id").val(),
            			'${_csrf.parameterName}' : '${_csrf.token}' 
            		},
            		success: function(data){
            			console.log("isChecked :" +data);
            			if(data){
            				showErrorMessage(elP,"사용가능합니다.",true);
            				boolUId = true;
            			}else{
            				showErrorMessage(elP,"존재하는 아이디입니다.",false);
            				boolUId = false;
            			}
            		}
                });
            }
            
            $("#u_pw").on("input", function(){
            	var tempVal = $(this).val();
            	var elP = $(this).parent().find(".result");
            	var message = "영문/숫자 조합하여 6~20자 이내 작성";
            	boolUPassword = checkRegex(elP,tempVal,regexPass,message,null);
             });
            
            $("#u_repw").on("input",function(){
            	var tempVal = $(this).val();
            	var originVal = $("#u_pw").val();
            	var elP = $(this).parent().find(".result");
            	var message = "";
            	
            	if(boolUPassword){
            		if(tempVal == originVal){
            			boolUPasswordCheck = true;
            			message = "비밀번호가 일치합니다.";
            		}else{
            			boolUPasswordCheck = false;
            			message = "비밀번호가 일치 하지 않습니다.";
            		}
            	}else{
            		boolUPasswordCheck = false;
            		message = "비밀번호를 확인해주세요";
            	}
            	showErrorMessage(elP,message,boolUPasswordCheck);
            });
            
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
            
             $("#u_info").on("change" ,function(){
            	var isChecked = $(this).is(":checked");
            	console.log("isChecked u_info :" +isChecked);
            	if(isChecked){
            		boolUInfo = true;
            	}else{
            		boolUInfo = false;
            	}
            	
            }); 
            
            $("#joinBtn").click(function(event){
            	 event.preventDefault();
            	 checkAddr();
            	 
            	 if(!boolUId){
            		 alert("아이디를 확인해 주세요.");
            		 $("#u_id").focus();
            	 }else if(!boolUPassword){
            		 alert("비밀번호를 확인해주세요");
            		 $("#u_pw").focus();
            	 }else if(!boolUPasswordCheck){
            		 alert("비밀번호가 일치하지 않습니다");
            		 $("#u_repw").focus();
            	 }else if(!boolUName){
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
            	 }else if(!boolUInfo){
            		 alert("개인정보이용약관에 동의해 주세요");
            		 $("#u_info").focus(); 
            		 
            	 }else{
            		 $("#joinForm").submit(); 
            	 }
            });
        });
    
    </script>
</body>
</html>
    