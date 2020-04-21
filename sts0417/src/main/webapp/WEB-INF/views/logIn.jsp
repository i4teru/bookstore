<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>로그인</title>
</head>
<body>
<h2>로그인</h2>
<form name="loginform" action="logincheck.do">
	<table>
		<tr>
			<td>아이디:</td><td><input type="text" name="id" value="books"></td>
		</tr>
		<tr>
			<td>비밀번호:</td><td><input type="password" name="password" value="1234"></td>
		</tr>
		<tr>
			<td><input type="submit" value="로그인"></td><td><input type="button" value="돌아가기" onclick="history.back()"></td>
		</tr>
	</table>
</form>

</body>
</html>
