<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>


<!-- 부트스트랩 변형 -->
<link rel="stylesheet" href="./resources/css/bookstore.css">

<!-- 부트스트랩, jquery -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

<div class="title pt-5">
	<div class="container mb-3">
		<div class="row">
			<!-- 로고 이미지 -->
			<div class="col-3 aleft">
				<a href="main.do"><img class="mainlogo" src="./resources/images/logo.png"></a>
			</div>
			<!-- 검색창 -->
			<div class="col-6 acenter">
				<div class="input-group mainsearch-group">
					<input class="form-control mainsearch" type="text">
					<div class="input-group-append">
						<button class="btn" type="submit">
							<i class="fas fa-search text-brown1"></i>
						</button>
					</div>
				</div>
			</div>
			<!-- 로그인 -->
			<div class="col-3 aright">로그인, 로그아웃</div>
		</div>
	</div>
</div>

<!-- 메뉴바 -->
<nav class="navbar navbar-expand-sm navbar-light">
	<div class="container">
		<!-- Links -->
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link active" href="#">Link 1</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Link 2</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Link 3</a></li>
		</ul>
	</div>
</nav>


