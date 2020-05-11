<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="false"%>
<html>
<head>
<title>개발책방</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

<script>
	var eventcount = ${	mainEventCount};
	var currentevent = 1;

	$(function() {

		function changeEvent() {
			currentevent += 1;
			if (currentevent > eventcount)
				currentevent = 1;
			$(".e-li").removeClass("event-active");
			$("#e-li-" + currentevent).addClass("event-active");

			$(".e-img").css("display", "none");
			$("#e-img-" + currentevent).css("display", "block");
		}
		var eventTimer = setInterval(changeEvent, 3000);
	
		/*if ($("#mainbox-new").height() > $("#mainbox-best").height())
			$(("#mainbox-best").height($("#mainbox-new").height()));
		else
			$(("#mainbox-new").height($("#mainbox-best").height()));*/

		$(".e-li").click(function(){
			var idx = $(".e-li").index(this) + 1;

			currentevent = idx;

			$(".e-li").removeClass("event-active");
			$("#e-li-" + currentevent).addClass("event-active");

			$(".e-img").css("display", "none");
			$("#e-img-" + currentevent).css("display", "block");

			clearInterval(eventTimer);
			eventTimer = setInterval(changeEvent, 3000);
		});
	});
</script>
</head>
<body>

	<!-- 헤더 분리 -->
	<c:import url="/header.do"></c:import>

	<!-- 메인화면 -->
	<div class="container-fluid bg-lightgray pt-3 pb-3">
		<div class="container">
			<!-- 이벤트 이미지 -->
			<div class="mt-3">
				<table class="eventimage">
					<tr>
						<td class="bg-brown1">
							<ul>
								<c:forEach items="${mainEvents}" varStatus="e" var="mainEvent">
									<c:choose>
										<c:when test="${e.count ==1 }">

											<li class="p-2 e-li event-active" id="e-li-${e.count}">${mainEvent.title }</li>
										</c:when>
										<c:otherwise>

											<li class="p-2 e-li" id="e-li-${e.count}">${mainEvent.title }</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${mainEventCount==0}">
									<li>
										<p class="event-active">
											<i class="fas fa-exclamation-triangle"></i>
										</p>
										<p>
											현재 진행중인<br>이벤트가 없습니다
										</p>
									</li>
								</c:if>
							</ul>
						</td>
						<td class="bg-brown2" style="width: 880px"><c:forEach items="${mainEvents}" varStatus="e" var="mainEvent">
								<a href="${mainEvent.url}"> <c:choose>
										<c:when test="${e.count ==1 }">

											<img class="e-img" id="e-img-${e.count}" src="./resources/event/${ mainEvent.image }">
										</c:when>
										<c:otherwise>

											<img class="e-img" id="e-img-${e.count}" style="display: none" src="./resources/event/${ mainEvent.image }">
										</c:otherwise>
									</c:choose>
								</a>
							</c:forEach> <c:if test="${mainEventCount==0}">
								<img src="./resources/images/noevent.png">
							</c:if></td>
					</tr>
				</table>

			</div>



			<div class="row">
				<!-- 베스트셀러 -->
				<div class="col-8 h-100">
					<div class="mainbox-title mt-4">
						<i class="fas fa-crown text-bsyellow"></i> 이번 주 BEST
					</div>
					<div class="mainbox p-3 pt-4 align-middle" id="mainbox-best">
						<div class="row">
							<c:forEach items="${bestBooks}" var="book">
								<div class="col">
									<table class="main-best mauto">
										<tr>
											<td style="text-align: center"><a href="bookdetail.do?idx=${book.bi_num}"><img src="${book.bi_image}"></a></td>
										</tr>
										<tr>
											<td class="text-darkgray"><b>${book.bi_title }</b></td>
										</tr>
										<tr>
											<td class="text-brown2"><small>${book.bi_writer } / ${book.bi_publisher }</small></td>
										</tr>
										<tr>
											<td class="text-darkgray" style="text-align: right">${book.bi_price }원</td>
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
					<div class="mainbox main-new" id="mainbox-new">
						<table class="main-new-item">
							<c:forEach items="${newBooks}" var="newBook">
								<tr>
									<td><a href="bookdetail.do?idx=${newBook.bi_num}"><img src="${ newBook.bi_image }"></a></td>
									<td class="text-darkgray"><b>${ newBook.bi_title }</b><br> <small class="text-brown2">${ newBook.bi_writer } / ${ newBook.bi_publisher }</small></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>


			</div>

			<!-- 공지사항, 최근리뷰, 메뉴 -->

			<div class="row">
				<!-- 최근 공지사항 -->
				<div class="col h-100">
					<div class="mainbox-title mt-4">
						공지사항 <a href="notice.do" class="text-brown3"><i class="fas fa-plus"></i></a>
					</div>
					<ul class="main-notice">
						<c:forEach items="${notice}" var="nt">
							<li><span class="text-brown2">[${nt.upload_date}] </span><span class="text-darkgray"><a href="notice_detail.do?num=${nt.notice_num}">${nt.notice_title}</a></span></li>
						</c:forEach>

					</ul>
				</div>
				<!-- 최근 리뷰 -->

				<div class="col h-100">
					<div class="mainbox-title mt-4">최신 리뷰</div>
					<!-- 리뷰 2건 출력 -->
					<c:forEach items="${newReplies}" var="reply">
						<table class="table-sm table-borderless mb-2 main-review">
							<tr>
								<td rowspan="3" class="pl-2"><a href="bookdetail.do?idx=${reply.bi_num}"><img src="${reply.bi_image}" class="main-review-img"></a></td>
								<td><span class="text-darkgray"><b>${ reply.bi_title }</b></span><span class="text-brown2"><br> <small>${reply.bi_writer } / ${reply.bi_publisher }</small></span></td>
							</tr>
							<!-- 별점 -->
							<tr>
								<td><span class="text-bsyellow"> <c:forEach begin="1" end="${reply.bi_stars}">
											<i class="fas fa-star"></i>
										</c:forEach> <c:forEach begin="${reply.bi_stars + 1}" end="5">
											<i class="far fa-star"></i>
										</c:forEach>
								</span></td>
							</tr>
							<tr>
								<td>
									<p class="text-darkgray">
										<small>${reply.bi_comment}</small>
									</p>
								</td>
							</tr>
						</table>
					</c:forEach>
				</div>

			</div>

		</div>
	</div>
	<!-- footer 분리 -->
	<c:import url="footer.jsp"></c:import>
</body>
</html>
