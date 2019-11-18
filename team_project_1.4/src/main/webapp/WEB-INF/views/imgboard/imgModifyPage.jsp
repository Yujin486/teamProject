<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>

<div id="container">
		<!-- location_area -->
		<div class="location_area member">
			<div class="box_inner">
				<h2 class="tit_page"> 당신의 맛집을 <br> 모두와 공유하세요! </h2> 
			</div>
		</div>	
		<!-- //location_area -->

		<!-- bodytext_area -->
		<div class="bodytext_area box_inner">
			<!-- appForm -->
			<form method="post" id="modifyForm" name="modifyForm" action="/imgboard/imgModifyPage" class="appForm">				
				<input type="hidden" name="bno" value="${imgBoardVO.bno}"/>								
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="profileFile" id="profile_pic" value="" >
					<!-- 맵 -->
					<div>	
						<div class="mapstyle">									
							<input type="text" name="locForm" id="locForm" value="${imgBoardVO.locForm}" style="width:100%;" />				   
						    <div id="map" style="width:100%;height:520px;position:relative;overflow:hidden;"></div>						    
						        <div>								   
						        </div>
						        </div>
						       <hr>
						        <ul id="placesList"></ul>
						        <div id="pagination"></div>
							</div>	
			 
				<fieldset>
					<ul class="app_list">
						<li class="clear">
							<label for="pwd_lbl" class="tit_lbl pilsoo_item">글제목</label>
							<div class="app_content"><input type="text" class="w100p" name="title" id="title_lbl" value="${imgBoardVO.title}" required/></div>
						</li>
						<li class="clear">
							<label for="name_lbl" class="tit_lbl pilsoo_item">작성자명</label>
							<div class="app_content"><input type="text" class="w100p" name="writer" id="name_lbl" value="${imgBoardVO.writer}" readonly required/></div>
						</li>
					
						<li class="clear">
							<label for="content_lbl" class="tit_lbl">내용</label>
							<div class="app_content"><textarea style="width:100%" name="content" id="content" class="w100p" rows=3>${imgBoardVO.content}</textarea></div>
						</li>
					<!-- //container -->	

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
						<br>
					<div>
						<p class="btn_line"><input type="button" id="saveBtn" class="btn_modify" value="확인"/>
						<input type="button" id="cancelBtn" class="btn_delete" value="취소"/></p>
					</div>	
					<hr class="clear"/>
			<div>
			</div>
			</fieldset>
				
			</form>
			<!-- //appForm -->
			
		</div>
		<!-- //bodytext_area -->

	</div>

<script>
		var keywordValue = $("#locForm").val();
		var bno = ${imgBoardVO.bno};
		
		var header  = "${_csrf.headerName}";
		var token = "${_csrf.token}"; 

		
 		//네이버 텍스트 에디터 
		var path = "${pageContext.request.contextPath}/resources/editor/SmartEditor2Skin.html";
		
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame(
				oEditors,
				"content",
				path,
				"createSEditor2"
		);
		
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

		// 첨부파일 목록
		$.getJSON("/imgboard/getAttach/"+bno, function(list){
			
			$(list).each(function(){
				// this == fullName						
				var fileInfo = getFileInfo(this);
				var html = "<li>";
					html += "<img src='"+fileInfo.imgSrc+"' alt='첨부파일'/>";
					html += "<div>";
					html += "<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a>";
					html += "</div>";
					html += "<div>";
					html += "<a href='"+fileInfo.fullName+"' class='delBtn'>X</a>";
					html += "</div>";
					html += "</li>";
				$(".uploadList").append(html);	
			});
		});
			
		// 첨부파일 삭제
		$(".uploadList").on("click",".delBtn", function(event){
			event.preventDefault();
			var fileLink = $(this).attr("href");
			
			$.ajax({
				type : "delete",
				url : "/deleteFile",
				beforeSend : function(xhr){
					  xhr.setRequestHeader(header, token);
				},
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				data : JSON.stringify({
					fileName : fileLink,
				}),
				dataType : "text",
				success : function(result){
					alert(result);
					$(this).closest("li").remove();
				}
			});
			
			
		});
			
		/* 
		첨부 파일 업로드 & 삭제
	 	*/
	
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
		
			$.ajax({
				type : "POST",
				data : formData,
				url : "/uploadFile",
				beforeSend : function(xhr){
					  xhr.setRequestHeader(header, token);
				},
				dataType : "json",
				processData : false,
				contentType : false,
				success : function(data){
					console.log(data.length);
					for(var i = 0 ; i<data.length; i++){
						console.log(data[i]);
						var thumnailLoc = getFileInfo(data[0]);
						var fileInfo = getFileInfo(data[i]);
						console.log(fileInfo.fileName);
						console.log(fileInfo.imgSrc);
						console.log(fileInfo.fullName);
						console.log(fileInfo.getLink);
						
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

						var picLoc = thumnailLoc.imgSrc;	
						console.log(thumnailLoc.imgSrc);
						modifyForm.profileFile.value = picLoc;	
						
					$(".uploadList").append(html);
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
				beforeSend : function(xhr){
					  xhr.setRequestHeader(header, token);
				},
				data : { fileName : target.attr("href")},
				dataType : "text",
				success : function(data){
					// 가장 근접한 1개의 부모 요소(li type)를 반환 
					alert(data);
					target.closest("li").remove();
				}
			});
			
		});
	
		$("#saveBtn").click(function(){
			
			var str = "";
			var fileList = $(".uploadList .delBtn");
			
			$(fileList).each(function(index){
				str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"'/>";
			});
			
			$("#modifyForm").append(str);
			
			oEditors[0].exec("UPDATE_CONTENTS_FIELD",[]);
			
			$("#modifyForm").submit();
		});
		
		$("#cancelBtn").click(function(){
			$("#modifyForm").attr("action", "/imgboard/imgView");
			$("#modifyForm").attr("method", "get");
			$("#modifyForm").submit();
		});

</script>
</body>
</html>
		
		
		
