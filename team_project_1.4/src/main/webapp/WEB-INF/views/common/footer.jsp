<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer>
		<div class="foot_area box_inner">
			<ul class="foot_list clear">
				<li><a href="#">이용약관</a></li>
				<li><a href="#">개인정보취급방침</a></li>
			</ul>
			<h2>부산 맛집</h2>
			<p class="addr">부산광역시 동래구 충렬대로 84 영남빌딩 5층 <span class="gubun">/</span>        
				<span class="br_line">대표전화 <span class="space0">02-1234-5678</span> <span class="gubun">/</span>        
					<span class="br_line">E-mail : <span class="space0">busan@busanfood.com</span></span>
				</span>
			</p>
			<p class="copy box_inner">Copyright(c) TouristInTour all right reserved</p>
	<!-- 		<ul class="snslink clear">
				<li><a href="javascript:;">blog</a></li>
				<li><a href="javascript:;">facebook</a></li>
				<li><a href="javascript:;">instargram</a></li>
			</ul> -->
		</div>
	</footer>

</div>
<!-- //wrap -->

<h2 class="hdd">빠른 링크 : 전화 문의, 카카오톡, 오시는 길, 꼭대기로</h2>
<div class="quick_area">
	<ul class="quick_list">
		<li><a href="javascript:;" id="chat"><h3>채팅방</h3><p></p></a></li>
	</ul>
	<p class="to_top"><a href="#layout0" class="s_point">TOP</a></p>
</div>
<script>
	/* window.open(URL, name, option); */
	
	$("#chat").click(function(){
		console.log('click');
		popupOpen();
	});
	
	function popupOpen(){
		var url = "/popup";
		var option = "width=380, height=560, resizable=no, status = no";
		window.open(url, "", option);
	};
</script>
</body>
</html>