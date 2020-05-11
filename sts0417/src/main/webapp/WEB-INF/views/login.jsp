<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>로그인</title>
<!-- js import -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<script>
	$(window).on("load", function() {
		var c = "${msg}".trim();//$( "#dialog-message").val();
		if (c != "") {
			$("#myModal").modal('show');
		}
	});
</script>
</head>
<body>
	<c:import url="/header.do"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox loginbox">
				<p class="logintitle text-brown1 mt-3 mb-3">
					<i class="fas fa-user"></i>&nbsp;로그인
				</p>
				<hr>
				<form name="loginform" action="logincheck.do">
					<table class="table table-borderless mt-3">
						<tr>
							<td><label for="id" class="text-darkgray">아이디</label><input class="form-control" type="text" name="id"></td>
						</tr>
						<tr>
							<td><label for="password" class="text-darkgray">비밀번호</label><input class="form-control" type="password" name="password"></td>
						</tr>
						<tr>
							<td><button class="btn btn-brown1" type="submit" style="width: 100%; height: 60px">로그인</button></td>
						</tr>
						<tr>
							<td style="text-align: center;"><span class="text-darkgray">아직 회원이 아니신가요? <a href="signup.do">회원가입</a></span></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap Modal -->
	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">오류</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">${msg}</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-brown1" data-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>

	<c:import url="footer.jsp"></c:import>
</body>
</html>
