<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>orderList.jsp</title>
	<!-- jquery 작성 -->
   <link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- 다음 주소록 API -->
   <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
   
	<script type="text/javascript">
		var totalamount = 0;
		var totalprice = 0;
		
		//주문하기 클릭 시
		function orderClick(){	
				//인풋히든 밸류 조정
				$("#tamount").val(totalamount);
				$("#tprice").val(totalprice);
				
				document.frm.action="order.do";
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
		function postCode(){
				new daum.Postcode(
						{
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
										extraAddr += (extraAddr !== '' ? ', '
												+ data.buildingName : data.buildingName);
									fullAddr += (extraAddr !== '' ? ' (' + extraAddr
											+ ')' : '');
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
<h1>주문정보</h1>
<form name="frm">
	<table style="width: 900px;">
			<tr>
				<th>책제목</th>
				<th>작  가</th>
				<th>출판사</th>
				<th>수  량</th>
				<th>판매가</th>
			</tr>
		<c:forEach var="pk" items="${order}">
			<tr align="center">
			<td>
			<input type="hidden" name="p_bnum" value="${pk.bnum}">
			 ${pk.bi_title}
		    </td>
			<td> ${pk.bi_writer}
			</td>
			<td> ${pk.bi_publisher} </td>
			<td> 
			<input type="hidden" name="p_amount" value="${pk.amount}">
			 ${pk.amount}
			</td>
			<td>
			<input type="hidden" name="p_price" value="${pk.bi_price}">
			 ${pk.bi_price}원 
			</td>
			</tr>
			<script>
					totalamount += ${pk.amount};
					totalprice += ${pk.bi_price};
			</script>
		</c:forEach>
			
			<tr align="right">
	<td colspan="5">
		<h3>주문수량 : <script>document.write(totalamount);</script> 개</h3>
		<input type="hidden" name="tamount" id="tamount">
	</td>
</tr>
<tr align="right">
	<td colspan="5">
		<h3>주문금액 : <script>document.write(totalprice);</script> 원</h3>
		<input type="hidden" name="tprice" id="tprice">
	</td>
</tr>
</table>
<br>
<label>아이디</label><input type="text" name="userid" value="${userid}" readonly><br>
<label>받는사람</label><input type="text" name="receiver" value="${login.name}"><br>
<label>연락처</label>
   <input type="text" name="contact" id="contact" value="${login.phone}">
   <span class="msg"></span>
   <br>
<label>우편번호</label>
   <input type="text" name="postcode" id="zipcode" value="${login.zipcode}" readonly required>
   <input type="button" name="psearch" onclick="postCode()" value="검색"><br>
<label>주소</label><input type="text" name="address1" id="address1" value="${login.address1}" readonly required><br>
<label>상세주소</label><input type="text" name="address2" id="address2" value="${login.address2}"><br>

<input type="button" name="orderOK" onclick="orderClick()" value="주문하기">
<input type="reset" name="reset" value="다시작성">
<input type="button" name="backcite" value="돌아가기" onclick="location.href='pickList.do'">
</form>		

</body>
</html>
