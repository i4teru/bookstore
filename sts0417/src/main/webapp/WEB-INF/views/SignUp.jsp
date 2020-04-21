<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form name="loginform" action="signupcomplete.do">
	<table>
		<thead>
			<tr><td>@회원가입@</td></tr>
		</thead>
		<tbody>
			<tr>
				<td>#아이디#</td><td><input type="text" name="id" value="books"></td>
			</tr>
			<tr>
				<td>#패스워드#</td><td><input type="password" name="password" value="1234"></td>
			</tr>
			<tr>
				<td>#패스워드 확인#</td><td><input type="password" value="1234"></td>
			</tr>
			<tr>
				<td>#이메일#</td><td><input type="text" name="email" value="eee@eee.com"></td>
			</tr>
			<tr>
				<td>#전화번호#</td><td><input type="text" name="phone" value="123-1234-1234"></td>
			</tr>
			<tr>
				<td>#생년월일#</td><td><input type="text" name="birthday"></td>
			</tr>
			<tr>
				<td>#성별#</td><td><input type="radio" name="gender" value="1">남<input type="radio" name="gender" value="0">여</td>
			</tr>
			<tr>
				<td>#배송지#</td><td><input type="text" name="location" value="당상역1번출구"></td>
			</tr>
			<tr>
				<td><input type="submit" value="확인"></td><td><input type="reset" value="취소" onclick="history.back()"></td>
			</tr>
		</tbody>
	</table>
</form>


</body>
</html>