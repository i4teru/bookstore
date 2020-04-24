<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>s1 모바일/임베디드</title>
<style type="text/css">

.right {
	text-align: right;
}

.centerd {
	text-align: center;
}

tr.space {
  border-bottom: 10px solid #F2F2F2;
}

ul.breadcrumb {
  padding: 8px 16px;
  list-style: none;
  background-color: #F2F2F2;
}

ul.breadcrumb li {display: inline;}

ul.breadcrumb li+li:before {
  padding: 8px;
  color: black;
  content: "|\00a0";
}

ul.breadcrumb li a {color: #8C7B72;}

.pagination {
  display: inline-block;
}

.pagination a {
  color: black;
  float: left;
  padding: 4px 8px;
  text-decoration: none;
  transition: background-color .3s;
  border: 1px solid #ddd;
  margin: 0 4px;
  font-size: 15px;
}

.pagination a.active {
  background-color: #8C7B72;
  color: white;
  border: 1px solid #8C7B72;
}

.pagination a:hover:not(.active) {background-color: #ddd;}


</style>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<script>

</script>
</head>
<body>
   
	<!-- 헤더 영역 -->
	<c:import url="./header.jsp"></c:import>

	<!-- 리스트 메인 -->
	<div class="container-fluid bg-lightgray pt-3 pb-3">
		<div class="container">

			<!-- 센션타이틀/섹션total/정렬옵션/페이징/전체선택 및 전체장바구니 버튼-->
			<div class="mt-1">
				<table class="w-100 noppading nomargin">
					<tr><td><h3><i class="fa fa-mobile text-brown1" aria-hidden="true"></i> 모바일/임베디드</h3><hr></td></tr>
					<tr><td> &nbsp; 총 ${S1Total}권의 상품이 등록되어 있습니다. </td></tr>
					<tr>
						<td> 
							<ul class="breadcrumb justify-content-center">
							  <li><a href="#">최신순</a></li>
							  <li><a href="#">최저가순</a></li>
							  <li><a href="#">판매량순</a></li>
							  <li><a href="#">평점순</a></li>
							  <li><a href="#">리뷰순</a></li>
							</ul>
						</td></tr>
					<tr>
						<td>
							<div class="pagination justify-content-center">
							  <a href="#">&laquo;</a>
							  <a href="#">1</a>
							  <a href="#" class="active">2</a>
							  <a href="#">3</a>
							  <a href="#">4</a>
							  <a href="#">5</a>
							  <a href="#">6</a>
							  <a href="#">&raquo;</a>
							</div>
						</td>
					</tr>
					<tr class="space">
						<td class="right">
						<button type="button" class="btn btn-outline-dark btn-sm" onclick=""> 전체선택 </button>
						<button type="button" class="btn btn-outline-dark btn-sm" onclick=""> 장바구니 </button>
						<button type="button" class="btn btn-outline-dark btn-sm" onclick=""> 찜리스트 </button>
						</td>
					</tr>
				</table>
			</div>

			<div class="row justify-content-center">
				<div class="col-12">				
				<form>
				<c:forEach var="dto" items="${S1L}" >
					<table class="table table-borderless">
						<tr>
						<td rowspan="5" style="padding-top: 20; padding-left: 20;"><img src="${dto.bi_image}" /></td>
						<td> ${dto.bi_title } </td>
						<td rowspan="5" style="width: 200px; padding-right:30;">
							<p>
							<input type="checkbox">
							&nbsp;수량: <input type="number" value="1" min="1" max="5" size="5">
							</p>
							<button class="btn btn-brown1 m-2">장바구니</button><br>
							<button class="btn btn-brown1 m-2">찜리스트</button></td>
						</tr>
						<tr><td> ${dto.bi_writer } | ${dto.bi_publisher } | ${dto.bi_pdate } </td></tr>
						<tr><td> ${dto.bi_price }원 | ISBN: ${dto.bi_isbn } </td></tr>
						<tr><td> 리뷰 (1 건) | <i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i> (최고의 책!) </td></tr>
						<tr><td> ${dto.bi_content }
						</td></tr>
					</table>
					<hr>
				</c:forEach>					
				</form>
				
				</div>
			</div>
		</div>
	</div>
	
	<!-- 여기서부터 footer -->
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
