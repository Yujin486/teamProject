<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div id="container">
	<!-- location_area -->
	<div class="location_area member">
		<div class="box_inner">
			<h2 class="tit_page">TOURIST <span class="in">in</span> TOUR</h2>
			<p class="location">QnA <span class="path">/</span> 문의하기</p>
			<ul class="page_menu clear">
				<li><a href="javascript:;" class="on">문의하기</a></li>
			</ul>
		</div>
	</div>	
	<!-- //location_area -->

	<!-- bodytext_area -->
	<div class="bodytext_area box_inner">
		<!-- appForm -->
		<form action="/qnaboard/modifyPage" id="modifyForm" class="appForm" method="post" name="modifyForm">
			<input type="hidden" name="u_no" value="${board.u_no}">
			<input type="hidden" name="bno" value="${board.bno}">
			<input type="hidden" name="writer" value="${board.writer}">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<fieldset>
				<legend>문의하기 입력 양식</legend>
				<p class="info_notice">글 수정하기</p>
				<ul class="app_list">
					<li class="clear">
						<label for="name_lbl" class="tit_lbl">제목</label>
						<div class="app_content"><input type="text" name="title" class="w100p" id="title_lbl" value="${board.title}" required/></div>
					</li>
					<li class="clear">
						<label for="content_lbl" class="tit_lbl">내용</label>
						<div class="app_content"><textarea id="content_lbl" name="content" class="w100p">${board.content}</textarea></div>
					</li>
					<li class="clear">
						<label for="name_lbl" class="tit_lbl">첨부파일</label>
						<div class="app_content" id="attachList"></div>
					</li>
				</ul>
				<p class="btn_line">
					<a href="#"  id="submit_lbl" class="btn_baseColor">등록</a>
				</p>	
			</fieldset>
		</form>
		<!-- //appForm -->
		
	</div>
	<!-- //bodytext_area -->

</div>
<!-- //container -->

<script>
	$("#submit_lbl").click(function(event){
		event.preventDefault();
		$("#modifyForm").submit();
	}); 
	
var bno = ${board.bno}
	
	function getFileInfo(fullName){
		var fileName, getLink;
		getLink = "/displayFiles?fileName="+encodeURI(fullName);
		fileName = fullName.substr(fullName.lastIndexOf("_")+1);
		return {fileName : fileName, fullName : fullName, getLink : getLink}
	}
	
	$.getJSON("/qnaboard/getAttach/"+bno, function(data){
		console.log(data);
		$(data).each(function(){
			var fileInfo = getFileInfo(this);
			console.log(fileInfo)
			var html = "<span>";
				html += "<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a>";
				html += "<a href='"+fileInfo.fullName+"' class='delBtn'>X</a>";
				html += "</span>&nbsp;";
			$("#attachList").append(html);
		});
	});
	
	$("#attachList").on("click", ".delBtn", function(event){
		event.preventDefault();
		var fileLink = $(this).attr("href");
		var target = $(this);
		$.ajax({
			type : "post",
			url : "/deleteFileA",
			data : {
				fileName : fileLink,
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			dataType : "text",
			success : function(data){
				alert(data);
				target.closest("span").remove();
			}
		});
	});
	
	$("#submit_lbl").click(function(event){
		event.preventDefault();
		
		var str = "";
		var fileList = $("#attachList .delBtn");
		
		$(fileList).each(function(index){
			str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"'/>";
		});
		
		$("#modifyForm").append(str);
		
		$("#modifyForm").submit();
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>