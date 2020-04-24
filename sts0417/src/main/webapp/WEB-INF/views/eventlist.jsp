<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>이벤트 관리</title>
<!-- js import -->
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>


</head>
<body>
	<c:import url="header.jsp"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="far fa-flag text-brown1"></i> 이벤트 관리
					</h2>
				</div>
				<div class="aright pb-3">
					<button class="btn btn-brown1" type="button" onclick="location.href='eventwrite.do'">새 이벤트 작성</button>
				</div>
				<table class="table eventtable">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>url</th>
						<th>시작일</th>
						<th>종료일</th>
					</tr>
					<c:forEach items="${ events }" var="event">
						<tr>
							<td rowspan="2">${ event.num }</td>
							<td>${ event.title }</td>
							<td>${ event.url }</td>
							<td rowspan="2">${ event.startdate }</td>
							<td rowspan="2">${ event.enddate }</td>
						</tr>
						<tr>
							<td colspan="2"><img src="./resources/event/${ event.image }"></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<c:import url="footer.jsp"></c:import>
</body>
</html>
