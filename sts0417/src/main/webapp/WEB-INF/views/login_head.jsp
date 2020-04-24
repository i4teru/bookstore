<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>메인</title>
</head>
<body>
<h1>메인페이지</h1>
<h3>
<c:choose>
<c:when test="${userid eq null}"></c:when>
<c:otherwise>
로그인된 아이디${userid}
</c:otherwise>
</c:choose>
</h3>
<ul>
	<li><a href="signup.do">가입하기</a></li>
	<li><a href="login.do">로그인</a></li>
	<li><a href="logout.do">로그아웃</a></li>
	<li><a href="#">장바구니</a></li>
	<li><a href="#">구매목록</a></li>
</ul>


</body>
</html>
