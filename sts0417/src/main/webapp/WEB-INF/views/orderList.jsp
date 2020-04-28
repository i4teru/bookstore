<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>주문내역</title>
<!-- jquery 작성 -->
<!-- js import -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- 다음 주소록 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
	var totalamount = 0;
	var totalprice = 0;

	//주문하기 클릭 시
	function orderClick() {
		//인풋히든 밸류 조정
		$("#tamount").val(totalamount);
		$("#tprice").val(totalprice);

		document.frm.action = "order.do";
		document.frm.submit();
	}

	//연락처 체크
	//		function contactChk(){
	//			var reg = /[0-9]{3,4}/;
	//			var con = $("#contact");
	//			var flag = true;

	//			if(!reg.test(con1.val())){
	//				alert('abv');
	//				$(".msg").html("숫자를 정확히 입력해주세요");
	//				flag = false; con1.focus();
	//			}
	//			if(flag){
	//				$(".msg").html("");
	//				return true;
	//			}else{
	//				return false;
	//			}
	//		}

	//우편번호 검색(다음 우편번호)
	function postCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var fullAddr = '';
				var extraAddr = '';

				if (data.userSelectedType === 'R')
					fullAddr = data.roadAddress;
				else
					fullAddr = data.jibunAddress;

				if (data.userSelectedType === 'R') {
					if (data.bname !== '')
						extraAddr += data.bname;
					if (data.buildingName !== '')
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
				}

				document.getElementById("zipcode").value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById("address1").value = fullAddr;
				document.getElementById("address2").focus();
			}
		}).open();
		addresschked = true;
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
						<i class="fas fa-clipboard-list text-brown1"></i> 주문내역
					</h2>
				</div>
				<form name="frm">
					<table class="table">
						<tr>
							<th>이미지</th>
							<th>책제목</th>
							<th>작 가</th>
							<th>출판사</th>
							<th>수 량</th>
							<th>판매가</th>
						</tr>
						<c:forEach var="pk" items="${order}">
							<tr align="center">

								<td class="align-middle"><a href="#"><img src="${pk.bi_image}" style="max-height: 150px"></a></td>
								<td class="align-middle"><input type="hidden" name="p_bnum" value="${pk.bnum}"> ${pk.bi_title}</td>
								<td class="align-middle">${pk.bi_writer}</td>
								<td class="align-middle">${pk.bi_publisher}</td>
								<td class="align-middle"><input type="hidden" name="p_amount" value="${pk.amount}"> ${pk.amount}</td>
								<td class="align-middle"><input type="hidden" name="p_price" value="${pk.bi_sprice}"> <small class="text-brown2"><del>${pk.bi_price}원</del></small><br>${pk.bi_sprice}원</td>
							</tr>
							<script>
								totalamount += ${pk.amount};
								totalprice += ${pk.bi_sprice};
							</script>
						</c:forEach>

						<tr align="right">
							<td colspan="6">주문수량 : <script>
								document.write(totalamount);
							</script> 개 <br> 주문금액 : <script>
										document.write(totalprice);
									</script> 원 <input type="hidden" name="tprice" id="tprice"> <input type="hidden" name="tamount" id="tamount">
							</td>
						</tr>
					</table>





					<input type="hidden" class="form-control" name="userid" id="userid" value="${ userid }" required>
					<table class="table table-borderless">
						<tr>
						<tr>
							<td>이름</td>
							<td>
								<div class="input-group" style="max-width: 300px">
									<input type="text" class="form-control " name="receiver" id="receiver" value="${login.name}" required>
								</div>
								<div id="idchk"></div>
							</td>
						</tr>

						<tr>
							<td>연락처</td>
							<td>

								<div class="input-group " style="max-width: 300px">
									<input type="text" class="form-control " name="contact" id="contact" value="${login.phone }" placeholder="ex) 010-xxxx-xxxx" required>
								</div>

								<div id="phonechk"></div>
							</td>
						</tr>
						<tr>
							<td>우편번호</td>
							<td>

								<div class="input-group " style="max-width: 250px">
									<input type="text" class="form-control " name="postcode" id="postcode" value="${login.zipcode }" readonly required>
									<div class="input-group-append">
										<input class="btn btn-brown1" type="button" onclick="postCode()" value="우편번호 검색">
									</div>
								</div>

							</td>
						</tr>
						<tr>
							<td>주소</td>
							<td>

								<div class="input-group " style="max-width: 500px">
									<input type="text" class="form-control " name="address1" id="address1"  value="${login.address1 }" readonly required>
								</div>

							</td>
						</tr>
						<tr>
							<td>상세주소</td>
							<td>

								<div class="input-group " style="max-width: 500px">
									<input type="text" class="form-control " name="address2" id="address2" value="${login.address2 }" required>
								</div>

								<div id="addresschk"></div>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="acenter p-5"><input style="height:50px;width:150px" class="btn btn-brown1" type="button" name="orderOK" onclick="orderClick()" value="주문하기"> <input style="height:50px" class="btn btn-secondary" type="button" name="backcite" value="돌아가기" onclick="location.href='pickList.do'"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
