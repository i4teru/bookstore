<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>책 목록 페이지</title>
<style type="text/css">
a {
	color: black;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}
</style>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
</head>
<body>
   
	<!-- 헤더 영역 -->
	<c:import url="./header.jsp"></c:import>

	<!-- 리스트 메인 -->
	<div class="container-fluid bg-lightgray pt-3 pb-3">
		<div class="container">

			<!-- 카테고리 구분 -->
			<div class="mainbox mt-1">
				<table class="noppading nomargin">
					<tr>
						<td><a href="#">모바일/임베디드</a></td>
						<td><a href="#">웹디자인</a></td>
						<td><a href="#">프로그래밍 언어</a></td>
						<td><a href="#">웹서비스 개발</a></td>
						<td><a href="#">데이터베이스</a></td>
					</tr>
				</table>
			</div>


			<div class="row">
				<!-- 프로그래밍 언어 관련 책 10권 -->
				<div class="col-12 h-100">
					<div class="mainbox-title mt-4">
						<i class="fa fa-book text-danger" aria-hidden="true"></i> 프로그래밍 언어
						<a href="#" float="right" >+더보기</a>
					</div>
					<div class="mainbox w-100 pb-3 pt-3">
						<div class="row">
							<c:forEach begin="1" end="5">
								<div class="col">
									<table class="main-best">
										<tr>
											<td style="text-align: center"><img src="./resources/images/bookimg1.jpg"></td>
										</tr>
										<tr>
											<td class="text-darkgray"><b>모두의 아두이노</b></td>
										</tr>
										<tr>
											<td class="text-brown2"><small>다카모토 다카요리 / 길벗</small></td>
										</tr>
										<tr>
											<td class="text-darkgray" style="text-align: right">14,400원</td>
										</tr>
									</table>

								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 여기서부터 Footer -->
	<div class="foot pt-5 mb-2">
		<div class="container">
			<div class="row">
				<div class="col-3 footimgwrap">
					<img src="./resources/images/logo.png">	
					<p></p>
				</div>
				<div class="col-6">
					<p class="foot-name">개발책방</p>
					<p>
						서울특별시 영등포구 선유동2로 70 이화빌딩 2층 (70213)<br>대표 : 김개발&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;사업자등록번호 : 123-45-67890
					</p>
				</div>
				<div class="col-3">
					<h3>02) 1234 - 4567</h3>
					<span><i class="far fa-envelope"></i> admin@dvbookstore.com</span>
				</div>
			</div>

			<p class="acenter mt-1 mb-3">Copyright ⓒ Developer's Bookstore All rights Reserved.</p>
		</div>
		<hr>
		<p class="acenter">
			<b>TIS정보기술교육센터</b> 김민지 김영기 김우람 김주리 최명지
		</p>
	</div>
</body>
</html>
