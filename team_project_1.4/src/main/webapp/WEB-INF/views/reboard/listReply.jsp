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
		<div class="location_area customer">
			<div class="box_inner">
				<h2 class="tit_page">부산 맛집</h2>
				<p class="location">Notice <span class="path">/</span> 공지사항</p>
				<ul class="page_menu clear">
					<li><a href="/reboard/listReply" class="on">공지사항</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->
		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<form action="#" class="minisrch_form">
				<fieldset>
					<legend>검색</legend>
					<input type="text" name="keyword" id="keyword" class="tbox" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요">
					<a href="javascript:;" id="searchBtn" class="btn_srch">검색</a>
					<sec:authorize access="hasRole('ROLE_MASTER')">
						<a href="/reboard/register" class="btn_regist">글쓰기</a>
					</sec:authorize>
				</fieldset>
			</form>
			<table class="bbsListTbl" summary="번호,제목,조회수,작성일 등을 제공하는 표">
				<caption class="hdd">공지사항  목록</caption>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">조회수</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="board" items="${list}">
					<c:choose>
						<c:when test="${board.showboard == 'y'}">
							<tr>
								<td>${board.bno}</td>
								<td class="tit_notice">
									<a href="/reboard/readPage${pageMaker.makeSearchQuery(pageMaker.cri.page)}&bno=${board.bno}">
										<c:if test="${board.depth != 0}">
											<c:forEach var="i" begin="1" end="${board.depth}">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</c:forEach>
											└<img src=""/>
										</c:if>
										${board.title}
									</a> 
								</td>
								<td>${board.viewcnt}</td>
								<td><f:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}"/></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td></td>
								<td>삭제된 게시물입니다.</td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</c:otherwise>
					</c:choose>
					</c:forEach>
				</tbody>
			</table>
			<!-- pagination -->
			<div class="pagination">
				<c:if test="${pageMaker.prev}">
					<a href="/reboard/listReply${pageMaker.makeSearchQuery(1)}" class="firstpage  pbtn"><img src="${path}/resources/img/btn_firstpage.png" alt="첫 페이지로 이동"></a>
					<a href="/reboard/listReply${pageMaker.makeSearchQuery(pageMaker.startPage-1)}" class="prevpage  pbtn"><img src="${path}/resources/img/btn_prevpage.png" alt="이전 페이지로 이동"></a>					
				</c:if>
				<!-- <a href="javascript:;"><span class="pagenum currentpage">1</span></a> -->
				<!--  ${pageMaker.cri.page == i ? 'class=pagenum currentpage' : 'class=pagenum'} -->
				<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
					<a href="/reboard/listReply${pageMaker.makeSearchQuery(i)}">
						<span ${pageMaker.cri.page == i ? "class='pagenum currentpage'" : "class=pagenum"}>${i}</span>
					</a>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<a href="/reboard/listReply${pageMaker.makeSearchQuery(pageMaker.endPage +1)}" class="nextpage  pbtn"><img src="${path}/resources/img/btn_nextpage.png" alt="다음 페이지로 이동"></a>
					<a href="/reboard/listReply${pageMaker.makeSearchQuery(pageMaker.maxPage)}" class="lastpage  pbtn"><img src="${path}/resources/img/btn_lastpage.png" alt="마지막 페이지로 이동"></a>
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
		location.href="/reboard/listReply?keyword="+encodeURI(keywordValue);
		//$("#searchForm").submit();
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>