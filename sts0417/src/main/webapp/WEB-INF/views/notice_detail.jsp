<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>notice_detail</title>
</head>

<!-- js import -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<script>
	$(function() {

		$("#btnedit").click(function() {
			$("#editform").css("display", "block");
			$("#content").css("display", "none");
		});

		$("#btneditcancel").click(function(){
			$("#editform").css("display", "none");
			$("#content").css("display", "block");

		});
	});
</script>


<body>
	<c:import url="/header.do"></c:import>
	<div class="container-fluid bg-lightgray">
		<div class="container pt-5 pb-5">
			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="fas fa-bullhorn text-brown1"></i> 공지사항
					</h2>
				</div>
				<div id="editform" style="display:none">
					<form action="notice_edit.do">
						<input type="hidden" name="notice_num" value="${dto.notice_num}">
						<table class="table table-borderless" style="margin: auto; width: 100%">

							<tr>
								<td><input type="text" class="form-control" name="notice_title" value='${dto.notice_title}'></td>
								<td class="acenter">${dto.upload_date}</td>
							</tr>
							<tr>
								<td colspan="2"><textarea rows="10" cols="30" class="form-control" name="notice_content">${dto.notice_content}</textarea>
								<td>
							</tr>
							<tr>
								<td colspan="2" class="acenter">
									<button type="submit" class="btn btn-brown1" name="btn">수정</button>
									<button type="button" class="btn btn-secondary" id="btneditcancel">취소</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div id="content">
					<table class="table">
						<tr>
							<td><span class="text-brown1"><b>${dto.notice_title}</b></span></td>
							<td class="aright"><span class="text-darkgray">${dto.upload_date}</span></td>
						</tr>
						<tr>
							<td colspan="2" class="pb-5 pt-5">${dto.notice_content}</td>
						</tr>
						<tr>
							<td colspan="2" class="aright">
								<button type="button" class="btn btn-brown1" onclick="location.href='notice.do'">
									<i class="fas fa-list"></i> 목록
								</button> <!-- 관리자에게만 수정버튼 노출 --> <c:if test="${usergrade==0}">
									<button type="button" class="btn btn-info" id="btnedit">수정</button>
									<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteCheck">삭제</button>
									<!-- 삭제확인창 -->
									<div class="modal" id="deleteCheck">
										<div class="modal-dialog">
											<div class="modal-content">

												<!-- Modal Header -->
												<div class="modal-header">
													<h4 class="modal-title">삭제 확인</h4>
													<button type="button" class="close" data-dismiss="modal">&times;</button>
												</div>

												<!-- Modal body -->
												<div class="modal-body acenter">
													<h5>정말 삭제하시겠습니까?</h5>
												</div>

												<!-- Modal footer -->
												<div class="modal-footer">
													<button type="button" class="btn btn-danger" onclick="location.href='notice_delete.do?num=${dto.notice_num}'">삭제</button>
													<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
												</div>

											</div>
										</div>
									</div>

								</c:if>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<c:import url="./footer.jsp"></c:import>
</body>
</html>
