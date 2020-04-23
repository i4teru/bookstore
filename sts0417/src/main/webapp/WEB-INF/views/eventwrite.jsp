<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>새 이벤트</title>
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
						<i class="far fa-flag text-brown1"></i> 새 이벤트
					</h2>
				</div>
				<div class="aright pb-3">
					<button class="btn btn-brown1" type="button" onclick="">새 이벤트 작성</button>
				</div>
				<table class="table table-borderless">
					<tr>
						<th>이벤트 제목</th>
						<td><input type="text" name="title" class="form-control"></td>
					</tr>
					<tr>
						<th>URL</th>
						<td><input type="text" name="title" class="form-control"></td>
					</tr>
					<tr>
						<th>파일첨부</th>
						<td><input type="file" name="title" class="form-control"></td>
					</tr>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<c:import url="footer.jsp"></c:import>
</body>
</html>
