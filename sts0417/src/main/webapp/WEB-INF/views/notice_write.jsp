<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>공지사항</title>
</head>

<body>
	<c:import url="header.jsp"></c:import>

	<form name="noticeform" action="notice_save.do">
		<div class="container">
			<table class="table table-borderless table-sm">
				<tr>
					<td>제목</td>
					<td><input type="text" class="form-control form-control-sm" id="title" name="notice_title"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="10" cols="30" class="form-control form-control-sm" id="content" name="notice_content"></textarea></td>
				</tr>
				<tr>
					<td><input type="submit" class='btn btn-sm' id="complete" value="작성"></td>
					<td><input type="button" class='btn btn-sm' onclick="history.back()" value="취소"></td>
				</tr>
			</table>
		</div>
	</form>

</body>
</html>
