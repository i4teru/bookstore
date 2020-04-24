<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>새 이벤트</title>

<!-- js import -->
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<!-- 데이트피커 -->

<link rel="stylesheet" href="./resources/css/bootstrap-datepicker.css">
<script src="./resources/js/bootstrap-datepicker.min.js"></script>
<script src="./resources/js/bootstrap-datepicker.ko.min.js"></script>
<script>
	$(function() {
		$("#startdate").datepicker({
			format : "yyyy-mm-dd",
			autoclose : "true",
			language : "ko"
		});

		$("#enddate").datepicker({
			format : "yyyy-mm-dd",
			autoclose : "true",
			language : "ko"
		});
	});
</script>
<style>
th {
	text-align: left !important;
}
</style>
</head>
<body>
	<c:import url="header.jsp"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="far fa-flag text-brown1"></i> 새 이벤트
					</h2>
				</div>
				<form action="insertEvent.do" enctype="multipart/form-data" method="post">
					<table class="table table-borderless aleft" style="width: 80%">
						<tr>
							<th>이벤트 제목</th>
							<td><input type="text" name="title" class="form-control" required></td>

						</tr>
						<tr>
							<th>URL</th>
							<td><input type="text" name="url" class="form-control" required></td>

						</tr>
						<tr>
							<th>파일첨부</th>
							<td><input type="file" name="file" class="form-control" required></td>

						</tr>
						<tr>
							<th>시작일</th>
							<td><input type="text" name="startdate" id="startdate" class="form-control" style="width: 200px" required></td>
						</tr>
						<tr>

							<th>종료일</th>
							<td><input type="text" name="enddate" id="enddate" class="form-control" style="width: 200px" required></td>
						</tr>
					</table>

					<div class="acenter pb-3">
						<button class="btn btn-brown1" type="submit">작성</button>
						<button class="btn btn-secondary" type="button" onclick="history.back()">돌아가기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<c:import url="footer.jsp"></c:import>
</body>
</html>
