<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<!-- js import -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<title>회원가입 완료</title>
</head>
<script type="text/javascript">
	setTimeout("location.href='login.do'", 5000);
</script>
<body>
	<c:import url="/header.do"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="acenter p-5">
					<h1 class="p-5">
						<i class="far fa-check-circle text-brown1 "></i> 회원가입 성공
					</h1>

					<h4 class="p-5">
						<b>${uname}<small>(${uid})</small></b>님 환영합니다!
					</h4>

					<p class="p-5 text-brown2">잠시 후 로그인 페이지로 이동합니다.</p>
				</div>
			</div>
		</div>
	</div>
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
