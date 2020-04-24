<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>책 목록 페이지</title>
<style type="text/css">
a {
	color: gray;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

.right {
	text-align: right;
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

			<!-- 카테고리 구분/검색 옵션 -->
			<div class="mt-1">
				<table class="w-100 noppading nomargin">
					<tr>
						<td>
						<button type="button" class="btn rounded btn-outline-primary" onclick="location.href='#section1'">모바일/임베디드</button>
						<button type="button" class="btn rounded btn-outline-secondary" onclick="location.href='#section2'">웹디자인</button>
						<button type="button" class="btn rounded btn-outline-success" onclick="location.href='#section3'">프로그래밍 언어</button>
						<button type="button" class="btn rounded btn-outline-info" onclick="location.href='#section4'">데이터베이스</button>
						<button type="button" class="btn rounded btn-outline-danger" onclick="location.href='#section5'">웹서비스 개발</button>
						</td>
					</tr>
					<tr>
						<td class="right"> 총 ${RBTotal} items&nbsp;&nbsp; </td> 
					</tr>
				</table>
			</div>


			<div class="row" id="section1">
				<!-- 모바일/임베디드 관련 책 5권 -->
				<div class="col-12 h-100">
					<div class="mainbox-title mt-4">
						<table class="w-100">
							<tr>
								<td><i class="fa fa-book text-primary" aria-hidden="true"></i> 모바일/임베디드 </td>
								<td class="right"><a href="#">+더보기</a></td>
							</tr>
						</table>
					</div>
					<div class="mainbox w-100 pb-3 pt-3">
						<div class="row">
							<c:forEach var="dto" items="${Sc1}">
								<div class="col">
									<table class="main-best m-3">
										<tr>
											<td style="text-align: center"><img src="${dto.bi_image}"></td>
										</tr>
										<tr>
											<td class="text-darkgray"><b>${dto.bi_title }</b></td>
										</tr>
										<tr>
											<td class="text-brown2"><small>${dto.bi_writer } / ${dto.bi_publisher }</small></td>
										</tr>
										<tr>
											<td class="text-darkgray" style="text-align: right">${dto.bi_sprice }원</td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			
						<div class="row" id="section2">
				<!-- 웹디자인 관련 책 5권 -->
				<div class="col-12 h-100">
					<div class="mainbox-title mt-4">
						<table class="w-100">
							<tr>
								<td><i class="fa fa-book text-secondary" aria-hidden="true"></i> 웹 디자인</td>
								<td class="right"><a href="#">+더보기</a></td>
							</tr>
						</table>
					</div>
					<div class="mainbox w-100 pb-3 pt-3">
						<div class="row">
							<c:forEach var="dto" items="${Sc2 }">
								<div class="col">
									<table class="main-best m-3">
										<tr>
											<td style="text-align: center"><img src="${dto.bi_image }"></td>
										</tr>
										<tr>
											<td class="text-darkgray"><b>${dto.bi_title }</b></td>
										</tr>
										<tr>
											<td class="text-brown2"><small>${dto.bi_writer } / ${dto.bi_publisher }</small></td>
										</tr>
										<tr>
											<td class="text-darkgray" style="text-align: right">${dto.bi_sprice }원</td>
										</tr>
									</table>

								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			
						<div class="row" id="section3">
				<!-- 프로그래밍 언어 관련 책 5권 -->
				<div class="col-12 h-100">
					<div class="mainbox-title mt-4">
						<table class="w-100">
							<tr>
								<td><i class="fa fa-book text-success" aria-hidden="true"></i> 프로그래밍 언어</td>
								<td class="right"><a href="#">+더보기</a></td>
							</tr>
						</table>
					</div>
					<div class="mainbox w-100 pb-3 pt-3">
						<div class="row">
							<c:forEach var="dto" items="${Sc3 }">
								<div class="col">
									<table class="main-best m-3">
										<tr>
											<td style="text-align: center"><img src="${dto.bi_image }"></td>
										</tr>
										<tr>
											<td class="text-darkgray"><b>${dto.bi_title }</b></td>
										</tr>
										<tr>
											<td class="text-brown2"><small>${dto.bi_writer } / ${dto.bi_publisher }</small></td>
										</tr>
										<tr>
											<td class="text-darkgray" style="text-align: right">${dto.bi_sprice }원</td>
										</tr>
									</table>

								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			
						<div class="row" id="section4">
				<!-- 데이터베이스 관련 책 10권 -->
				<div class="col-12 h-100">
					<div class="mainbox-title mt-4">
						<table class="w-100">
							<tr>
								<td><i class="fa fa-book text-info" aria-hidden="true"></i> 데이터베이스</td>
								<td class="right"><a href="#">+더보기</a></td>
							</tr>
						</table>
					</div>
					<div class="mainbox w-100 pb-3 pt-3">
						<div class="row">
							<c:forEach var="dto" items="${Sc4 }">
								<div class="col">
									<table class="main-best m-3">
										<tr>
											<td style="text-align: center"><img src="${dto.bi_image }"></td>
										</tr>
										<tr>
											<td class="text-darkgray"><b>${dto.bi_title }</b></td>
										</tr>
										<tr>
											<td class="text-brown2"><small>${dto.bi_writer } / ${dto.bi_publisher }</small></td>
										</tr>
										<tr>
											<td class="text-darkgray" style="text-align: right">${dto.bi_sprice }원</td>
										</tr>
									</table>

								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			
						<div class="row" id="section5">
				<!-- 웹서비스 개발 관련 책 10권 -->
				<div class="col-12 h-100">
					<div class="mainbox-title mt-4">
						<table class="w-100">
							<tr>
								<td><i class="fa fa-book text-danger" aria-hidden="true"></i> 웹서비스 개발</td>
								<td class="right"><a href="#">+더보기</a></td>
							</tr>
						</table>
					</div>
					<div class="mainbox w-100 pb-3 pt-3">
						<div class="row">
							<c:forEach var="dto" items="${Sc5 }">
								<div class="col">
									<table class="main-best  m-3">
										<tr>
											<td style="text-align: center"><img src="${dto.bi_image }"></td>
										</tr>
										<tr>
											<td class="text-darkgray"><b>${dto.bi_title }</b></td>
										</tr>
										<tr>
											<td class="text-brown2"><small>${dto.bi_writer } / ${dto.bi_publisher }</small></td>
										</tr>
										<tr>
											<td class="text-darkgray" style="text-align: right">${dto.bi_sprice }원</td>
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
	
	<!-- 여기서부터 footer -->
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
