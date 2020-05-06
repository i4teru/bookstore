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

<script>
//전체선택 버튼을 눌렀을 때 모든 체크박스 체크, 전체해제 버튼을 눌렀을 때 모든 체크박스 체크 해제
$(document).ready(function(){
	$("#checkAllBtn").on("click", function(){
		if($(this).html() == '전체선택'){
			$("input:checkbox[name='chkbox']").prop("checked", true);
			$(this).html('전체해제');
		} else {
			$("input:checkbox[name='chkbox']").prop("checked", false);
			$(this).html('전체선택');
		}		
	});	
});

//각 아이템 옆의 장바구니 버튼을 클릭했을 때 선택된 수량만큼 장바구니에 넣기 
function addToCart(num){
	var id = "addform"+num;
	document.getElementById(id).submit();
}

//상단 전체선택(전체해제) 옆 장바구니 버튼을 누르면 선택된 항목만 장바구니에 추가될 수 있도록
function multiInsert(){
	var selectedItems = new Array;
	var jasonAry;
	var cnt = 0;
	$("input:checkbox[name='chkbox']").each(function(){
		if($(this).is(":checked")){
			//alert($(this).val());
			selectedItems.push($(this).val());
		} else cnt++;
	});
	if(cnt==10) {
		alert("선택된 아이템이 없습니다.");
		return false;
	} else { //배열을 JSON형식으로 
		jsonAry=toJson(selectedItems);
	}

	$.ajax({ //JSON array를 컨트롤러로 보냄
		url: "multiInsert.do",
		type: "post",
		data: JSON.stringify(jsonAry),
		dataType: "json",
		contentType: "application/json",
	});
	//현재 페이지에 남아있을지 장바구니로 이동할지 알림창 open
	 $("#cartModal").modal("show");
	//location.href="pickList.do";
}

//checkbox에 선택된 배열 형식의 값을 JSON형식으로 바꾸는 함수
function toJson(arr){
	var len = arr.length;
	var jsonArr = [];
	
	for(var i=0;i<len;i++){
		var arrData = {bnum:"", isbn:"", status:""};
		var arrIdx = 0;
		for(var key in arrData){
			var value = arr[i].split('&')[arrIdx];
			arrData[key] = value;
			arrIdx++;
			console.log("key="+key+"/value="+value);
		}//loop end
		if(arrData.bnum){ //빈 배열을 전송하는 것을 방지
			jsonArr[i] = arrData;
		}
	}//for문 end
	return jsonArr;	
}

</script>

</head>
<body>
   
	<!-- 헤더 영역 -->
	<c:import url="/header.do"></c:import>

	<!-- 리스트 메인 -->
	<div class="container-fluid bg-lightgray pt-3 pb-3">
		<div class="container">

			<!-- 센션타이틀/섹션total/정렬옵션/페이징/전체선택 및 선택된 아이템 장바구니 넣기 버튼-->
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
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=publish_desc&query=${query}">출간일순</a></li>
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=price_asc&query=${query}">최저가순</a></li>
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=sales_desc&query=${query}">판매량순</a></li>
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=points_desc&query=${query}">평점순</a></li>
							  <li><a href="bookSection.do?scnum=${scnum }&page=&sort=reviews_desc&query=${query}">리뷰순</a></li>
							</ul>
						</td></tr>
					<tr>
						<td>
							<div class="pagination justify-content-center">
							  <c:if test="${pagestart ne 1 }">
							  <a href="bookSection.do?scnum=${scnum }&page=${page-6 }&sort=${sort}&query=${query}">&laquo;</a>
							  </c:if>
							  <c:forEach begin="${pagestart }" end="${pageend }" var="p">
							  	<c:choose>
								  	<c:when test="${page eq p }">
								  		<a href="bookSection.do?scnum=${scnum }&page=${p }&sort=${sort}&query=${query}" class="active">${p }</a>
								  	</c:when>
								  	<c:otherwise>
								  		<a href="bookSection.do?scnum=${scnum }&page=${p }&sort=${sort}&query=${query}">${p }</a>
								  	</c:otherwise>
							  	</c:choose>
							  </c:forEach>
							  <c:if test="${pageend < pagecount }">
							  <a href="bookSection.do?scnum=${scnum }&page=${page+6 }&sort=${sort}&query=${query}">&raquo;</a>
							  </c:if>
							</div>
						</td>
					</tr>
					<tr class="space">
						<td class="right">
						<button type="button" class="btn btn-outline-dark btn-sm" id="checkAllBtn"> 전체선택 </button>
						<button type="button" class="btn btn-outline-dark btn-sm" onclick="multiInsert();"> 장바구니 </button>
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
							<input type="checkbox" name="chkbox" class="chkbox" value="${dto.bi_num }&${dto.bi_isbn}&${dto.bi_status}">
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
			
			<!-- Modal -->
			<div class="modal fade" id="cartModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h4 class="modal-title" id="myModalLabel">장바구니에 담겼습니다.</h4>
			      	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
			      </div>
			      <div class="modal-body">
			         	쇼핑을 계속하시려면 '쇼핑 계속'을, 장바구니로 이동하시려면 '장바구니로' 버튼을 누르세요.
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-dark" data-dismiss="modal">쇼핑 계속</button>
			        <button type="button" class="btn btn-brown1" onclick="location.href='pickList.do'">장바구니로</button>
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
