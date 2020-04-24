<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>notice_detail</title>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	$(function(){
		$("#edit").click(function(){
			$("#edittable").html("<div class='container'><form action='notice_edit.do'><table class='table table-borderless table-sm'><tr><td>번호</td><td>제목</td><td>등록일</td></tr><tr><td>${dto.notice_num}<input type='text' name='notice_num' value='${dto.notice_num}' hidden></td><td><input type='text' class='form-control form-control-sm' name='notice_title' value='${dto.notice_title}'></td><td>'${dto.upload_date}'</td></tr><tr><td colspan='3'>내용</td></tr><tr><td colspan='3'><textarea rows='10' cols='30' class='form-control form-control-sm' name='notice_content'>${dto.notice_content}</textarea><td></tr><tr><td><input type='submit' class='btn btn-sm' value='저장'</td><td><input type='button' value='취소' class='btn btn-sm' onclick='location.reload()'</td></tr></table></form></div>");
			});
		$("#delete").click(function(){
			if(confirm("삭제하시겠습니까")){
			window.location.href="notice_delete.do?num=${dto.notice_num}"
			}
			});
		});
</script>


<body>
	<c:import url="header.jsp"></c:import>
	<div class="container">
		<div id="edittable">
		<table class="table table-borderless table-sm">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>등록일</td>
			</tr>
			<tr>
				<td>${dto.notice_num}</td>
				<td>${dto.notice_title}</td>
				<td>${dto.upload_date}</td>
			</tr>
			<tr>
				<td colspan="3">내용</td>
			</tr>
			<tr>
				<td colspan="3">${dto.notice_content}</td>
			</tr>
		</table>
		</div>
		<input type="button" class="btn btn-sm" value="뒤로가기" onclick="history.back()">
		<input type="button" class="btn btn-sm" value="수정" id="edit">
		<input type="button" class="btn btn-sm" value="삭제" id="delete">
		
	</div>
</body>
</html>
