<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="member" property="principal.member"/>
</sec:authorize>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div id="container">
		<!-- location_area -->
		<div class="location_area member">
			<div class="box_inner">
				<h2 class="tit_page">부산 맛집</h2>
				<p class="location">Management <span class="path">/</span> 회원 관리</p>
				<ul class="page_menu clear">
					<li><a href="/mngt/memberList" class="on">회원 관리</a></li>
				</ul>
			</div>
		</div>	
		<!-- location_area -->
		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<form action="#" class="minisrch_form">
				<fieldset>
					<select name="searchType">
						<option value="n" ${cri.searchType == null ? 'selected' : ''}>---선택해주세요---</option>
						<option value="b" ${cri.searchType == 'b' ? 'selected' : ''}>회원번호</option>
						<option value="i" ${cri.searchType == 'i' ? 'selected' : ''}>아이디</option>
						<option value="m" ${cri.searchType == 'm' ? 'selected' : ''}>이름</option>
						<option value="w" ${cri.searchType == 'w' ? 'selected' : ''}>탈퇴여부</option>
					</select>
					<legend>검색</legend>
					<input type="text" name="keyword" id="keyword" class="tbox" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요">
					<a href="javascript:;" id="searchBtn" class="btn_srch">검색</a>
				</fieldset>
			</form>
			<table class="bbsMbListTbl" summary="번호,제목,조회수,작성일 등을 제공하는 표">
				<caption class="hdd">공지사항  목록</caption>
				<thead>
					<tr>
						<th scope="col">회원번호</th>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">가입일</th>
						<th scope="col">탈퇴여부</th>
						<th scope="col">권한</th>
						<th scope="col">권한부여</th>
						<th scope="col">카테고리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="members" items="${memberList}">
							<tr>
								<td>${members.u_no}</td>
								<td id="userid">${members.u_id}</td>
								<td>${members.u_name}</td>
								<td><f:formatDate pattern="yyyy-MM-dd" value="${members.u_date}"/></td>
								<td>
									<select class="deleteMember">
										<option value="n" <c:out value="${members.u_withdraw == 'n' ? 'selected' : ''}"/>>
											활성화
										</option>
										<option value="y" <c:out value="${members.u_withdraw == 'y' ? 'selected' : ''}"/>>
											탈퇴
										</option>
									</select>
									<input type="button" class="deleteBtn" value="변경"/>
								</td>
								<td id="memberAuth">
									<c:forEach var="memberAuth" items="${members.authList}">
										<c:if test="${memberAuth.auth eq 'ROLE_USER'}">사용자</c:if>
										<c:if test="${memberAuth.auth eq 'ROLE_MASTER'}">관리자</c:if>
									</c:forEach>
								</td>
								<td>	
									<c:if test="${members.u_withdraw eq 'n'}">
										<select class="changeAuth">
											<option disabled selected>선택</option>
											<option value="ROLE_USER">사용자</option>
											<option value="ROLE_MASTER">관리자</option>
										</select>
									</c:if>
								</td>
								<td>${members.u_category}</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- pagination -->
			<div class="pagination">
				<c:if test="${pageMaker.prev}">
					<a href="/mngt/memberList${pageMaker.makeSearchQuery(1)}" class="firstpage  pbtn"><img src="${path}/resources/img/btn_firstpage.png" alt="첫 페이지로 이동"></a>
					<a href="/mngt/memberList${pageMaker.makeSearchQuery(pageMaker.startPage-1)}" class="prevpage  pbtn"><img src="${path}/resources/img/btn_prevpage.png" alt="이전 페이지로 이동"></a>					
				</c:if>
				<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
					<a href="/mngt/memberList${pageMaker.makeSearchQuery(i)}">
						<span ${pageMaker.cri.page == i ? "class='pagenum currentpage'" : "class=pagenum"}>${i}</span>
					</a>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<a href="/mngt/memberList${pageMaker.makeSearchQuery(pageMaker.endPage +1)}" class="nextpage  pbtn"><img src="${path}/resources/img/btn_nextpage.png" alt="다음 페이지로 이동"></a>
					<a href="/mngt/memberList${pageMaker.makeSearchQuery(pageMaker.maxPage)}" class="lastpage  pbtn"><img src="${path}/resources/img/btn_lastpage.png" alt="마지막 페이지로 이동"></a>
				</c:if>
			</div>
			<!-- //pagination -->
			
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->
<script>
	$("#searchBtn").click(function(){
		var searchValue = $("select option:selected").val();
		var keywordValue = $("#keyword").val();
		console.log(searchValue + " / " + keywordValue);
		location.href="/mngt/memberList?searchType="+searchValue+"&keyword="+keywordValue;
		$("#searchForm").submit();
	});
	 
	$(".deleteBtn").on("click", function(){
		event.preventDefault();
		var u_delete = $(this).parent().find(".deleteMember").val();
		console.log(u_delete);
		var parentTr = $(this).parent().parent();
		var u_id = parentTr.find("#userid").text();
		
		$.post("/mngt/user/delete",
				{u_id:u_id, u_withdraw:u_delete, '${_csrf.parameterName}': '${_csrf.token}'},
				function(data){
				console.log(data);
		});
	});
	
	$(".changeAuth").on("change", function(){
		var parentTr = $(this).parent().parent();
		var u_id = parentTr.find("#userid").text();
		var changeAuthValue = $(this).val();
		
		console.log(u_id+" // "+changeAuthValue);
		
		$.post("/mngt/user/changeAuth", 
				{u_id:u_id, auth:changeAuthValue, '${_csrf.parameterName}':'${_csrf.token}'},
				function(data){
					console.log(data);
					
					var str = "";
					$(data).each(function(){
						if(this.auth == 'ROLE_USER'){
							str += "사용자&nbsp;";
						}else if(this.auth == 'ROLE_MASTER'){
							str += "관리자&nbsp;";
						}
					});
					parentTr.find("#memberAuth").html(str);
		});
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>