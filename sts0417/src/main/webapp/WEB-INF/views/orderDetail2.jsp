<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>



<table class="table">
	<tr>
		<th>이미지</th>
		<th>주문품목</th>
		<th>작 가</th>
		<th>출판사</th>
		<th>수 량</th>
		<th>주문금액</th>

	</tr>
	<c:forEach var="dt" items="${detail}">
		<tr align="center">
			<td class="align-middle"><img src="${dt.bi_image}" style="max-height:150px"></td>
			<td class="align-middle">${dt.bi_title}</td>
			<td class="align-middle">${dt.bi_writer}</td>
			<td class="align-middle">${dt.bi_publisher}</td>
			<td class="align-middle">${dt.p_amount}</td>
			<td class="align-middle">${dt.p_price}</td>
		</tr>
	</c:forEach>
</table>
