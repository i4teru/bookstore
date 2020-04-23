<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>[book_reply.jsp]</title>

<style type="text/css">
.replybox {
	margin: auto;
	height: 200px;
	width: 820px;
	background-color: #eeeeee;
}

textarea {
	width: 700px;
	height: 90px;
	resize: none;
	margin-left: 10px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-right: 5px;
}

.replybtn {
	margin-bottom: 500px;
	height: 90px;
	width: 80px
}

.txtbox {
	margin-left: 10px;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-right: 5px;
	height: 90px;
	width: 700px;
	resize: none;
}

#star_grade a {
	text-decoration: none;
	color: gray;
}

#star_grade a.on {
	color: #FFCC33;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	$(function() {
		
		$('.btn_re').click(function(){
			$(".replybox_re").css("display", "none");
			$("#replybox_re_"+$(this).attr("r_num")).css("display","inline-block");
		});
		
		$('#star_grade a').click(function() {  
			$(this).parent().children("a").removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
			$("#r_stars").val($(this).attr("value"));  //별 클릭 시 기본 value로 지정 되어 있던 0이 누른 별에 지정된 value로 바뀌게 된다
		});

		
	});	
	
</script>
<script type="text/javascript">	 
	
	 function replyEdit(r_num, r_stars,r_content){ 
		  $("#r_stars"+r_num).html(
		   "<input type='text' id='edit_stars"+r_num+"' value='" + r_stars + "' required  size=10>"		 
		 );
	  
		 $("#r_content"+r_num).html(
		  "<input type='text' id='edit_contnet"+r_num+"' value='" + r_content + "' required  size=10>"		 
		);
		 
		 $("#rbt"+r_num).html(
		   "<input type='button' onClick='replyEditSave("+r_num+")' id='btnEdit'  value='수정' size=10>&nbsp;"+
		);
		
	 }

	 function replyEditSave(rhobby_idx,hobby_idx){
		  var r_stars = $("#edit_stars"+r_num).val();
		   var r_content = $("#edit_content"+r_num).val();
		   //alert("수정후:  "+rwriter+" "+rmemo);
		   location.href="replyEdit.do?r_num="+r_num+"&r_stars="+r_stars+"&r_content="+r_content;
	 }	 
  </script>

</head>
<body>
	<c:import url="header.jsp" />
	<br>
	<table class="replytable" width="820px" align="center">
		<tr style="border-bottom: 2px solid #D2B48C;">
			<td colspan="3"><font style="font-size: 16pt;">리뷰 갯수 ${replycnt}</font></td>
		</tr>
	</table>
	<br>
	<c:forEach var="dto" items="${BR}">
		<table class="replytable" width="820px" align="center">
			<c:if test="${dto.lvl eq 0}">
				<tr>
					<td>${dto.r_id}&nbsp;<c:if test="${dto.r_stars eq '1'}">
							<font color="#FFCC33" size="2pt"> <i class="fas fa-star"></i> <c:forEach begin="2" end="5">
									<i class="far fa-star"></i>
								</c:forEach>
							</font>
						</c:if> <c:if test="${dto.r_stars eq '2'}">
							<font color="#FFCC33" size="2pt"> <c:forEach begin="1" end="2">
									<i class="fas fa-star"></i>
								</c:forEach> <c:forEach begin="3" end="5">
									<i class="far fa-star"></i>
								</c:forEach>
							</font>
						</c:if> <c:if test="${dto.r_stars eq '3'}">
							<font color="#FFCC33" size="2pt"> <c:forEach begin="1" end="3">
									<i class="fas fa-star"></i>
								</c:forEach> <c:forEach begin="4" end="5">
									<i class="far fa-star"></i>
								</c:forEach>
							</font>
						</c:if> <c:if test="${dto.r_stars eq '4'}">
							<font color="#FFCC33" size="2pt"> <c:forEach begin="1" end="4">
									<i class="fas fa-star"></i>
								</c:forEach> <i class="far fa-star"></i>
							</font>
						</c:if> <c:if test="${dto.r_stars eq '5'}">
							<font color="#FFCC33" size="2pt"> <c:forEach begin="1" end="5">
									<i class="fas fa-star"></i>
								</c:forEach>
							</font>
						</c:if>
					</td>
					<td colspan=2 style="text-align: right; color: #808080">${dto.r_date}</td>
					<!-- 테이블에 있는 이름은 r_datetime이지만 select에서 String형으로 바꿔주면서 이름을 r_date로 설정 -->
				</tr>

				<tr>
					<td colspan=3>${dto.r_content}</td>
				</tr>
				<tr style="border-bottom: 1px solid #eeeeee;">
					<td colspan=3 align="right">
					<input type="button" onclick="location.href='replyHit.do?ridx=${dto.r_num}&bi_num=110'" value="추천 ${dto.r_hit}"> 
					<input type="button" value="답글" class="btn_re" r_num="${dto.r_num}"> 
					<input type="button" onclick="replyEdit('${dto.r_content}','${dto.r_stars}','${dto.r_num}')" value="수정"> 
					<!-- 추후 dto.bi_num 추가 할 것 --> 
					<input type="button" onclick="location.href='replyDelete.do?ridx=${dto.r_num}'" value="삭제"> 
					<!-- <a href="replypreEdit.do?ridx=${dto.r_num}">수정</a>   
					 <a href="replyDelete.do?ridx=${dto.r_num}">삭제</a>  <!-- 추후 ridx뿐만 아니라 idx(책 디테일번호 bi_num)도 넘겨줘야 한다 -->
				</td>
				</tr>
				<tr id="replybox_re_${dto.r_num}" style="display: none" class="replybox_re">
					<td colspan="3">
						<form action="">
							<input type="text" style="width: 100%">
						</form>
					</td>
				</tr>
			</c:if>

			<c:if test="${dto.lvl > 0}">

				<tr>
					<td colspan="3">
						<table align="center" bgcolor="#F8F8FF" style="width: 820px;">
							<tr>
								<td rowspan="3" width="${dto.lvl * 30 }px">┕</td>
								<td>${dto.r_id }</td>
								<td colspan=3 style="text-align: right; color: #808080">${dto.r_date}</td>
								<!-- 테이블에 있는 이름은 r_datetime이지만 select에서 String형으로 바꿔주면서 이름을 r_date로 설정 -->
							</tr>
							<tr>
								<td colspan=4>${dto.r_content}</td>
							</tr>
							<tr style="border-bottom: 1px solid #eeeeee;">
								<td colspan=4 align="right">
								<input type="button" onclick="location.href='replyHit.do?ridx=${dto.r_num}&bi_num=110'" value="추천 ${dto.r_hit}"> 
								<input type="button" onclick="#" value="답글"> 
								<input type="button" onclick="replyEdit('${dto.r_content}','${dto.r_stars}','${dto.r_num}')" value="수정"> 
								<!-- 추후 dto.bi_num 추가 할 것 --> 
								<input type="button" onclick="location.href='replyDelete.do?ridx=${dto.r_num}'" value="삭제"> 
								<!-- <a href="replypreEdit.do?ridx=${dto.r_num}">수정</a>   
						 <a href="replyDelete.do?ridx=${dto.r_num}">삭제</a>  <!-- 추후 ridx뿐만 아니라 idx(책 디테일번호 bi_num)도 넘겨줘야 한다 -->
		 					</td>
							</tr>
						</table>
					</td>
				</tr>
			</c:if>



		</table>
	</c:forEach>
	<br>
	<form action="replyInsert.do">
		<div class="replybox">
			<input type="hidden" name="bi_num" value="110"> <input type="hidden" name="r_id" value="sky"> <br>
			<p id="star_grade">
				&nbsp;&nbsp; 평가하기 
				<a href="#" value="1">★</a> 
				<a href="#" value="2">★</a> 
				<a href="#" value="3">★</a> 
				<a href="#" value="4">★</a> 
				<a href="#" value="5">★</a>
			</p>
			<input type="hidden" id="r_stars" name="r_stars" value="0">
			<textarea class="txtbox"></textarea>
			<input type="submit" class="replybtn" value="등록">
		</div>
	</form>
</body>
</html>