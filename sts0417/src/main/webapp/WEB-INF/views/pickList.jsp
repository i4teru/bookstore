<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>pickList.jsp</title>
<!-- jquery 작성 -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
		}else {return true;}
	}

	$(function() {
		//주문하기 버튼 클릭 시
		$("#order").click(function() {
			if(selectChk()==true){ 
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
		$("#delete").click(function(){
			if(selectChk()==true) checkDel();
		});
	});

	//체크박스 삭제처리
	function checkDel(){
		if(confirm("선택하신 품목을 삭제하시겠습니까?") == true){
			document.frm.action = "checkDel.do";
			document.frm.submit();
		}
	}
</script>


</head>
<body>
	<h1>장바구니</h1>

	<form name="frm">
		<table style="width: 900px;">
			<tr align="right">
				<td colspan="8"><input id="check_all" type="checkbox"><b>전체선택</b></td>
			</tr>
			<tr>
				<th>번  호</th>
				<th>선  택</th>
				<th>이미지</th>
				<th>수  량</th>
				<th>책제목</th>
				<th>작  가</th>
				<th>출판사</th>
				<th>판매가</th>
			</tr>
			<c:forEach var="pk" items="${pick}">
				<tr>
					<td>${pk.rn}<input type="hidden" name="userid" value="${userid}"></td>
					<td><input type="checkbox" name="checkItem" class="checkItem" value="${pk.bnum}"></td>
					<!-- 이미지 클릭시 상세보기 -->
					<td><a href="#"><img src="${pk.bi_image}" style="width:100px; height:100px;"></a></td>
					<td>${pk.amount}<input type="hidden" name="amount" value="${pk.amount}"></td>
					<td>${pk.bi_title}</td>
					<td>${pk.bi_writer}</td>
					<td>${pk.bi_publisher}</td>
					<td>${pk.bi_price}원(정가 ${pk.bi_sprice}원)
					<input type="hidden" name="price" value="${pk.bi_price}">
					</td>
				</tr>
				<script>
					totalamount += ${pk.amount};
					totalprice += ${pk.bi_price};
				</script>
			</c:forEach>

<!-- 
			<tr align="center">
				<td colspan="8"><c:if test="${startpage>5}">
						<a href="pickList.do?pageNum=${startpage-5}">[이전]</a>
					</c:if> <c:forEach var="i" begin="${startpage}" end="${endpage}">
						<c:choose>
							<c:when test="${pageNUM==i}">
								<font style='color: red;'>[${i}]</font>
							</c:when>
							<c:otherwise>
								<a href="pickList.do?pageNum=${i}">[${i}]</a>
							</c:otherwise>
						</c:choose>
					</c:forEach> <c:if test="${endpage<pagecount}">
						<a href="pickList.do?pageNum=${startpage+5}">[다음]</a>
					</c:if></td>
			</tr>
 -->
<tr align="right">
	<td colspan="8"><h3>총수량 : 총 <script>document.write(totalamount);</script> 개</h3></td>
</tr>
<tr align="right">
	<td colspan="8"><h3>총금액 : <script>document.write(totalprice);</script> 원</h3></td>
</tr>			
	
  </table>
		<br> <br> <span> <input type="button" name="order"
			value="구매하기" id="order"> <input type="button" name="delete"
			value="삭제하기" id="delete">
		</span>
	</form>
</body>
</html>
