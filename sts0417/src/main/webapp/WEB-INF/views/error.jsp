<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>오류</title>
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
			<div class="mainbox p-5">
				<h1 class="p-5 acenter"><i class="fas fa-exclamation-triangle text-brown1"></i></h1>
				<h3 class="text-darkgray acenter">처리 중 오류가 발생했습니다.</h3>
				<p class="text-brown1 pt-3 pb-5 acenter">${msg}</p>
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
