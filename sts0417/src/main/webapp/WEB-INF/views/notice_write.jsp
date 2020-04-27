<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
						<i class="fas fa-bullhorn text-brown1"></i> 새 공지사항
					</h2>
				</div>
				<form name="noticeform" action="notice_save.do">
					<table class="table table-borderless table-sm">
						<tr>
							<td>제목</td>
							<td><input type="text" class="form-control" id="title" name="notice_title"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea rows="10" cols="30" class="form-control" id="content" name="notice_content"></textarea></td>
						</tr>
						<tr>
							<td><input type="submit" class='btn btn-sm' id="complete" value="작성"></td>
							<td><input type="button" class='btn btn-sm' onclick="history.back()" value="취소"></td>
						</tr>
						<tr>
							<td colspan="2" class="acenter pt-5 pb-3"><button class="btn btn-brown1" id="btnJoin" type="button" style="width: 200px; height: 50px;" onclick="Checked()">회원가입</button>
								<button class="btn btn-secondary" type="button" style="width: 100px; height: 50px;" onclick="history.back()">취소</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
