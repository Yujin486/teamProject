<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<sec:authorize access="isAuthenticated()">
<sec:authentication var="member" property="principal.member"/>
</sec:authorize>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=19ad40b06eda0bd07e2114365d1c2f7e&libraries=services"></script>
<!-- 스크립트 -->

<style>
	.buttons{
		float:right;
		padding:5px;
	}
	
	.uploadedList{
		width:100%;
	}
	
	.uploadedList li{
		float:left;
		padding:30px;
	}
	
	#pagination li{
	 float:left;
	 padding:5px;
	}
	
	.mapstyle{
		
		border:2px solid black;
		text-align:center;
	}
	
  table {
  	background-color: #EFF8FB;
    width: 100%;
   
  }

</style>

	<div id="container">
		<!-- location_area -->
		<div class="location_area package">
			<div class="box_inner">
				<h2 class="tit_page">TOURIST <span class="in">in</span> TOUR</h2>
				<p class="location">맛집게시판 <span class="path">/</span> 베스트게시물 </p>
				<ul class="page_menu clear">
					<li><a href="#" class="on">맛집게시판!</a></li>
					<li><a href="#">게시글 등록하기</a></li>
				</ul>
			</div>
		</div>	
		<!-- //location_area -->
		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">			
			<ul class="bbsview_list">
				<li class="bbs_title">${imgBoardVO.title}</li>
				<li class="img_writer">작성자 : <span>${imgBoardVO.writer}</span></li>
				<li class="img_hit">작성일 : <span><f:formatDate pattern="yyyy-MM-dd HH:mm" value="${imgBoardVO.regdate}"/></span></li>
				<li class="img_date">조회수 : <span>${imgBoardVO.viewcnt}</span></li>
				<li class="bbs_content">
					<div class="editer_content">
					<div class="mapstyle">
					<h2 class="tit_page">${imgBoardVO.writer}<span class="in">님이</span> 추천하는 맛집의 위치는 어디?</h2>
					<input type="text" name="locForm" id="locForm" value="${imgBoardVO.locForm}" style="width:100%;" readonly />
					<a href="https://map.kakao.com/link/search/${imgBoardVO.locForm}" target="_blank" ><input type="button" class="btn_bbs" name="LocGo" id="locGo" value="링크 이동" style="width:100%;"/></a> 
					<!-- "https://map.kakao.com/link/search/"+title; -->
					<div id="map" style="width:100%;height:300px;position:relative;overflow:hidden;"></div>					
					</div>
						${imgBoardVO.content}
						<!-- // 첨부파일 목록 -->			
					</div>	                               
				</li>
					<br>
						<li class="uploadedList">
						</li>
					<br>
			</ul>

			<!-- 폼 전달 -->
			<form id="readForm" method="post">				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="bno" id="imgBoardBno" value="${imgBoardVO.bno}"/>	
				<input type="hidden" name="page" value="${cri.page}"/>
				<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
				<input type="hidden" name="searchType" value="${cri.searchType}"/>
				<input type="hidden" name="keyword" value="${cri.keyword}"/>
			</form>
			<hr/>								
			<!-- 댓글 목록 -->
				<div>
					<ul id="comments">		
					</ul>
				</div>					
			
			<!-- 댓글 페이징 처리 -->
				<div style="height:100px;">
					<ul id="pagination"></ul>
					<br>
				</div>
		
			<div>		
			<!-- 코멘트 작성란 -->
			<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.member" var="member"/>
						<input type="text" id="newCommentAuth" value="${member.u_name}" />
						<input type="text" id="newCommentText" style="width:60%"/>		
						<a href="javascript:;" onclick="commentAddBtn();" class="btn_bbs" style="margin:10px" >등록</a> 				
			</sec:authorize>
						
			<!-- 댓글 수정 삭제 -->
			<div id="modDiv" style="display:none;">	
			<sec:authorize access="isAuthenticated()">			
				<h3>댓글 수정&삭제</h3>
				<br>
				<div class="mod-title"></div>
				<div>
						<input type="text" id="commentText" style="width:60%"/>														
						<c:if test="${!empty member.u_no}">
						<input type="button" id="commentModBtn" value="MODIFY" />
						<input type="button" id="commentDelBtn" value="DELETE" />
						<input type="button" id="closeBtn" value="CLOSE"/>
					 	</c:if>		 		
				</div>
				</sec:authorize>	
			</div> 	

			</div>
						
			<!-- 게시글 수정  버튼 | 삭제 버튼 | 답글 버튼 | 게시물 목록 버튼 -->
			<div class="bbsview_list">
				<div class="buttons">
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.member" var="member"/>
						<c:if test="${!empty member}">
						<c:if test="${member.u_no  eq imgBoardVO.uno}">
							<a href="javascript:;" onclick="modifyBtn();" class="btn_modify">MODIFY </a>
							<a href="javascript:;" onclick="deleteBtn();" class="btn_delete">DELETE</a>
							</c:if>												
						</c:if>
						</sec:authorize>
							<sec:authorize access="isAnonymous()">
						<a href="javascript:;" onclick="listBtn();" class="btn_bbs">LIST</a>
						</sec:authorize>
				</div>							
			</div>	
			
			<ul class="near_list mt20">
				<c:if test="${!empty nextBoard}">
					<li><h4 class="prev">다음글</h4><a id="nextBoard" href="#">${nextBoard.title}</a></li>
				</c:if>	
				<c:if test="${!empty prevBoard}">	
					<li><h4 class="next">이전글</h4><a id="prevBoard" href="#">${prevBoard.title}</a></li>
				</c:if>
				
			</ul> 
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->

<script>
		var header  = "${_csrf.headerName}";
		var token = "${_csrf.token}"; 

		var keywordValue = $("#locForm").val();
		
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 

		// 키워드로 장소를 검색합니다
		ps.keywordSearch(keywordValue, placesSearchCB); 

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}

		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });

		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
		
	var bno = '${imgBoardVO.bno}';
	var commentPage = 1;
	
	getPageList(commentPage);
	
	// text에서 스크립트 썼을 경우, html 태그 인식못하게 문자열 변경하기
	String.prototype.replaceAll = function(old, dest){
		// &lt; a href="/sboard/delete?bno=1"&gt;바보야!!&lt;/a&gt;
		return this.split(old).join(dest);
	}
	// < &lt;   > &gt;
	function changeEscape(text){
		var result = "";
		result = text.replaceAll("<", "&lt;");
		result = result.replaceAll(">", "&gt;");
		result = result.replaceAll("\"", "'");
		return result;
	}
	
 	// 작성자 확인
	function isCheckAuth(uno){
		var userUno = "${member.u_no}";
		console.log(userUno+"//"+uno);
		if(userUno != "" && userUno == uno){
			return true;
		}else{
			return false;
		}
	}
	
	// 날짜 형태로 바꾸기
	function getDate(timeValue){
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth()+1;
		var date = dateObj.getDate();
		var hour = dateObj.getHours();
		var minute = dateObj.getMinutes();
		var seconds = dateObj.getSeconds();
		return year + "/"+month+"/"+date+" "+hour+":"+minute+":"+seconds;
	}
	
	function getPage(page){
		// 해당 게시물의 페이징 처리된 댓글 목록 
		// 페이징 블럭 정보
		$.getJSON("/comments/"+bno+"/"+page,function(data){
			// data ==  Map<String,Object>
			// data.list : List<CommentVO>
			// data.pageMaker : PageMaker
			console.log(data);
			// list 작성
			console.log(data.list);
			// 블럭처리 
			console.log(data.pageMaker);
			
			var str = "";
			
			$(data.list).each(function(){
				// this == CommentVO
				console.log(this.commentText);
				var text = changeEscape(this.commentText);
				console.log(text);
				
				str += '<li data-cno="'+this.cno+'" ';
				str += 'data-text="'+text+'" class="commentLi">';
				str += '<table><td>'
					+this.commentAuth +' || '+getDate(this.updatedate)+'<br><br>'+ text+'</td></table>';
				if(isCheckAuth(this.uno)){
					str += ' - <button>MODIFY</button>';
				}
				str += '</li><li style="color:#BDBDBD;">------------------------------------------------------------------------------------------------------------------------------------------------------------------------</li> ';
			});
			
			
			$("#comments").append(str);
			$("#comments li").append("slow");
		});
	}
	
	// 댓글 옆 수정 버튼 클릭했을 때
	$("#comments").on("click", ".commentLi button", function(){
		// .commentLi
		var commentWrap = $(this).parent();
		var cno = commentWrap.attr("data-cno");		
		var text = commentWrap.attr("data-text");
		$(".mod-title").html(cno);
		$("#commentText").val(text);
		$("#modDiv").toggle("slow"); // toggle(); 닫혀 있음 열리고, 열려 있음 닫히는 버튼.
		$("#commentText").focus();
	});

	// 댓글 수정&삭제 닫기
	$("#closeBtn").click(function(){
		$("#modDiv").toggle("slow");
	});
	
	// 댓글 수정
	$("#commentModBtn").click(function(){
		var cno = $(".mod-title").html();
		var text = $("#commentText").val();
		var uno = "${member.u_no}";

		console.log(cno +"  /  " + uno +"  /  "+Text);
		
		$.ajax({
			type : "patch",
			url : "/comments/"+cno+"/"+uno,
			beforeSend : function(xhr){
				  xhr.setRequestHeader(header, token);
			},  
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PATCH"				
			},
			data : JSON.stringify({
				commentText : text
			}),
			dataType : "text",
			success : function(data){				
				if(data == "SUCCESS"){
					alert("수정이 완료되었습니다.");
					$("#modDiv").hide("slow");
					getPageList(commentPage);
				}
			},
			error : function(res, error){
				alert(error);
			}
		});
	});
	
	// 댓글 삭제
	$("#commentDelBtn").click(function(){
		var cno =$(".mod-title").html();		
		$.ajax({
			type : "delete",
			url : "/comments/"+cno,
			beforeSend : function(xhr){
				  xhr.setRequestHeader(header, token);
			},  
			headers : {
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : "text",
			success :  function(data){
				if(data == "SUCCESS"){
					alert("삭제가 완료되었습니다.");
					$("#modDiv").hide("slow");
					getPageList(commentPage);
				}	
			}		
		});
	});
	
	// 페이징 처리된 댓글 목록
	function getPageList(page){
		
		commentPage = page;
		console.log(commentPage);
		
		// 해당 게시물의 페이징 처리된 댓글 목록 
		// 페이징 블럭 정보
		$.getJSON("/comments/"+bno+"/"+page,function(data){
			
			console.log(data);
			// list 작성
			console.log(data.list);
			// 블럭처리 
			console.log(data.pageMaker);
			
			var str = "";
			
			$(data.list).each(function(){
				// this == CommentVO
				console.log(this.commentText);
				var text = changeEscape(this.commentText);
				console.log(text);
				
				str += '<li data-cno="'+this.cno+'" ';
				str += 'data-text="'+text+'" class="commentLi">';
				str += '<table><td>'
					+this.commentAuth +' || '+getDate(this.updatedate)+'<br><br>'+ text+'</td></table>';
				if(isCheckAuth(this.uno)){
					str += '- <button>MODIFY</button>';
				}
				str += '</li><li style="color:#BDBDBD;">------------------------------------------------------------------------------------------------------------------------------------------------------------------------</li> ';
			});
			
			$("#comments").html(str);
			printPage(data.pageMaker);
		});
	}
	
	function printPage(pageMaker){
		console.log(pageMaker);
		var str ="";
		
		if(pageMaker.prev){
			str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
		}
		
		for(var i=pageMaker.startPage; i <= pageMaker.endPage; i++){
			str += "<li><a href='"+i+"'> "+i+" </a></li>";
		}
		
		if(pageMaker.next){
			str += "<li><a href='"+(pageMaker.endPage+1)+"'> >> </a></li>";
		}
		console.log(str);
		$("#pagination").html(str);
	}
	
	$("#pagination").on("click","li a",function(event){
		event.preventDefault();
		var page = $(this).attr("href");
		getPageList(page);
	});
	
	// 댓글 등록
	// bno auth text uno
	function commentAddBtn(){
		
		var commentText = $("#newCommentText").val();
		var commentAuth = $("#newCommentAuth").val();
		$.ajax({
			type : "post",
			url : "/comments/add",
			beforeSend : function(xhr){
				  xhr.setRequestHeader(header, token);
			},  
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : "text",
			data : JSON.stringify({
				bno : bno,
				commentAuth : commentAuth,
				commentText : commentText,
				uno : "${member.u_no}"
				
			}),
			success : function(data){
				alert(data);
				getPageList(1);
				$("#newCommentText").val("");
				$("#newCommentText").focus();
			}, 
			error : function(res, error){
				alert(error);
			}
		});
	}

	/* 파일  */
$.getJSON("/imgboard/getAttach/"+bno, function(data){
	console.log(data);
	$(data).each(function(){
		
		var fileInfo = getFileInfo(this);
		
		console.log(fileInfo);
		var html = "<br><data-src='"+fileInfo.fullName+"'>";
			html += "<span>";
			html += "<img src='"+fileInfo.imgSrc+"' alt='attachment'/>";
			html += "</span>";
			html += "<div>";
			html += "<a href='"+fileInfo.getLink+"'  target='_blank'>";
			html += fileInfo.fileName;
			html += "</a>";
			html += "</div><br>";
		$(".uploadedList").append(html);
	});
});
		
	var obj = $("#readForm");
			
	$("#nextBoard").click(function(event){
		event.preventDefault();
		$("#imgBoardBno").val("${nextBoard.bno}");
		obj.attr("method", "get");
		obj.submit();
	});
	
	$("#prevBoard").click(function(event){
		event.preventDefault();
		$("#imgBoardBno").val("${prevBoard.bno}");
		obj.attr("method", "get");
		obj.submit();
	});
	
	function replyBtn(){
		obj.attr("action", "/imgboard/imgRegister");
		obj.attr("method", "get");
		obj.submit();
	}
	
	function listBtn(){
		obj.attr("action", "/imgboard/imgBoardList");
		obj.attr("method", "get");
		obj.submit();
	}
	
	function modifyBtn(){
		obj.attr("action", "/imgboard/imgModifyPage");
		obj.attr("method", "get");
		obj.submit();
	}
	
	function deleteBtn(){
		var isDelete = confirm("첨부된 내용과 댓글이 모두 삭제됩니다. 삭제하시겠습니까?");
		if(isDelete){
			console.log("삭제 요청");
			// 삭제 처리
			var arr = []; // 배열로 처리
			$(".uploadedList li").each(function(index){
				arr.push($(this).attr("data-src"));
			});
			
			console.log(arr.length);
			console.log(arr);
			//삭제할 게 존재한다면
			if(arr.length > 0){
				$.post("/deleteAllFiles",{files : arr},function(result){
					alert(result);
				});
			}
			
			obj.attr("action", "/imgboard/remove");
			obj.submit();
		}else{
			alert("삭제 요청이 취소되었습니다.");
		}
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

	