<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="member" property="principal.member"/>
</sec:authorize>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div id="container">
		<!-- location_area -->
		<div class="location_area customer">
			<div class="box_inner">
				<h2 class="tit_page">부산 맛집</h2>
				<p class="location">QnA <span class="path">/</span> 문의하기</p>
				<ul class="page_menu clear">
					<li><a href="/reboard/listReply" class="on">문의하기</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">			
			<ul class="bbsview_list">
				<li class="bbs_title">${board.title}</li>
				<li class="bbs_writer">글쓴이 : <span>${board.writer}</span></li>
				<li class="bbs_hits">조회수 : <span>${board.viewcnt}</span></li>
				<li class="bbs_dates">작성일 : <span><f:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.updatedate}"/></span></li>
				<li class="bbs_content">
					<div class="editer_content">
					    ${board.content}
                    </div>
				</li>
				<li id="attachList" class="bbs_attach">첨부파일 </li>
			</ul>
			<br/>
			<p class="btn_line txt_right">
				<c:if test="${board.u_no == member.u_no}">
					<a href="#" id="modify" class="btn_modify">수정</a>
					<a href="#" id="delete" class="btn_delete">삭제</a>
				</c:if>
				<sec:authorize access="hasAnyRole('ROLE_MASTER')">
					<a href="#" id="reply" class="btn_regist">답글</a>
				</sec:authorize>
				<a href="#" id="list" class=btn_enter>목록</a>
			</p>
			<%-- <div>
				<c:if test="${!empty member}">
					<ul>
						<li>
							<input type="text" id="commentAuth" class="w20p" value="${member.u_name}" readonly/>
							<input type="text" id="commentText" class="w65p"/>
							<a id="commentAddBtn" class="btn_enter" style="margin:10px" />등록</a>
						</li>
					</ul>
				</c:if>
			</div> --%>
			<ul class="near_list mt20">
				<c:if test="${!empty prevBoard && board.depth == 0}">	
					<li><h4 class="next">답글</h4><a id="prevBoard" href="#">${prevBoard.title}</a></li>
				</c:if>	
			</ul>
			<form id="readForm" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" id="boardBno" name="bno" value="${board.bno}"/>
				<input type="hidden" name="page" value="${cri.page}"/>
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
				<input type="hidden" name="keyword" value="${cri.keyword}"/>
			</form>
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->
<script>
	
	var rf = $("#readForm");
	
	$("#nextBoard").click(function(event){
		event.preventDefault();
		$("#boardBno").val("${nextBoard.bno}");
		rf.attr("method", "get");
		rf.submit();
	});
	
	$("#prevBoard").click(function(event){
		event.preventDefault();
		$("#boardBno").val("${prevBoard.bno}");
		rf.attr("method", "get");
		rf.submit();
	});
	
	
	$("#list").click(function(){
		rf.attr("action", "/qnaboard/listReply");
		rf.attr("method", "get");
		rf.submit();
	});
	
	$("#modify").click(function(){
		rf.attr("action", "/qnaboard/modifyPage");
		rf.attr("method", "get");
		rf.submit();
	});
	
	$("#reply").click(function(){
		rf.attr("action", "/qnaboard/replyRegister");
		rf.attr("method", "get");
		rf.submit();
	});
	
	$("#delete").click(function(){
		var isDelete = confirm("첨부된 내용과 댓글이 모두 삭제됩니다.");
		if(isDelete){
			var arr = [];
			$("#attachList span").each(function(index){
				arr.push($(this).attr("data-src"));		
			});
			console.log(arr.length);
			if(arr.length > 0){
				$.post("/deleteAllFilesA", {files : arr}, function(result){
					console.log(result);
				});
			}
			rf.attr("action", "/qnaboard/remove");
			rf.attr("method", "post");
			rf.submit();
		}else{
			alert("삭제 요청이 취소되었습니다.");
		}
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
			var html = "<span data-src='"+fileInfo.fullName+"'>";
				html += "<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a>";
				html += "</span>&nbsp;";
			$("#attachList").append(html);
		});
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>