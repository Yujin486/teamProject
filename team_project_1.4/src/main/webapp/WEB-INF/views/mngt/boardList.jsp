<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="member" property="principal.member"/>
</sec:authorize>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/>
<div id="container">
		<!-- location_area -->
		<div class="location_area member">
			<div class="box_inner">
				<h2 class="tit_page">부산 맛집</h2>
				<p class="location">Management <span class="path">/</span> 게시물 관리</p>
				<ul class="page_menu clear">
					<li><a href="/mngt/boardList" class="on">게시물 관리</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->
		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<form action="#" class="minisrchBl_form">
				<fieldset>
					<legend>검색</legend>
					<input type="text" name="keyword" id="keyword" class="tbox" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요">
					<a href="javascript:;" id="searchBtn" class="btn_srch">검색</a>
				</fieldset>
			</form>
			<p class="txt_left">
				<input type="button" id="selectDelete" class="btn_type2" value="삭제">
			</p>
			<table class="bbsBlListTbl" summary="번호,제목,조회수,작성일 등을 제공하는 표">
				<caption class="hdd">내글  목록</caption>
				<thead>
					<tr>
						<th scope="col">
							<input type="checkbox" class="css-checkbox" id="allCheck"/>
							<label for="allCheck"></label>
						</th>
						<!-- <th scope="col"><input type="button" class="btn_icon_select" id="allCheck" value="전체 선택"/></th> -->
						<th scope="col">글 번호</th>
						<th scope="col">게시판명</th>
						<th scope="col">제목</th>
						<th scope="col">조회수</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="board" items="${boardList}">
						<tr>
							<td>
								<input type="checkbox" class="css-checkbox" id="check_${board.boardName}_${board.bno}" name="checkRow" data-boardName="${board.boardName}" data-bno="${board.bno}"/>
								<label for="check_${board.boardName}_${board.bno}"></label>
							</td>
							<td>${board.bno}</td>
							<td>${board.boardName}</td>
							<td class="tit_notice">
								<%-- <a href="/reboard/readPage${pageMaker.makeSearchQuery(pageMaker.cri.page)}&bno=${board.bno}">${board.title}</a> --%>
								<c:choose>
									<c:when test="${board.boardName == 'notice'}">
										<a href="/reboard/readPage?bno=${board.bno}">${board.title}</a>
									</c:when>
									<c:when test="${board.boardName == 'QnA'}">
										<a href="/qnaboard/read?bno=${board.bno}">${board.title}</a>
									</c:when>
									<c:otherwise>
										<a href="/imgboard/imgViewPage?bno=${board.bno}">${board.title}</a>
									</c:otherwise>
								</c:choose>
							</td>
							<td>${board.viewcnt}</td>
							<td><f:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.updatedate}"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- pagination -->
			<div class="pagination">
				<c:if test="${pageMaker.prev}">
					<a href="/mngt/boardList${pageMaker.makeSearchQuery(1)}" class="firstpage  pbtn"><img src="${path}/resources/img/btn_firstpage.png" alt="첫 페이지로 이동"></a>
					<a href="/mngt/boardList${pageMaker.makeSearchQuery(pageMaker.startPage-1)}" class="prevpage  pbtn"><img src="${path}/resources/img/btn_prevpage.png" alt="이전 페이지로 이동"></a>					
				</c:if>
				<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
					<a href="/mngt/boardList${pageMaker.makeSearchQuery(i)}">
						<span ${pageMaker.cri.page == i ? "class='pagenum currentpage'" : "class=pagenum"}>${i}</span>
					</a>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<a href="/mngt/boardList${pageMaker.makeSearchQuery(pageMaker.endPage +1)}" class="nextpage  pbtn"><img src="${path}/resources/img/btn_nextpage.png" alt="다음 페이지로 이동"></a>
					<a href="/mngt/boardList${pageMaker.makeSearchQuery(pageMaker.maxPage)}" class="lastpage  pbtn"><img src="${path}/resources/img/btn_lastpage.png" alt="마지막 페이지로 이동"></a>
				</c:if>
			</div>
			<!-- //pagination -->
			
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->
<script>
	$("#searchBtn").click(function(){
		var keywordValue = $("#keyword").val();
		console.log(keywordValue);
		location.href="/mngt/boardList?keyword="+keywordValue;
		$("#searchForm").submit();
	});
	
	/* 전체 선택 */
	$("#allCheck").click(function(){
		var check = $("#allCheck").prop("checked");
		if(check){
			$("input[name=checkRow]").prop("checked", true);
		}else{
			$("input[name=checkRow]").prop("checked", false);
		}
		console.log(check);
	});
	
	/* 전체 선택후 개별 선택 취소할때 전체 선택 해제 */
	$("input[name=checkRow]").click(function(){
		$("#allCheck").prop("checked", false);
	});
	
	/* 선택 삭제 */
	$("#selectDelete").click(function(){
		console.log('버튼 꾹');
		var confirm_val = confirm("정말 삭제하시겠습니까?");
		  
		if(confirm_val){
			var checkArrBno = new Array();
			var checkArrName = new Array();
			console.log($("input[name=checkRow]:checked").length);
			
			$("input[name=checkRow]:checked").each(function(){
				bno = $(this).attr("data-bno");
				boardName = $(this).attr("data-boardName");
				checkArrBno.push(bno);
				checkArrName.push(boardName);
			});
			console.log(checkArrBno);
			console.log(checkArrName);
			
			$.ajax({
				url : "${path}/mngt/deleteRow",
				type : "post",
				data : {
					chbox1 : checkArrBno,
					chbox2 : checkArrName,
					'${_csrf.parameterName}':'${_csrf.token}'
					},
				success : function(data){
					console.log(data);
					alert("게시물이 삭제되었습니다");
					location.href = "/mngt/boardList"
				}
			});
			console.log("check");
		}
		
		/* if(confirm_val){
			var checkArrBno = new Array();
			var checkArrName = new Array();
			console.log($("input[name=checkRow]:checked").length);
			
			$("input[name=checkRow]:checked").each(function(){
				bno = $(this).attr("data-bno");
				boardName = $(this).attr("data-boardName");
				$.ajax({
					url : "${path}/mngt/deleteRow",
					type : "post",
					data : {
						chbox1 : bno,
						chbox2 : boardName,
						'${_csrf.parameterName}':'${_csrf.token}'
						},
					success : function(data){
						console.log(data);
						alert("게시물이 삭제되었습니다");
						location.href = "/mngt/boardList"
					}
				});
			});
			console.log(checkArrBno);
			console.log(checkArrName);
			
			
			console.log("check");
		} */
		/* 
		if(confirm_val){
			var checkArr = new Array();
			var checkMap = new Map();
			var checkLength = $("input[name=checkRow]:checked").length;
			console.log("checkLength : "+checkLength);
			
			for(var i=0; i<checkLength; i++){
				var bno = $("input[name=checkRow]:checked").attr("data-bno");
				checkMap.set("bno"+[i], bno);
				var boardName = $("input[name=checkRow]:checked").attr("data-boardName");
				checkMap.set("boardName"+[i], boardName);
				checkArr.push(checkMap);
			}
			console.log(checkArr);
		}	 */
		/* 
		if(confirm_val){
			var checkMap = new Map();
			var checkArr = new Array();
			var checkLength = $("input[name=checkRow]:checked").length;
			console.log("checkLength : "+checkLength);
			
			$("input[name=checkRow]:checked").each(function(){
				checkMap.set("bno", $(this).attr("data-bno"));
				checkMap.set("boardName", $(this).attr("data-boardName"));
				console.log(checkMap);
				checkArr.push(checkMap);
			});
			console.log(checkMap);
			console.log(checkArr);
		} */
		/*  
		if(confirm_val){
			var checkMap = new Map();
			var checkArr = new Array();
			var checkLength = $("input[name=checkRow]:checked").length;
			console.log("checkLength : "+checkLength);
			
			$("input[name=checkRow]:checked").each(function(){
				bno = $(this).attr("data-bno");
				boardName = $(this).attr("data-boardName");
				checkArr.push(bno, boardName);
				checkMap.set("checkArr", checkArr);
			});
			console.log(checkMap);
		} */
		/*  
		if(confirm_val){
			var checkArr = new Array();
			var checkJson = new Object();
			var checkLength = $("input[name=checkRow]:checked").length;
			console.log("checkLength : "+checkLength);
			
			$("input[name=checkRow]:checked").each(function(){
				checkJson.bno = $(this).attr("data-bno");
				console.log(checkJson.bno);
				checkJson.boardName = $(this).attr("data-boardName");
				console.log(checkJson.boardName);
				checkArr.push(checkJson);
				console.log(checkJson);
				console.log("하나 끝");
			});
			console.log(checkArr);
		} */
		/* if(confirm_val){
			var checkArr = new Array();
			var checkJson = new Object();
			var checkLength = $("input[name=checkRow]:checked").length;
			console.log("checkLength : "+checkLength);
			
			for(var i=0; i<checkLength; i++){
				checkJson.bno = $("input[name=checkRow]:checked").attr("data-bno");
				console.log(checkJson.bno);
				checkJson.boardName = $("input[name=checkRow]:checked").attr("data-boardName");
				console.log(checkJson.boardName);
				checkArr.push(checkJson);
				console.log(checkJson);
				console.log("하나 끝");
			}
			console.log(checkArr);
		} */
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>