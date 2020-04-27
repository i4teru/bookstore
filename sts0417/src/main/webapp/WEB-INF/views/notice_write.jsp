<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>공지사항</title>
<!-- js import -->
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

</head>

<body>
	<c:import url="/header.do"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="fas fa-bullhorn text-brown1"></i> 새 공지사항
					</h2>
				</div>
				<!-- 관리자에게만 내용 노출 -->
				<c:if test="${ usergrade==0 }">
					<form name="noticeform" action="notice_save.do">
						<table class="table table-borderless table-sm">
							<tr>
								<td>제목</td>
								<td><input type="text" class="form-control" id="title"
									name="notice_title"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea rows="10" cols="30" class="form-control"
										id="content" name="notice_content"></textarea></td>
							</tr>
							<tr>
								<td colspan="2" class="acenter pt-5 pb-3"><button
										class="btn btn-brown1" id="btnJoin" type="submit"
										style="width: 200px; height: 50px;">공지사항 작성</button>
									<button class="btn btn-secondary" type="button"
										style="width: 100px; height: 50px;" onclick="history.back()">취소</button></td>
							</tr>
						</table>
					</form>
				</c:if>
				<!-- 권한이 없을 때 -->
				<c:if test="${usergrade!=0 }">
					<h2 class="acenter p-5">권한이 없습니다.</h2>
				</c:if>
			</div>
		</div>
	</div>
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
