<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<title>로그인</title>
<!-- js import -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<style type="text/css">
</style>

<script>
	//총금액, 총합계 변수
	var totalprice = 0;
	var totalamount = 0;

	//체크박스 선택여부 검사	
	function selectChk() {
		var selectedCheck = new Array();

		$(".checkItem:checked").each(function() {
			selectedCheck.push($(this).val());
		});

		if (selectedCheck.length < 1) {
			alert("최소 1개 이상의 항목을 선택하세요");
			return false;
		} else {
			return true;
		}
	}

	$(function() {
		//주문하기 버튼 클릭 시
		$("#order").click(function() {
			if (selectChk() == true) {
				document.frm.action = "orderList.do";
				document.frm.submit();
			}
		});

		//체크박스 전체선택
		$("#check_all").click(function() {
			var chk = $(this).is(":checked");

			if (chk)
				$(".checkItem").prop('checked', true);
			else
				$(".checkItem").prop('checked', false);
		});

		//삭제하기 버튼 클릭 시
		$("#delete").click(function() {
			if (selectChk() == true)
				checkDel();
		});
	});

	//체크박스 삭제처리
	function checkDel() {
		if (confirm("선택하신 품목을 삭제하시겠습니까?") == true) {
			document.frm.action = "checkDel.do";
			document.frm.submit();
		}
	}
</script>


</head>
<body>
	<c:import url="/header.do"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="fas fa-shopping-cart text-brown1"></i> 장바구니
					</h2>
				</div>
				<form name="frm">
					<table class="table">
						<tr>
							<td colspan="8" class="aright"><input id="check_all" type="checkbox"><b>전체선택</b></td>
						</tr>
						<tr>
							<th>번 호</th>
							<th>선 택</th>
							<th>이미지</th>
							<th>수 량</th>
							<th>책제목</th>
							<th>작 가</th>
							<th>출판사</th>
							<th>판매가</th>
						</tr>
						<c:forEach var="pk" items="${pick}">
							<tr class="acenter align-middle">
								<td class="align-middle">${pk.rn}<input type="hidden" name="userid" value="${userid}"></td>
								<td class="align-middle"><input type="checkbox" name="checkItem" class="checkItem" value="${pk.bnum}"></td>
								<!-- 이미지 클릭시 상세보기 -->
								<td class="align-middle"><a href="#"><img src="${pk.bi_image}" style="max-height:150px"></a></td>
								<td class="align-middle">${pk.amount}<input type="hidden" name="amount" value="${pk.amount}"></td>
								<td class="align-middle">${pk.bi_title}</td>
								<td class="align-middle">${pk.bi_writer}</td>
								<td class="align-middle">${pk.bi_publisher}</td>
								<td class="align-middle"><small class="text-brown2"><del>${pk.bi_price}원</del></small><br>${pk.bi_sprice}원<input type="hidden" name="price" value="${pk.bi_price}">
								</td>
							</tr>
							<script>
								totalamount += ${pk.amount};
								totalprice += ${pk.bi_sprice};
							</script>
						</c:forEach>
						<c:if test="${fn:length(pick)==0}">
							<tr>
								<td class="p-5 acenter" colspan="8"><p class="p-5">장바구니 항목이 없습니다.</p></td>

							</tr>
						</c:if>

						<tr align="right">
							<td colspan="8">수량 : 총 <script>
								document.write(totalamount);
							</script>개
							</td>
						</tr>
						<tr align="right">
							<td colspan="8">금액 : 총 <script>
								document.write(totalprice);
							</script>원
							</td>
						</tr>
						<tr>
							<td colspan="8" class="acenter pt-5 pb-3"><button class="btn btn-brown1" id="order" type="button" style="width: 200px; height: 50px;">주문</button>
								<button class="btn btn-danger" type="button" style="width: 100px; height: 50px;" id="delete">삭제</button></td>

						</tr>

					</table>

				</form>
			</div>
		</div>
	</div>
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
