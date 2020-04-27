<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>공지사항</title>
</head>
<body>
	<c:import url="/header.do"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="fas fa-bullhorn text-brown1"></i> 공지사항
					</h2>
				</div>

				<div class="aright pb-3">
					<!-- 관리자에게만 작성 버튼 노출 -->
					<c:if test="${ usergrade==0 }">
						<button class="btn btn-brown1" type="button"
							onclick="location.href='noticeup.do'">새 공지사항</button>
					</c:if>
				</div>
				<table class="table">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
					</tr>
					<c:forEach var="ntc" items="${list}">
						<tr>
							<td class="acenter">${ntc.notice_num}
							<td><a href="notice_detail.do?num=${ntc.notice_num}">${ntc.notice_title}</a></td>
							<td class="acenter">${ntc.upload_date}</td>
						</tr>
					</c:forEach>
				</table>


				<ul class="pagination justify-content-center p-5">
					<c:if test="${ startpage != 1 }">
						<li class="page-item"><a class="page-link"
							href="notice.do?pageNum=${startpage-10}">이전</a></li>
					</c:if>
					<c:forEach begin="${startpage}" end="${endpage}" var="p">
						<c:choose>
							<c:when test="${pageNUM==p}">
								<li class="page-item active"><a class="page-link"
									href="notice.do?pageNum=${p}">${p}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="notice.do?pageNum=${p}">${p}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${endpage < pagecount}">
						<li class="page-item"><a class="page-link"
							href="notice.do?pageNum=${endpage+10}">다음</a></li>
					</c:if>
				</ul>

			</div>
		</div>

	</div>
	<c:import url="footer.jsp"></c:import>
</body>
</html>
