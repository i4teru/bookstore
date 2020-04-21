<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>개발서점</title>
<link rel="stylesheet" href="./resources/css/bookstore.css">
</head>
<body>

	<!-- 헤더 분리 -->
	<c:import url="./header.jsp"></c:import>

	<!-- 메인화면 -->
	<div class="container-fluid bg-lightgray pt-3">

		<!-- 이벤트 이미지 -->
		<div class="container">
			<div class="mainbox">
				<table class="eventimage noppading nomargin">
					<tr>
						<td class="bg-brown1">
							<ul>
								<li>신규 오픈 이벤트</li>
							</ul>
						</td>
						<td style="width: 880px"><img src="./resources/images/event1.png"></td>
					</tr>
				</table>

			</div>
		</div>

		<div class="container pt-3">
			<div class="row">
				<!-- 베스트셀러 -->
				<div class="col-8 h-100">
					<div class="mainbox-title">
						<i class="fas fa-crown text-bsyellow"></i> 이번 주 BEST
					</div>
					<div class="mainbox">
						<div class="row">
							<c:forEach begin="1" end="3">
								<div class="col">
									<table class="main-best">
										<tr>
											<td><img src="./resources/images/bookimg1.jpg"></td>
										</tr>
										<tr>
											<td></td>
										</tr>
										<tr>
											<td></td>
										</tr>
										<tr>
											<td></td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 신규 서적 -->
				<div class="col-4 h-100">
					<div class="mainbox-title">
						<span class="badge bg-bsyellow text-light">NEW</span> 신규 입고
					</div>
					<div class="mainbox">신규 서적</div>
				</div>

			</div>
		</div>

		<!-- 공지사항, 최근리뷰, 메뉴 -->
		<div class="container pt-3  pb-3">
			<div class="row">
				<!-- 최근 공지사항 -->
				<div class="col h-100">
					<div class="mainbox-title">공지사항</div>
					<ul class="main-notice">
						<c:forEach begin="1" end="7" var="i">
							<li><span class="text-brown2">[2020-04-21] </span><span class="text-darkgray">신규 오픈 공지사항 ${ i }번째</span></li>
						</c:forEach>

					</ul>
				</div>
				<!-- 최근 리뷰 -->

				<div class="col h-100">
					<div class="mainbox-title">최신 리뷰</div>
					<!-- 리뷰 2건 출력 -->
					<c:forEach begin="1" end="2" var="i">
						<table class="table-sm table-borderless mb-2 main-review">
							<tr>
								<td rowspan="3"><img src="./resources/images/bookimg1.jpg" class="main-review-img"></td>
								<td><span class="text-darkgray"><b>모두의 아두이노</b></span><span class="text-brown2"><br> <small>다카모토 다카요리 / 길벗</small></span></td>
							</tr>
							<!-- 별점 -->
							<tr>
								<td><span class="text-bsyellow"> <c:forEach begin="1" end="3">
											<i class="fas fa-star"></i>
										</c:forEach> <c:forEach begin="4" end="5">
											<i class="far fa-star"></i>
										</c:forEach>
								</span></td>
							</tr>
							<tr>
								<td>
									<p class="text-darkgray">
										<small>하루종일 저항색만 찾고 있어요. 책이 너무 구리고 정신에 해롭네요.</small>
									</p>
								</td>
							</tr>
						</table>
					</c:forEach>
				</div>
			</div>
		</div>

	</div>

	<!-- 푸터 분리 -->
	<footer> </footer>
</body>
</html>
