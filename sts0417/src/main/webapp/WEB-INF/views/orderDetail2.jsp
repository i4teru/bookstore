<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>orderDetail2.jsp</title>
	
	<script type="text/javascript">

	</script>
</head>
<body>
<h1>주문상세</h1>

<form name="frm">
	<table style="width: 900px;">
			<tr>
				<th>주문번호</th>
				<th>이미지</th>
				<th>주문품목</th>
				<th>작   가</th>
				<th>출판사</th>
				<th>수   량</th>
				<th>판매가</th>
				<th>주문금액</th>

			</tr>
		<c:forEach var="dt" items="${detail}">
			<tr align="center">
			<td>${dt.ordernum}</td>
			<td><img src="${dt.bi_image}" style="width:100px; height:100px;"></td>
			<td>${dt.bi_title}</td>
			<td>${dt.bi_writer}</td>
			<td>${dt.bi_publisher}</td>
			<td>${dt.p_amount}</td>
			<td>${dt.bi_sprice}</td>
			<td>${dt.p_price}</td>
			</tr>
		</c:forEach>
</table>
</form>



</body>
</html>
