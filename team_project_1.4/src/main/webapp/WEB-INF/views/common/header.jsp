<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="member" property="principal.member"/>
</sec:authorize>
<!DOCTYPE html>
<html lang="ko">
<head>
<title> 부산 맛집 </title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="${path}/resources/css/common.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${path}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${path}/resources/js/common.js"></script>  
<script src="${path}/resources/js/jquery.smooth-scroll.min.js"></script> 
<!--[if lte IE 9]>
    <script src="js/html5shiv.js"></script>
	<script src="js/placeholders.min.js"></script>
<![endif]-->
</head>

<body>
<ul class="skipnavi">
    <li><a href="#container">본문내용</a></li>
</ul>
<!-- wrap -->
<div id="wrap">

	<header id="header">
		<div class="header_area box_inner clear">	
			<h1><a href="/imgboard/imgBoardList">부산 맛집</a></h1>
			<p class="openMOgnb"><a href="#"><b class="hdd">메뉴열기</b> <span></span><span></span><span></span></a></p>
			<!-- header_cont -->
			<div class="header_cont">
				<ul class="util clear">
					<c:if test="${sessionId != null}">
						<li><a href="#">${sessionId}</a>님</li>
						<li><a href="/user/logout">LOGOUT</a></li>
					</c:if>
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.member" var="member"/>
						<li><a href="/user/myPage">${member.u_name}</a>님</li>
						<li><a href="/user/logout">LOGOUT</a></li>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<li><a href="${path}/user/login">로그인</a></li>
						<li><a href="${path}/user/join">회원가입</a></li>
					</sec:authorize>
				</ul>		
				<nav>
				<ul class="gnb clear">
					<li><a href="/imgboard/imgBoardList" class="openAll1">메인</a>
					</li>
					<li><a href="#" class="openAll2">고객센터</a>
						<div class="gnb_depth gnb_depth2_2">
                            <ul class="submenu_list">
                                <li><a href="/reboard/listReply">공지사항</a></li>
                                <li><a href="/qnaboard/listReply">문의하기</a></li>
                            </ul>
                        </div>
					</li>
					<c:if test="${member != null}">
						<li><a href="/mngt/boardList" class="openAll3">게시물 관리</a></li>
					</c:if>
					<sec:authorize access="hasRole('ROLE_MASTER')">
						<li><a href="/mngt/memberList" class="openAll4">회원 관리</a></li>
					</sec:authorize> 
				</ul>
                </nav>
				<p class="closePop"><a href="javascript:;">닫기</a></p>
			</div>
			<!-- //header_cont -->
		</div>
	</header>