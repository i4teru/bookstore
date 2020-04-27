<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>myorder.jsp</title>
</head>
<body>
	<c:import url="/header.do"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="fas fa-bullhorn text-brown1"></i>나의 주문정보
					</h2>
				</div>

			
				<table class="table">
					<tr>
						<th>번호</th>
						<th>주문번호</th>
						<th>받는사람</th>
						<th>배송지</th>
						<th>주문일자</th>
						<th>총주문수량</th>
						<th>총주문금액</th>
						<th>주문상태</th>
					</tr>
					<c:forEach var="od" items="${myorder}">
						<tr>
							<td class="acenter">${od.rn}</td>
							<td><a href="orderDetail.do?ordernum=${od.ordernum}">${od.ordernum}</a></td>
							<td class="acenter">${od.receiver}</td>
							<td class="acenter">${od.address1}&nbsp;${od.address2}</td>
							<td class="acenter">${od.wdate}</td>
							<td class="acenter">${od.totalamount}</td>
							<td class="acenter">${od.totalprice}</td>
							<td class="acenter">${od.orderstatus}</td>
						</tr>
					</c:forEach>
				</table>


				<ul class="pagination justify-content-center p-5">
					<c:if test="${ startpage != 1 }">
						<li class="page-item"><a class="page-link" href="myorder.do?pageNum=${startpage-10}">이전</a></li>
					</c:if>
					<c:forEach begin="${startpage}" end="${endpage}" var="p">
						<c:choose>
							<c:when test="${pageNUM==p}">
								<li class="page-item active"><a class="page-link" href="myorder.do?pageNum=${p}">${p}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" href="myorder.do?pageNum=${p}">${p}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${endpage < pagecount}">
						<li class="page-item"><a class="page-link" href="myorder.do?pageNum=${endpage+10}">다음</a></li>
					</c:if>
				</ul>

			</div>
		</div>

	</div>
	<c:import url="footer.jsp"></c:import>
</body>
</html>
