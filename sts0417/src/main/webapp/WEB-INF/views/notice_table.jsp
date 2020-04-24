<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>공지사항</title>
</head>
<body>
	<c:import url="header.jsp"></c:import>
	<div class="container">
		<table class="table table-borderless table-sm">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>등록일</td>
			</tr>
			<c:forEach var="ntc" items="${list}">
				<tr>
					<td>${ntc.rn}</td>
					<td>${ntc.notice_num}
					<td><a href="notice_detail.do?num=${ntc.notice_num}">${ntc.notice_title}</a></td>
					<td>${ntc.upload_date}</td>
				</tr>
			</c:forEach>

			<tr>
				<td colspan="3" align="center">
					<c:if test="${startpage>10}">
						<a href="notice.do?pageNum=${startpage+10}">이전</a>
					</c:if>
					<c:forEach var="i" begin="${startpage}" end="${endpage}" step="1">
						<c:choose>
							<c:when test="${i==pageNUM}">
								<font style="color: #8C7B72; font-size: 15px">
									<b>${i}</b>
								</font>
							</c:when>
							<c:otherwise>
								<a href="notice.do?pageNum=${i}">${i} </a>
							</c:otherwise>
						</c:choose>
					</c:forEach> 
					<c:if test="${endpage<pagecount}">
						<a href="notice.do?pageNum=${startpage+10}">다음</a>
					</c:if>
				</td>
			</tr>
		</table>
		<input type="button" class="btn btn-sm" value="뒤로가기" onclick="location.href('login_head.do')">
	</div>

</body>
</html>
