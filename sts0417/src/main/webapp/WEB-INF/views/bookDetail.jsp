<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>개발서점</title>

<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
</head>
<body>
   
	<!-- 헤더 분리 -->
	<c:import url="./header.jsp"></c:import>

	<!-- 메인화면 -->
	<div class="container-fluid bg-lightgray pt-3 pb-3">
		<div class="container">
			<!-- 이벤트 이미지 -->

			<div class="mainbox mt-1">
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



			<div class="row">
				<!-- 베스트셀러 -->
				<div class="col-8 h-100">
					<div class="mainbox-title mt-4">
						<i class="fas fa-crown text-bsyellow"></i> 이번 주 BEST
					</div>
					<div class="mainbox pb-3 pt-3" id="mainbox-best">
						<div class="row">
							<c:forEach begin="1" end="3">
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
				<!-- 신규 서적 -->
				<div class="col-4 h-100">
					<div class="mainbox-title mt-4">
						<span class="badge bg-bsyellow text-light">NEW</span> 신규 입고
					</div>
					<div class="mainbox main-new">
						<c:forEach begin="1" end="4">
						<table class="mt-2 mb-1 mauto">
							<tr>
								<td><img src="./resources/images/bookimg1.jpg"></td>
								<td class="text-darkgray"><b>모두의 아두이노</b><br><small class="text-brown2">다카모토 다카요리 / 길벗</small></td>
							</tr>
						</table>
						</c:forEach>
					</div>
				</div>


			</div>

			<!-- 공지사항, 최근리뷰, 메뉴 -->

			<div class="row">
				<!-- 최근 공지사항 -->
				<div class="col h-100">
					<div class="mainbox-title mt-4">공지사항</div>
					<ul class="main-notice">
						<c:forEach begin="1" end="7" var="i">
							<li><span class="text-brown2">[2020-04-21] </span><span class="text-darkgray">신규 오픈 공지사항 ${ i }번째 이래도 공지가 짧다고 생각해?</span></li>
						</c:forEach>

					</ul>
				</div>
				<!-- 최근 리뷰 -->

				<div class="col h-100">
					<div class="mainbox-title mt-4">최신 리뷰</div>
					<!-- 리뷰 2건 출력 -->
					<c:forEach begin="1" end="2" var="i">
						<table class="table-sm table-borderless mb-2 main-review">
							<tr>
								<td rowspan="3" class="pl-2"><img src="./resources/images/bookimg1.jpg" class="main-review-img"></td>
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
	<c:import url="bookreply.do"></c:import>
	<!-- footer 분리 -->
	<c:import url="footer.jsp"></c:import>
	</body>
</html>