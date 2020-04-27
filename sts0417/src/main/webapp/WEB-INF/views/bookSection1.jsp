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
<script
  src="https://code.jquery.com/jquery-3.5.0.js"
  integrity="sha256-r/AaFHrszJtwpe+tHyNi/XCfMxYpbsRg2Uqn0x3s2zc="
  crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

<script>
$(document).ready(function(){
	$("#checkAllBtn").on("click", function(){
		alert("좀 되라..");
});
</script>

<script type="text/javascript">
function addToCart(){
	alert("되나 안되나 확인");
	$("#addform").submit();
}
</script>

</head>
<body>
   
	<!-- 헤더 영역 -->
	<c:import url="/header.do"></c:import>

	<!-- 리스트 메인 -->
	<div class="container-fluid bg-lightgray pt-3 pb-3">
		<div class="container">

			<!-- 센션타이틀/섹션total/정렬옵션/페이징/전체선택 및 전체장바구니 버튼-->
			<div class="mt-1">
				<table class="w-100 noppading nomargin">
					<tr><td><h3><i class="fas fa-mobile-alt text-brown1"></i> 모바일/임베디드</h3><hr></td></tr>
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
						<button type="button" class="btn btn-outline-dark btn-sm" id="checkAllBtn" onclick=""> 전체선택 </button>
						<button type="button" class="btn btn-outline-dark btn-sm" onclick=""> 장바구니 </button>
						<button type="button" class="btn btn-outline-dark btn-sm" onclick=""> 찜리스트 </button>
						</td>
					</tr>
				</table>
			</div>

			<!-- 도서 리스트 출력되는 영역(10권씩) -->
			<div class="row justify-content-center">
				<div class="col-12">				
				
				<c:forEach var="dto" items="${S1L}" >
					<form id="addform" action="pickInsert.do?idx=${dto.bi_isbn}&nidx=${dto.bi_num}&sidx=${dto.bi_status}" method="get">
					<table class="table table-borderless">
						<tr>
						<td rowspan="5" style="padding-top: 20; padding-left: 20;"><a href="bookdetail.do?idx=${dto.bi_num}"><img src="${dto.bi_image}" /></a></td>
						<td id="title"+${bi_num}> ${dto.bi_title } </td>
						<td rowspan="5" style="width: 200px; padding-right:30;">
							<p>
							<input type="checkbox" class="checkItem" value="${dto.bi_num }">
							&nbsp;수량: <input type="number" name="amount" value="1" min="1" max="10" size="5">
							</p>
							<button type="button" class="btn btn-brown1 m-2" data-toggle="modal" data-target="#myModal">장바구니</button><br>
							<button class="btn btn-brown1 m-2">찜리스트</button></td>
						</tr>
						<tr><td> ${dto.bi_writer } | ${dto.bi_publisher } | ${dto.bi_pdate } </td></tr>
						<tr><td> ${dto.bi_cprice }원 | ISBN: ${dto.bi_isbn } </td></tr>
						<tr><td> 리뷰 (${dto.rcnt } 건) |						
								 <c:if test="${dto.avpnt eq 0 }">
								 	<c:forEach begin="1" end="5"><i class="far fa-star text-danger"></i></c:forEach>
								 </c:if>
								 <c:if test="${dto.avpnt gt 0 and dto.avpnt lt 1 }">
								 	<i class="fas fa-star-half-alt text-danger"></i>
								 	<c:forEach begin="2" end="5"><i class="far fa-star text-danger"></i></c:forEach>
								 </c:if>
								 <c:if test="${dto.avpnt eq 1 }">
								 	<i class="fas fa-star text-danger"></i>
								 	<c:forEach begin="2" end="5"><i class="far fa-star text-danger"></i></c:forEach>
								 </c:if>
								 <c:if test="${dto.avpnt gt 1 and dto.avpnt lt 2 }">
								 	<i class="fas fa-star text-danger"></i>
								 	<i class="fas fa-star-half-alt text-danger"></i>
								 	<c:forEach begin="3" end="5"><i class="far fa-star text-danger"></i></c:forEach>
								 </c:if>
								 <c:if test="${dto.avpnt eq 2 }">
								 	<c:forEach begin="1" end="2"><i class="fas fa-star text-danger"></i></c:forEach>
								 	<c:forEach begin="3" end="5"><i class="far fa-star text-danger"></i></c:forEach>
								 </c:if>
								 <c:if test="${dto.avpnt gt 2 and dto.avpnt lt 3 }">
								 	<c:forEach begin="1" end="2"><i class="fas fa-star text-danger"></i></c:forEach>
								 	<i class="fas fa-star-half-alt text-danger"></i>
								 	<c:forEach begin="4" end="5"><i class="far fa-star text-danger"></i></c:forEach>
								 </c:if>
								 <c:if test="${dto.avpnt eq 3 }">
								 	<c:forEach begin="1" end="3"><i class="fas fa-star text-danger"></i></c:forEach>
								 	<c:forEach begin="4" end="5"><i class="far fa-star text-danger"></i></c:forEach>
								 </c:if>
								 <c:if test="${dto.avpnt gt 3 and dto.avpnt lt 4 }">
								 	<c:forEach begin="1" end="3"><i class="fas fa-star text-danger"></i></c:forEach>
								 	<i class="fas fa-star-half-alt text-danger"></i>
								 	<i class="far fa-star text-danger"></i>
								 </c:if>
								 <c:if test="${dto.avpnt eq 4 }">
								 	<c:forEach begin="1" end="4"><i class="fas fa-star text-danger"></i></c:forEach>
								 	<i class="far fa-star text-danger"></i>
								 </c:if>
								  <c:if test="${dto.avpnt gt 4 and dto.avpnt lt 5 }">
								 	<c:forEach begin="1" end="4"><i class="fas fa-star text-danger"></i></c:forEach>
								 	<i class="fas fa-star-half-alt text-danger"></i>
								 </c:if>
								 <c:if test="${dto.avpnt eq 5 }">
								 	<c:forEach begin="1" end="5"><i class="fas fa-star text-danger"></i></c:forEach>
								 </c:if>	 
								 <c:if test="${dto.avpnt>0 }"> (평균 ${dto.avpnt } 점) </c:if></td></tr>
						<tr><td> ${dto.bi_content }
						</td></tr>
					</table>
					</form>
					<hr>
				</c:forEach>					
				
				
				</div>
			</div>
			
				<!-- Bootstrap Modal -->
				<div class="modal" id="myModal">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title"> 장바구니에 저장하시겠습니까?</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">저장 후 장바구니로 이동하려면 '확인'을, <br>취소하려면 '닫기'를 누르세요. </div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" class="btn btn-brown1" onclick="addToCart();">확인</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
							</div>

						</div>
					</div>
				</div>
			
		</div>
	</div>
	
	<!-- 여기서부터 footer -->
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
