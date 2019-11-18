<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/rollmain.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.easing.js"></script>	
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>  
<script src="${pageContext.request.contextPath}/resources/js/jquery.smooth-scroll.min.js"></script> 
<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
<style>
	.keywordnew{
		text-align:center;
		margin-top:2%; 
	}

	ul li{
		list-style:none;
	}
	
	.clear{
		clear:both;
	}
</style>
<div id="container">
		<!-- 메인 이미지 롤링 -->
        <div class="main_rolling_pc">
            <div class="visualRoll">
                <ul class="viewImgList">
                    <li class="imglist0">
                        <div class="roll_content">                	
                            <a href="javascript:;" class="roll_txtline">인기 맛집 베스트 Top3</a>                 
                        </div>
                    </li>
                    <li class="imglist1">
                        <div class="roll_content">             	
                            <a href="javascript:;" class="roll_txtline">인기 맛집 베스트 Top3</a>                       
                        </div>
                    </li>            
                    <li class="imglist2">                      
                        <div class="roll_content">                                       	
                             <a href="javascript:;" class="roll_txtline">인기 맛집 베스트 Top3</a> 
                        </div>                                            
                    </li>                    
                </ul>
				<!-- 메인 이미지 롤링 버튼-->
                <div class="rollbtnArea">
                    <ul class="rollingbtn">
                        <li class="seq butt0"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/img/btn_rollbutt_on.png" alt="1번" /></a></li>
                        <li class="seq butt1"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/img/btn_rollbutt_off.png" alt="2번" /></a></li>
                        <li class="seq butt2"><a href="#butt"><img src="${pageContext.request.contextPath}/resources/img/btn_rollbutt_off.png" alt="3번" /></a></li>
                        <li class="rollstop"><a href="#" class="stop"><img src="${pageContext.request.contextPath}/resources/img/btn_roll_stop.png" alt="멈춤" /></a></li>
                        <li class="rollplay"><a href="#" class="play"><img src="${pageContext.request.contextPath}/resources/img/btn_roll_play.png" alt="재생" /></a></li>
                    </ul>
                </div><!-- //rollbtnArea -->

            </div><!-- //visualRoll -->
        </div><!-- //main_rolling_pc -->
        <!-- 메인 이미지 모바일 롤링 버튼-->
        <div class="main_rolling_mobile">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <a href="javascript:;"><img src="${pageContext.request.contextPath}/resources/img/mainslide01.jpg" alt="TRUST & INFORMATION 믿을 수 있는 여행정보, 여행... 어디로 가세요?" /></a>
                    </div>
                    <div class="swiper-slide">
                        <a href="javascript:;"><img src="${pageContext.request.contextPath}/resources/img/mainslide02.jpg" alt="TRUST & INFORMATION 믿을 수 있는 여행정보, 여행... 어디로 가세요?" /></a>
                    </div>
                    <div class="swiper-slide">
                        <a href="javascript:;"><img src="${pageContext.request.contextPath}/resources/img/mainslide03.jpg" alt="TRUST & INFORMATION 믿을 수 있는 여행정보, 여행... 어디로 가세요?" /></a>
                    </div>
                </div>						
                <div class="swiper-pagination"></div>
                <!-- <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div> -->         
            </div><!--//swiper-container-->
        </div><!--//main_rolling_mobile -->
        
      		<!-- location_area -->
		<!-- <h1 style="text-align:center; margin:2%; font-size:60px;"> 맛집게시판</h1> -->
		<form action="#" class="minisrch_form">
		<fieldset class="keywordnew">
			<select name="searchType">
				<option value="n" ${cri.searchType == null ? 'selected' : ''}>-------------------</option>
				<option value="t" ${cri.searchType == 't' ? 'selected' : ''}>TITLE</option>
				<option value="c" ${cri.searchType == 'c' ? 'selected' : ''}>CONTENT</option>
				<option value="w" ${cri.searchType == 'w' ? 'selected' : ''}>WRITER</option>
				<option value="tc" ${cri.searchType == 'tc' ? 'selected' : ''}>TITLE&CONTENT</option>
				<option value="cw" ${cri.searchType == 'cw' ? 'selected' : ''}>CONTENT&WRITER</option>
				<option value="tcw" ${cri.searchType == 'tcw' ? 'selected' : ''}>TITLE*CONTENT&WRITER</option>
			</select>
		<legend>검색</legend>
		<input type="text" name="keyword" id="keyword" class="tbox" value="${cri.keyword}" title="검색어를 입력해주세요" placeholder="검색어를 입력해주세요"/>
		<a href="javascript:;" onclick="searchBtn();"  class="btn_srch">검색</a>
		
		
		<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.member" var="member"/>
		<c:if test="${!empty member}">
		<a href="javascript:;" onclick="newBtn();" class="btn_regist">글작성</a>
		</c:if>
		</sec:authorize>
		</fieldset>
		
		</form>
		<br>
		<br>
		<br>
		<br><br><br><br><br><br><br><br><br>
		<!-- about_area -->	
		<div class="about_area">
			<div class="about_box">	
				<ul class="place_list box_inner clear">							
					<c:forEach var="imgBoardVO" items="${list}">
					 		<li>									 		
								<a href="/imgboard/imgViewPage?bno=${imgBoardVO.bno}">
										<%-- <img class="img_topplace" src="${pageContext.request.contextPath}/resources/img/img_topplace01.jpg"/> --%>
									<c:if test="${!empty imgBoardVO.profileFile}" >
									<img src="${imgBoardVO.profileFile}" class='img_topplace'/>
									</c:if>
									<c:if test="${empty imgBoardVO.profileFile}" >
									<img src="${pageContext.request.contextPath}/resources/img/goodchoice.png"" class='img_topplace'/>
									</c:if>
									<!-- <div id="profilePic" class='img_topplace'/></div> -->
										<h3>${imgBoardVO.title} [${imgBoardVO.commentCnt}]</h3>	
										<span class="view">
										<h5> No : ${imgBoardVO.bno} | writer : ${imgBoardVO.writer} | viewcnt : ${imgBoardVO.viewcnt}</h5>
										<f:formatDate pattern="yyyy-MM-dd HH:mm" value="${imgBoardVO.regdate}"/></span><br>
								</a>
								<br>
							<li>
					</c:forEach>									
				</ul>
			</div>
		</div>
		<!-- //about_area -->
		
		<!-- paging 블럭 -->	
		<div class="pagination">
			<c:if test="${pageMaker.prev}">
				<a href="/imgboard/imgBoardList${pageMaker.makeSearchQuery(1)}" class="firstpage  pbtn"><img src="${pageContext.request.contextPath}/resources/img/btn_firstpage.png"></a>
				<a href="/imgboard/imgBoardList${pageMaker.makeSearchQuery(pageMaker.startPage-1)}" class="prevpage  pbtn"><img src="${pageContext.request.contextPath}/resources/img/btn_prevpage.png" alt="이전 페이지로 이동"></a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<a href="/imgboard/imgBoardList${pageMaker.makeSearchQuery(i)}">
				<c:choose>
						<c:when test="${pageMaker.cri.page eq i}"> 
							<span class="pagenum currentpage">${i}</span>
						</c:when>
						<c:otherwise> 
							<span class="pagenum">${i}</span>
						</c:otherwise> 
				</c:choose>
			</a>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="/imgboard/imgBoardList${pageMaker.makeSearchQuery(pageMaker.endPage+1)}" class="nextpage  pbtn"><img src="${pageContext.request.contextPath}/resources/img/btn_nextpage.png" alt="다음 페이지로 이동"></a>
				<a href="/imgboard/imgBoardList${pageMaker.makeSearchQuery(pageMaker.maxPage)}" class="lastpage  pbtn"><img src="${pageContext.request.contextPath}/resources/img/btn_lastpage.png" alt="마지막 페이지로 이동"></a>
			</c:if>
			</div>	
	</div>
	<!-- //container -->
<script>
	function searchBtn(){
		var searchValue = $("select option:selected").val();
		var keywordValue = $("#keyword").val();
		console.log(searchValue +"  /  " + keywordValue);
		location.href="/imgboard/imgBoardList?searchType="+searchValue+"&keyword="+keywordValue;
	}
	
	function newBtn(){
		location.href="/imgboard/imgRegister";
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>