<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>주문내역</title>
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
						<i class="fas fa-clipboard-list text-brown1"></i> 주문내역
					</h2>
				</div>
				<h3 class="text-brown1 p-3">주문자 정보</h3>
				<table class="table">
					<tr>
						<th>주문번호</th>
						<th>받는사람</th>
						<th>배송지</th>
						<th>주문일자</th>
						<th>수량</th>
						<th>총액</th>
						<th>상태</th>
					</tr>
					<c:forEach var="od" items="${od}">
						<tr align="center">
							<td>${od.ordernum}</td>
							<td>${od.receiver}</td>
							<td>${od.address1}<br>${od.address2}</td>
							<td>${od.wdate}</td>
							<td>${od.totalamount}개</td>
							<td>${od.totalprice}원</td>
							<td>${od.orderstatus}</td>
						</tr>
					</c:forEach>
				</table>

				<h3 class="text-brown1 p-3">상품 목록</h3>
				<c:import url="/orderDetail2.do" />
				<div class="acenter p-5">
					<button class="btn btn-brown1" type="button" onclick="location.href='myorder.do'" style="height: 50px">내 주문 목록</button>
					<button class="btn btn-brown1" type="button" onclick="location.href='main.do'" style="height: 50px">메인화면</button>
				</div>
			</div>
		</div>
	</div>
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
