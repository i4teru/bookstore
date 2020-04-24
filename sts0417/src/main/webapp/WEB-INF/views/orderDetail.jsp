<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>orderDetail.jsp</title>
	
	<script type="text/javascript">

	</script>
</head>
<body>
<h1>주문정보</h1>

<form name="frm">
	<table style="width: 900px;">
			<tr>
				<th>주문번호</th>
				<th>주문아이디</th>
				<th>받는사람</th>
				<th>배송지</th>
				<th>주문일자</th>
				<th>주문상태</th>
			</tr>
		<c:forEach var="od" items="${od}">
			<tr align="center">
			<td>${od.ordernum}</td>
			<td>${od.userid}</td>
			<td>${od.receiver}</td>
			<td>${od.address1}&nbsp;${od.address2}</td>
			<td>${od.buydate}</td>
			<td>${od.orderstatus}</td>
			</tr>
		</c:forEach>
</table>
</form>



<input type="button" name="main" value="메인">
</body>
</html>
