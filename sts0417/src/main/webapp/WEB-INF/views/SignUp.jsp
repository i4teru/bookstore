<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- 다음 주소록 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
</style>
<script>
	var idchk = false;
	var pwd = false;
	var addresschked = false;

	//아이디 중복체크
	$(function() {
		$('#check').click(function() {
			if ($("#id").val() == "" || $("#id").val() == null) {
				$("#idchk").html("아이디를 입력하십시오.");
				idchk = false;
			} else {
				$.ajax({
					"url" : "idcheck.do",
					"data" : {
						userid : $('#id').val()
					},
					"type" : "get",
					"success" : function(data) {
						console.log(data.trim());
						if (data.trim() == "O") {
							$("#idchk").html("사용가능한 아이디입니다.");
							idchk = true;
						} else {
							$('#idchk').html("이미사용중인 아이디 입니다.");
							idchk = false;
						}
					},
					"error" : function(data) {
						alert("에러" + data);
					}
				});
			}
		});
	});

	//비밀번호 체크
	$(function() {
		$('#pwd').on('keypress keydown keyup focusout', function() {
			var p = $('#pwd').val();
			var pc = $('#pwdc').val();

			if (p == null || p == "") {
				$('#pwdchk').html("비밀번호가 공백입니다");
				pwd = false;
			}
			if (p.length > 20 || p.length<8||pc.length>20 || pc.length < 8) {
				$('#pwdchk').html("비밀번호가 형식에 맞지 않습니다.");
				pwd = false;
			}
			if (p != pc) {
				$('#pwdchk').html("비밀번호가 일치하지 않습니다.");
				pwd = false;
			}
		});
		$('#pwdc').on('keypress keydown keyup focusout', function() {
			var p = $('#pwd').val();
			var pc = $('#pwdc').val();
			if (p == pc) {
				$('#pwdchk').html("");
				pwd = true;
			} else {
				$('#pwdchk').html("비밀번호가 일치하지 않습니다.");
				pwd = false;
			}
			if (p.length > 20 || p.length<8||pc.length>20 || pc.length < 8) {
				$('#pwdchk').html("비밀번호가 형식에 맞지 않습니다.");
				pwd = false;
			}
		});
	});

	//다음 우편번호
	function postCode() {
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
						//document.getElementById("jusocode").value = data.postcode;
						document.getElementById("address1").value = fullAddr;
						document.getElementById("address2").focus();
					}
				}).open();
		addresschked = true;
	}

	//이름 입력
	function nameCheck() {
		var txt = $("#name");

		if (txt.val().length == 0) {
			$("#namechk").text("이름을 입력해주세요.");
			return false;
		} else {
			$("#namechk").text("");
			return true;
		}
	}

	//생일 입력
	function birthCheck() {
		var txt = $("#birthday");

		if (txt.val().length == 0) {
			$("#birthchk").text("생년월일을 입력해주세요.");
			return false;
		} else {
			$("#birthchk").text("");
			return true;
		}
	}
	
	//아이디 유효성 검사
	function idCheck() {
		if (!idchk) {
			$("#idchk").text("아이디 중복여부를 확인해주세요.");
			return false;
		} else {
			$("#idchk").text("");
			return true;
		}
	}

	//이메일 유효성 검사
	function emailCheck() {
		var txt = $("#email");
		var msg = $("#emailchk");
		var reg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		if (!reg.test(txt.val())) {
			msg.text("올바르지 않은 형식입니다.");
			txt.focus();
			return false;
		} else if (txt.val().length == 0) {
			msg.text("이메일을 입력해주세요.");
			txt.focus();
			return false;
		} else {
			msg.text("");
			return true;
		}
	}

	//연락처 유효성 검사
	function phoneCheck() {
		var phone = $("#phone")
		var reg = /^\d{3}-\d{3,4}-\d{4}$/;
		;
		var flag = true;

		if (!reg.test(phone.val())) {
			flag = false;
			phone.focus();
		}
		if (flag) {
			$("#phonechk").text("");
			return true;
		} else {
			$("#phonechk").text("유효하지 않은 전화번호 입니다.");
		}
	}

	//주소 유효성 검사
	function addressCheck() {
		var zip = $("#zipcode");
		var txt = $("#address2");
		var msg = $("#addresschk");
		
		if (!addresschked) {
			msg.text("우편번호를 검색해서 주소를 입력하세요.");
			return false;
		} else if (zip.val().length == 0||txt.val().length == 0) {
			msg.text("상세주소를 입력하세요.");
			return false;

		} else {
			msg.text("");
			return true;
		}
	}

	//전체 유효성 검사
	function Checked() {
		if (nameCheck() && idCheck() && pwd && emailCheck() && phoneCheck() && birthCheck() && addressCheck()) {
			loginform.submit();
		}
	}
	
</script>

</head>

<body>
	<c:import url="header.jsp"></c:import>
	<form name="loginform" action="signupcomplete.do">
		<div class="container">
			<table class="table table-borderless table-sm">
				<tbody>
					<tr>
						<td>이름</td>
						<td>
							<div class="form-group" style="width: 300px">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control form-control-sm" name="name" id="name" value="이름" required>
								</div>
							</div>
							<div id="namechk"></div>
						</td>
					</tr>
					<tr>
						<td>아이디</td>
						<td>
							<div class="form-group" style="width: 300px">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control form-control-sm" name="id" id="id" value="aaa" required> <input class="btn btn-sm" type="button" value="중복확인" id="check">
								</div>
							</div>
							<div id="idchk"></div>
						</td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td>
							<div class="form-group" style="width: 300px;">
								<div class="input-group input-group-sm">
									<input type="password" class="form-control form-control-sm" name="password" id="pwd" value="12345678" placeholder="8~20자리" required>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>패스워드 확인</td>
						<td>
							<div class="form-group" style="width: 300px;">
								<div class="input-group input-group-sm">
									<input type="password" class="form-control form-control-sm" id="pwdc" value="12345678" placeholder="비밀번호를 다시 입력하십시오" required>
								</div>
							</div>
							<div id="pwdchk"></div>
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<div class="form-group" style="width: 200px;">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control form-control-sm" name="email" id="email" value="xxx@xxx.com" placeholder="ex) xxx@xxx.com" pattern="[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z]"
										required>
								</div>
							</div>
							<div id="emailchk"></div>
						</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>
							<div class="form-group" style="width: 150px;">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control form-control-sm" name="phone" id="phone" value="010-1234-1234" placeholder="ex) 010-xxxx-xxxx" required>
								</div>
							</div>
							<div id="phonechk"></div>
						</td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td>
							<div class="form-group" style="width: 150px;">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control form-control-sm" name="birthday" id="birthday" required>
								</div>
							</div>
							<div id="birthchk"></div>
						</td>
					</tr>
					<tr>
						<td>성별</td>
						<td>
							<div class="form-group" style="width: 150px;">
								<div class="input-group input-group-sm">
									<label for="gender1"><input type="radio" name="gender" value="1" id="gender1" checked="checked">남</label>
									<label for="gender0"><input type="radio" name="gender" value="0" id="gender0">여</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>우편번호</td>
						<td>
							<div class="form-group" style="width: 200px;">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control form-control-sm" name="zipcode" id="zipcode" readonly required> <input class="btn btn-sm" type="button" onclick="postCode()" value="우편번호 검색">
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>
							<div class="form-group" style="width: 200px;">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control form-control-sm" name="address1" id="address1" readonly required>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td>
							<div class="form-group" style="width: 200px;">
								<div class="input-group input-group-sm">
									<input type="text" class="form-control form-control-sm" name="address2" id="address2" value=".apt 402호" required>
								</div>
							</div>
							<div id="addresschk"></div>
						</td>
					</tr>
					<tr>
						<td><input class="btn bg-hurry" id="btnJoin" type="button" style="margin: 30px; width: 200px; height: 50px;" value="회원가입" onclick="Checked()"></td>
						<td><input class="btn bg-hurry" id="btnJoin" type="button" style="margin: 30px; width: 200px; height: 50px;" value="취소" onclick="history.back()"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>


</body>
</html>