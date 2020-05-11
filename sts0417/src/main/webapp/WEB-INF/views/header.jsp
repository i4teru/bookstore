<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>


<!-- 부트스트랩 변형 -->
<link rel="stylesheet" href="./resources/css/bookstore.css">

<!-- 부트스트랩, jquery -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">

<!-- 폰트어썸 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

<script type="text/javascript">
function goSearch(){
	var a = document.searchform.scnum.value();
	alert(a);
}
</script>

<div class="title pt-5">
	<div class="container mb-3">
		<div class="row">
			<!-- 로고 이미지 -->
			<div class="col-3 aleft">
				<a href="main.do"><img class="mainlogo" src="./resources/images/logo.png"></a>
			</div>
			<!-- 검색창 -->
		
			<div class="col-6 acenter">
			<form action="bookSection.do">
				<div class="input-group mainsearch-group">
					<input class="form-control mainsearch" type="text" name="query" value="${search_query}">
					<input type="hidden" name="scnum" value="6">
					<div class="input-group-append">
						<button class="btn" type="submit">
							<i class="fas fa-search text-brown1"></i>
						</button>
					</div>
				</div>
			</form>
			</div>
			<!-- 로그인 -->
			<div class="col-3 aright">

				<!-- 로그인 했을 때 -->
				<div style="margin: auto">
					<c:if test="${ userid!='' }">
						<p class="text-darkgray">
							<b>${username}<small>(${userid})</small></b>
							<button class="btn btn-sm btn-brown1" type="button" onclick="location.href='logout.do'">
								<i class="fas fa-sign-out-alt"></i> 로그아웃
							</button>
						</p>
					</c:if>

					<!-- 로그인 안했을 때 -->
					<c:if test="${ userid=='' }">
						<button class="btn btn-sm btn-brown1" type="button" onclick="location.href='login.do'">
							<i class="fas fa-sign-in-alt"></i> 로그인
						</button>
						<button class="btn btn-sm btn-light" type="button" onclick="location.href='signup.do'">
							<i class="fas fa-user-plus"></i> 회원가입
						</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 메뉴바 -->
<nav class="navbar navbar-expand-sm navbar-light">
	<div class="container">
		<!-- 메뉴 -->
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="bookList.do">분야별 도서 보기</a></li>
			<li class="nav-item"><a class="nav-link disabled" href="#">스터디 룸 예약</a></li>
			<li class="nav-item"><a class="nav-link" href="notice.do">공지사항</a></li>
		</ul>



		<!-- 회원메뉴 -->

		<ul class="navbar-nav">
			<!-- 비로그인시 기본메시지 -->
			<c:if test="${userid=='' }">
				<li class="nav-item"><span class="text-darkgray">개발책방의 회원이 되시고 다양한 혜택을 즐겨보세요!</span></li>
			</c:if>
			<!-- 로그인했을때만 -->
			<c:if test="${ userid!='' }">
				<li class="nav-item"><a class="nav-link disabled" href="#"><i class="fas fa-user"></i>&nbsp;마이페이지</a></li>
				<li class="nav-item"><a class="nav-link" href="myorder.do"><i class="far fa-list-alt"></i></i>&nbsp;내 주문</a></li>
				<li class="nav-item"><a class="nav-link" href="pickList.do"><i class="fas fa-shopping-cart"></i>&nbsp;장바구니&nbsp;<c:if test="${pickCount!=0}"><span class="badge badge-secondary bg-brown2">${pickCount}</span></c:if></a></li>
			</c:if>
			<!-- 관리자메뉴 -->
			<!-- 아이디가 admin일때 혹은 grade가 관리자등급일때 -->
			<c:if test="${ usergrade==0 }">
				<li class="nav-item ml-5"><span class="nav-link disabled"><i class="fas fa-cog"></i>관리</span></li>
				<li class="nav-item"><a class="nav-link" href="bookRegister.do?msg=new">도서 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="eventlist.do">이벤트 관리</a></li>
			</c:if>

		</ul>



	</div>
</nav>


