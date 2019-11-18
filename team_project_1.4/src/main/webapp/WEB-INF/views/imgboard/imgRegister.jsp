<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
<sec:authentication var="member" property="principal.member"/>
</sec:authorize>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/editor/js/service/HuskyEZCreator.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=19ad40b06eda0bd07e2114365d1c2f7e&libraries=services"></script>
<style>
	.fileDrop{
		width:50% auto;
		height:200px;
		border:1px solid lightgray;
		margin:auto;
	}
	
	span{
		font-size:1.5em;
	}
	
	span:hover{
		cursor:pointer;
	}
	.droptext{
		margin: 85px auto;
		text-align:center;
		color: gray;
	
	}
	.uploadList li{
		float:left;
		padding:20px;
	}
	
	ul li{
		list-style:none;
	}
	
	.clear{
		clear:both;
	}
	
	.mapstyle{
		
		border:2px solid black;
		text-align:center;
	}
	.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
	.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
	.map_wrap {position:relative;width:100%;height:500px;}
	#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:300px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
	.bg_white {background:#fff;}
	#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
	#menu_wrap .option{text-align: center;}
	#menu_wrap .option p {margin:10px 0;}  
	#menu_wrap .option button {margin-left:5px;}
	#placesList li {list-style: none;}
	#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
	#placesList .item span {display: block;margin-top:4px;}
	#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	#placesList .item .info{padding:10px 0 10px 55px;}
	#placesList .info .gray {color:#8a8a8a;}
	#placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
	#placesList .info .tel {color:#009900;}
	#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
	#placesList .item .marker_1 {background-position: 0 -10px;}
	#placesList .item .marker_2 {background-position: 0 -56px;}
	#placesList .item .marker_3 {background-position: 0 -102px}
	#placesList .item .marker_4 {background-position: 0 -148px;}
	#placesList .item .marker_5 {background-position: 0 -194px;}
	#placesList .item .marker_6 {background-position: 0 -240px;}
	#placesList .item .marker_7 {background-position: 0 -286px;}
	#placesList .item .marker_8 {background-position: 0 -332px;}
	#placesList .item .marker_9 {background-position: 0 -378px;}
	#placesList .item .marker_10 {background-position: 0 -423px;}
	#placesList .item .marker_11 {background-position: 0 -470px;}
	#placesList .item .marker_12 {background-position: 0 -516px;}
	#placesList .item .marker_13 {background-position: 0 -562px;}
	#placesList .item .marker_14 {background-position: 0 -608px;}
	#placesList .item .marker_15 {background-position: 0 -654px;}
	#pagination {margin:10px auto;text-align: center;}
	#pagination a {display:inline-block;margin-right:10px;}
	#pagination .on {font-weight: bold; cursor: default;color:#777;}

</style>

<div id="container">
		<!-- location_area -->
		<div class="location_area ticket">
			<div class="box_inner">
				<h2 class="tit_page"> 당신의 맛집을 <br> 모두와 공유하세요! </h2> 
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<!-- appForm -->
			
			<form method="post" id="registForm" action="/imgboard/imgRegister" class="appForm" enctype="multipart/form-data">
 			<input type="hidden" name="uno" value="${member.u_no}">		
	<%-- 	<input type="hidden" name="writer" value="${member.u_name}">  --%>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			

			<input type="hidden" name="profileFile" id="profile_pic" value="" >
				
					<!-- 맵 -->
					<div>	
						<div class="mapstyle">
							<div class="map_wrap">
						    <div id="map" style="width:100%;height:520px;position:relative;overflow:hidden;"></div>
						    <div id="menu_wrap" class="bg_white">
						        <div class="option">
						        <div>
						       	 <input type="text" name="mapQ" id="mapQ" placeholder="검색어를 입력해주세요" size="20"/>
						        <a href="javascript:;" onclick="searchMapBtn();" class="btn_srch">검색 </a>  	
						        </div>
						        </div>
						       <hr>
						        <ul id="placesList"></ul>
						        <div id="pagination"></div>
						    </div>
							</div>
						<br/>	
							<!-- 
							<input type="text" name="address" id="address" placeholder="검색어를 입력해주세요" />
							<a href="javascript:;" onclick="mapAddressChk();" class="btn_srch">주소 검색</a>
							-->
							<input type="text" name="locForm" value="" style="width:100%" />
							<br/>
						</div>	
					</div>

				<fieldset>
					<ul class="app_list">
						<li class="clear">
							<label for="pwd_lbl" class="tit_lbl pilsoo_item">글제목</label>
							<div class="app_content"><input type="text" class="w100p" name="title" id="title_lbl" /></div>
						</li>
						<li class="clear">
							<label for="name_lbl" class="tit_lbl pilsoo_item">작성자명</label>
							<div class="app_content"><input type="text" class="w100p" name="writer" id="name_lbl" value="${member.u_name}" readonly/></div>
						</li>
											
						<li class="clear">
							<label for="content_lbl" class="tit_lbl">내용</label>
							<div class="app_content"><textarea style="width:100%" name="content" id="content" class="w100p" placeholder="내용을 작성하세요."></textarea></div>
						</li>
					</ul>
					<br>
					<br>
					<div class="fileDrop"><p class="droptext"> 이미지를 끌어올리세요! </p></div>
					<table border="1">
					<tr>
						<th class="uploadList">						
						</th>
					</tr>
					</table>	
						<hr class="clear"/>
					<div>
					<br>
						<p class="btn_line"><a href="javascript:;" onclick="saveBtn();" class="btn_baseColor">확인</a></p>
					</div>	
				</fieldset>
			</form>
			<!-- //appForm -->
			
		</div>
		<!-- //bodytext_area -->

	</div>
	<!-- //container -->


<script>

/* 카카오 지도 api */

// 마커를 담을 배열입니다
var markers = [];
var mapContainer = document.getElementById("map");
var mapOption;

if (mapQ.value=="") {
	mapOption = {
    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
    level: 4 // 지도의 확대 레벨
		  };  
}

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var places = new kakao.maps.services.Places();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
infowindow; 

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

/* 	
	//  주소로 검색하기 
function mapAddressChk() {
	 var gap = $("#address").val(); // 주소검색어
	 if (gap == null || gap == "") {
	  alert("주소 검색어를 입력해 주십시오.");
	  address.focus();
	  return;
	 }
	 mapSerach(gap);
}

*/
	searchMapBtn();

	// 키워드로 검색하기
	function searchMapBtn(){
		
	var keywordValue = $("#mapQ").val();
	
	if (keywordValue == null || keywordValue == "" ) {
		mapQ.focus();

	 	return;
	 }
	
	/* var loc = "https://map.kakao.com/link/search/"+keywordValue; */
	 /*  변수를 input text에 표시 -  form_id.input_name.value */
	/* registForm.locForm.value = loc; */
	
	/* mapKeywordSerach(keywordValue); */
	  
	// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	places.keywordSearch(keywordValue, placesSearchCB); 

	/* 새 창에서 열기
	onclick="window.open('링크 주소')" */
	/* window.open('https://map.kakao.com/link/search/'+keywordValue); */
	/* 현재 창에서 열기 */
	/* location.href="https://map.kakao.com/link/search/"+keywordValue; */
	/* location.href="https://map.kakao.com/?q="+keywordValue; */
}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);

	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);

	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	    } else if (status === kakao.maps.services.Status.ERROR) {
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	    }
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {

	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);

	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	            
	            // 마커를 클릭했을 때 
	            kakao.maps.event.addListener(marker, 'click', function() {
	            	
	            	// var loc = "https://map.kakao.com/link/search/"+title;
	            	var loc = title;
	                registForm.locForm.value = loc;
	                
	            });

	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };

	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name);

	        fragment.appendChild(itemEl);
	        
	    }

	    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;

	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	    
	
	}

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';

	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item';

	    return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });

	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 

	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }

	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;

	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }

	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}	
	 
	// 네이버 텍스트 에디터 
	var path = "${pageContext.request.contextPath}/resources/editor/SmartEditor2Skin.html";
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame(
			oEditors,
			"content",
			path,
			"createSEditor2"
	);
	

	var header  = "${_csrf.headerName}";
	var token = "${_csrf.token}"; 
		
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;

	
		var maxSize = 10485760;
		
		
		var formData = new FormData();
		
		for(var i=0; i<files.length;i++){
			if(files[i].size > maxSize){
				alert("업로드 할 수 없는 파일이 포함되어 있습니다."+files[i].size);
				return;
			}
			console.log(files[i]);
			formData.append("file",files[i]);
		}
		console.log("ajax post");
		$.ajax({
			type : "POST",
			data : formData, 
			url : "/uploadFile",
			dataType : "json",
			processData : false,
			contentType : false,
		 	beforeSend : function(xhr){
				  xhr.setRequestHeader(header, token);
			},  
			success : function(data, jqXHR){
				console.log(data.length);
				
				var thumnailLoc = getFileInfo(data[0]); 
				for(var i = 0 ; i<data.length; i++){
					console.log(data[i]);
					var fileInfo = getFileInfo(data[i]);						
					console.log("fileInfo.fileName : " + fileInfo.fileName);
					console.log("fileInfo.imgSrc : "+ fileInfo.imgSrc);
					console.log("fileInfo.fullName : "+ fileInfo.fullName);
					console.log("fileInfo.getLink : "+ fileInfo.getLink);
					
					var html = "<li>";
					html += "<img src='"+fileInfo.imgSrc+"' alt='attachment'/>";
					html += "<div>";
					html += "<a href='"+fileInfo.getLink+"' target='_blank'>";
					html += fileInfo.fileName;
					html += "</a>";
					html += "</div>";
					html += "<div>";
					html += "<a href='"+fileInfo.fullName+"' class='delBtn'>X</a>";
					html += "</div>";
					html += "</li>";
					
				$(".uploadList").append(html);
				
				var picLoc = thumnailLoc.imgSrc;	
				console.log(thumnailLoc.imgSrc);
				registForm.profileFile.value = picLoc;	
						  
					
			  }
			}	
		});				
	});
		
	$(".uploadList").on("click",".delBtn",function(event){
		event.preventDefault();
		var target = $(this);
		
		$.ajax({
			type : "POST",
			url : "/deleteFile",		
			data : {fileName : target.attr("href")},
			beforeSend : function(xhr){
				  xhr.setRequestHeader(header, token);
			},
			dataType : "text",
			success : function(data){
				// 가장 근접한 1개의 부모 요소(li type)를 반환 
				alert(data);
				target.closest("li").remove();
			}
		});
		
	});
	
	function saveBtn(){
		var str = "";
		var fileList = $(".uploadList .delBtn");
		
		$(fileList).each(function(index){
			str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"'/>";
		});
		
		$("#registForm").append(str);
		
		oEditors[0].exec("UPDATE_CONTENTS_FIELD",[]);
		
		$("#registForm").submit();
	}

</script>
		
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>