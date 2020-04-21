<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title> [book_reply.jsp]</title>
 
 <style type="text/css">
 .replybox{
 	margin: auto;
 	height: 170px;
	width: 820px;
	background-color:#eeeeee; 
 }
 
 .txtbox{
 	margin-left : 10px;
 	margin-top : 10px;
 	margin-bottom : 10px;
 	margin-right : 5px;
 	height: 100px;
	width: 700px;
 }
 
 .replybtn{
 	height: 80px;
 	width : 80px
 }
 
 </style> 
</head>
<body>
<table class="replytable" width="820px" align="center">
	<tr bgcolor="lightgray">
		<td colspan="4">디테일 책 글번호 ~의 댓 글</td>
	<tr>
		<td width=70>아이디</td>
		<td width=100>별점</td>
		<td width=150>날짜시간</td>
		<td width=200>내용</td>
	</tr>
</table>
<br>
<form action="bookreply.do">
  <div class="replybox">
	<input type="hidden" name="bi_num">
	<br>&nbsp;리뷰입력  별점입력 ☆☆☆☆☆<br>
	<input type="text" class="txtbox" name="r_content"> 
	<input type="button" class="replybtn" value="등록">
  </div>
</form>

</body>
</html>