<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>섹션별 리스트</title>
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

<script type="text/javascript">
function addToCart(num){
	var id = "addform"+num;
	document.getElementById(id).submit();
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
					<tr><td><h3>
					<c:choose>
						<c:when test="${scnum eq '1' }"><i class="fas fa-mobile-alt text-brown1"></i> 모바일/임베디드 </c:when>
						<c:when test="${scnum eq '2' }"><i class="fas fa-object-group text-brown1"></i> 웹 디자인</c:when>
						<c:when test="${scnum eq '3' }"><i class="fas fa-keyboard text-brown1"></i> 프로그래밍 언어</c:when>
						<c:when test="${scnum eq '4' }"><i class="fas fa-database text-brown1"></i> 데이터베이스</c:when>
						<c:when test="${scnum eq '5' }"><i class="fas fa-desktop text-brown1"></i> 웹 서비스 개발</c:when>
						<c:when test="${scnum eq '6' }"><i class="fas fa-search text-brown1"></i> 검색 결과</c:when>
						<c:otherwise> ERROR PAGE </c:otherwise>
					</c:choose>
					</h3><hr></td></tr>
					<tr><td> &nbsp; 총 ${STotal}권의 상품이 등록되어 있습니다. </td></tr>
					<tr>
						<td> 
							<ul class="breadcrumb justify-content-center">
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=publish_desc">출간일순</a></li>
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=price_asc">최저가순</a></li>
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=sales_desc">판매량순</a></li>
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=points_desc">평점순</a></li>
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=reviews_desc">리뷰순</a></li>
							</ul>
						</td></tr>
					<tr>
						<td>
							<div class="pagination justify-content-center">
							  <c:if test="${pagestart ne 1 }">
							  <a href="bookSection.do?scnum=${scnum }&page=${page-6 }&sort=${sort}">&laquo;</a>
							  </c:if>
							  <c:forEach begin="${pagestart }" end="${pageend }" var="p">
							  	<c:choose>
								  	<c:when test="${page eq p }">
								  		<a href="bookSection.do?scnum=${scnum }&page=${p }&sort=${sort}" class="active">${p }</a>
								  	</c:when>
								  	<c:otherwise>
								  		<a href="bookSection.do?scnum=${scnum }&page=${p }&sort=${sort}">${p }</a>
								  	</c:otherwise>
							  	</c:choose>
							  </c:forEach>
							  <c:if test="${pageend < pagecount }">
							  <a href="bookSection.do?scnum=${scnum }&page=${page+6 }&sort=${sort}">&raquo;</a>
							  </c:if>
							</div>
						</td>
					</tr>
					<tr class="space">
						<td class="right">
						<button type="button" class="btn btn-outline-dark btn-sm" id="checkAllBtn" onclick="selectAll();"> 전체선택 </button>
						<button type="button" class="btn btn-outline-dark btn-sm" onclick=""> 장바구니 </button>
						<button type="button" class="btn btn-outline-dark btn-sm" onclick=""> 찜리스트 </button>
						</td>
					</tr>
				</table>
			</div>

			<!-- 도서 리스트 출력되는 영역(10권씩) -->
			<div class="row justify-content-center">
				<div class="col-12">				
				
				<c:forEach var="dto" items="${SL}" >
					<form id="addform${dto.bi_num }" action="pickInsert.do?idx=${dto.bi_isbn}&nidx=${dto.bi_num}&sidx=${dto.bi_status}" method="post">
					<table class="table table-borderless">
						<tr>
						<td rowspan="5" style="padding-top: 20; padding-left: 20;"><a href="bookdetail.do?idx=${dto.bi_num}"><img src="${dto.bi_image}" /></a></td>
						<td id="title${bi_num}"> ${dto.bi_title } </td>
						<td rowspan="5" style="width: 200px; padding-right:30;">
							<p>
							<input type="checkbox" name="bnum" value="${dto.bi_num }">
							&nbsp;수량: <input type="number" name="amount" value="1" min="1" max="10" size="5">
							</p>
							<button type="button" class="btn btn-brown1 m-2" data-toggle="modal" data-target="#myModal${dto.bi_num }">장바구니</button><br>
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
					
				<!-- Bootstrap Modal -->
				<div class="modal" id="myModal${dto.bi_num }">
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
								<button type="button" class="btn btn-brown1" onclick="addToCart(${dto.bi_num});">확인</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
							</div>

						</div>
					</div>
				</div>
					</form>
					<hr>
				</c:forEach>					
				
				
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- 여기서부터 footer -->
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
