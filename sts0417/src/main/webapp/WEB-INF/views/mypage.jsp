<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>mypage</title>
<!-- 다음 주소록 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	//다음 우편번호
function postCode() {
	new daum.Postcode({oncomplete : function(data) {
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
			//document.getElementById("jusocode").value = data.postcode;
			document.getElementById("address1").value = fullAddr;
			document.getElementById("address2").focus();
		}
	}).open();
}

$(function() {
	$("#edit").click(function() {
		$("#edittable").html(
			"<div class='container'>"
				+ "<form id='editform' action='editaccount.do'>"
				+ "<table class='table table-borderless table-sm'>"
				+ "<tr><td>개인정보 수정</td></tr>"
				+ "<tr><td>아이디</td><td><div class='form-group' style='width: 300px'><div class='input-group input-group-sm'>${id}<input type='hidden' name='id' class='form-control form-control-sm'  value=${id}></div></div></td></tr>"
				+ "<tr><td>이름</td><td><div class='form-group' style='width: 300px'><div class='input-group input-group-sm'><input type='text' name='name' class='form-control form-control-sm' value='${dto.name}'></td></tr>"
				+ "<tr><td>이메일</td><td><div class='form-group' style='width: 300px'><div class='input-group input-group-sm'><input type='text' name='email' class='form-control form-control-sm' value='${dto.email}'</td></tr>"
				+ "<tr><td>전화번호</td><td><div class='form-group' style='width: 300px'><div class='input-group input-group-sm'><input type='text' name='phone' class='form-control form-control-sm' value='${dto.phone}'</td></tr>"
				+ "<tr><td>생년월일</td><td><div class='form-group' style='width: 300px'><div class='input-group input-group-sm'><input type='text' name='birthday' class='form-control form-control-sm' value='${dto.birthday}'</td></tr>"
				+ "<tr><td>배송지</td><td><div class='form-group' style='width: 300px'><div class='input-group input-group-sm'><input type='text' name='zipcode' id='zipcode' class='form-control form-control-sm' readonly value='${dto.zipcode}'</td><td><input class='btn btn-sm' type='button' onclick='postCode()' value='우편번호 검색'></td></tr>"
				+ "<tr><td><td><div class='form-group' style='width: 300px'><div class='input-group input-group-sm'><input type='text' name='address1' id='address1' class='form-control form-control-sm' readonly value='${dto.address1}'</td></td><td><input type='text' name='address2' id='address2' class='form-control form-control-sm' value='${dto.address2}'></td></tr>"
				+ "<tr><td>회원등급: </td><td>${dto.grade}</td> </tr>"
				+ "<tr><td><input type='submit' class='btn bg-hurry' value='저장'></td><td><input type='button' class='btn bg-hurry' onclick='location.reload()' value='취소'</td></tr>"
				+ "</table></form>");
	})
})
</script>

</head>
<body>
	<c:import url="header.jsp"></c:import>
	<div class="container">
		<div id="edittable">
			<table class="table table-borderless table-sm">
				<tr>
					<td>
						<div class="form-group" style="width: 300px">
							<div class="input-group input-group-sm">아이디: ${id}</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group" style="width: 300px">
							<div class="input-group input-group-sm">이름: ${dto.name}</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group" style="width: 300px">
							<div class="input-group input-group-sm">이메일: ${dto.email}</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group" style="width: 300px">
							<div class="input-group input-group-sm">전화번호: ${dto.phone}</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group" style="width: 300px">
							<div class="input-group input-group-sm">생년월일: ${dto.birthday}</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group" style="width: 300px">
							<div class="input-group input-group-sm">배송지: ${dto.zipcode}
								${dto.address1}${dto.address2}</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group" style="width: 300px">
							<div class="input-group input-group-sm">회원등급 : ${dto.grade}</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<hr>
		<div id="edittable">
			<table class="table table-borderless table-sm">
				<tr>
					<td>구매내역</td>
				</tr>
				<c:forEach var="i" begin="1" end="5" step="1">
					<tr>
						<td>
							<div class="form-group" style="width: 300px">
								<div class="input-group input-group-sm">상품: ${i}</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-group" style="width: 300px">
								<div class="input-group input-group-sm">가격 ${i*10000}</div>
							</div>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<hr>
		<button class="btn bg-hurry" id="edit">수정</button>
		<button class="btn bg-hurry" onclick="location.href='login_head.do'">뒤로가기</button>
	</div>

</body>
</html>
