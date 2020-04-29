<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>이벤트 관리</title>
<!-- js import -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>


</head>
<body>
	<c:import url="/header.do"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="far fa-flag text-brown1"></i> 이벤트 관리
					</h2>
				</div>
				<!-- 관리자에게만 작성 버튼 노출 -->
				<c:if test="${ usergrade==0 }">
					<div class="aright pb-3">
						<button class="btn btn-brown1" type="button" onclick="location.href='eventwrite.do'">새 이벤트 작성</button>
					</div>
				</c:if>
				<table class="table eventtable">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>url</th>
						<th>시작일</th>
						<th>종료일</th>
						<!-- 관리자에게만 삭제 버튼 노출 -->
						<c:if test="${ usergrade==0 }">
							<th>삭제</th>
						</c:if>
					</tr>
					<c:forEach items="${ events }" var="event">
						<tr>
							<td rowspan="2">${ event.num }</td>
							<td>${ event.title }</td>
							<td>${ event.url }</td>
							<td rowspan="2">${ event.startdate }</td>
							<td rowspan="2">${ event.enddate }</td>
							<!-- 관리자에게만 삭제 버튼 노출 -->
							<c:if test="${ usergrade==0 }">
								<td rowspan="2">
									<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal${event.num}">삭제</button>
									<div class="modal" id="myModal${event.num}">
										<div class="modal-dialog">
											<div class="modal-content">

												<!-- Modal Header -->
												<div class="modal-header">
													<h4 class="modal-title">삭제확인</h4>
													<button type="button" class="close" data-dismiss="modal">&times;</button>
												</div>

												<!-- Modal body -->
												<div class="modal-body">이벤트를 삭제하시겠습니까?</div>

												<!-- Modal footer -->
												<div class="modal-footer">
													<button class="btn btn-danger" type="button" onclick="location.href='deleteEvent.do?num=${event.num}'">삭제</button>
													<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
												</div>

											</div>
										</div>
									</div>
								</td>
							</c:if>
						</tr>
						<tr>
							<td colspan="2"><img src="./resources/event/${ event.image }"></td>
						</tr>
					</c:forEach>
				</table>
				<ul class="pagination justify-content-center p-5">
					<c:if test="${ pagestart != 1 }">
						<li class="page-item"><a class="page-link" href="eventlist.do?page=${pagestart-10}">이전</a></li>
					</c:if>
					<c:forEach begin="${pagestart}" end="${pageend}" var="p">
						<c:choose>
							<c:when test="${page==p}">
								<li class="page-item active"><a class="page-link" href="eventlist.do?page=${p}">${p}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="eventlist.do?page=${p}">${p}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageend < pagecount}">
						<li class="page-item"><a class="page-link" href="eventlist.do?page=${pageend+10}">다음</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<c:import url="footer.jsp"></c:import>
</body>
</html>
