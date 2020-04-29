<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>[book_reply.jsp]</title>

<style type="text/css">

.replybtn {
	height: 90px;
	width: 80px;	
}

.replybox {
	margin: auto;
	height: 200px;
	width: 100%;
	background-color: #eeeeee;
}

.replybox_edit {
	margin: auto;
	height: 150px;
	width: 112%;
	background-color: #eeeeee;
}

.txtbox {
	margin-left: 10px;
	margin-top: 10px;
	margin-bottom: -39px;
	margin-right: 5px;
	height: 90px;
	width: 90%;
	resize: none;
}

#star_grade1 a {
	text-decoration: none;
	color: gray;
}

#star_grade1 a.on {
	color: #FFCC33;
}

#star_grade2 a {
	text-decoration: none;
	color: gray;
}

#star_grade2 a.on {
	color: #FFCC33;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>

	function deleteAlert(r_num, bi_num){  //댓 삭제 시 alert 창 뜨게하기
		 if(confirm("삭제를 원하시면 확인을 눌러주세요"))
	  		{
				 location.href='replyDelete.do?ridx='+r_num+'&idx='+bi_num;
	  		}
				else
	 			{alert('취소되었습니다');}
			}

	$(function() {

		$('.btn_edt').click(function(){
			$(".replybox_edit").css("display", "none");
			$("#replybox_edit_"+$(this).attr("r_num")).css("display","inline-block");
		});
		
		$('.btn_re').click(function(){
			$(".replybox_re").css("display", "none");
			$("#replybox_re_"+$(this).attr("r_num")).css("display","inline-block");
		});

		$('#star_grade1 a').click(function() {  
			$(this).parent().children("a").removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
			$("#r_stars1").val($(this).attr("value"));  //별 클릭 시 기본 value로 지정 되어 있던 0이 누른 별에 지정된 value로 바뀌게 된다
			//0426 by kjr 별 클릭 했을 때 페이지 상단으로 올라가는 문제 해결하기 위해 추가해 줌. 
			$("textarea.txtbox").focus();
			return false;
		});

		$('#star_grade2 a').click(function() {  
			$(this).parent().children("a").removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
			$("#r_stars2").val($(this).attr("value"));  //별 클릭 시 기본 value로 지정 되어 있던 0이 누른 별에 지정된 value로 바뀌게 된다
			//0426 by kjr 별 클릭 했을 때 페이지 상단으로 올라가는 문제 해결하기 위해 추가해 줌. 
			$("textarea.txtbox").focus();
			return false;
		});
		
	});	
	
</script>

</head>
<body>

	<div class="container">

	<br>
	<table class="replytable" width="100%" align="center">
		<tr style="border-bottom: 2px solid #D2B48C;">
			<td colspan="3"><font style="font-size: 16pt; font-weight: bold">상품후기</font><font style="font-size: 12pt; color: gray;"> (${replycount}) </font></td>
		</tr>
	</table>
	<br>
	<c:forEach var="dto" items="${BR}">
		<table class="replytable" width="100%" align="center">
			<c:if test="${dto.lvl eq 0}">
				<tr>
					<td>${dto.r_id}&nbsp;
					<c:if test="${dto.r_stars eq '0'}">
							<font class="text-bsyellow"  size="2pt">
								<c:forEach begin="1" end="5">
									<i class="far fa-star"></i>
								</c:forEach>
							</font>
						</c:if><c:if test="${dto.r_stars eq '1'}">
							<font class="text-bsyellow" size="2pt"> <i class="fas fa-star "></i> <c:forEach begin="2" end="5">
									<i class="far fa-star"></i>
								</c:forEach>
							</font>
						</c:if> <c:if test="${dto.r_stars eq '2'}">
							<font class="text-bsyellow"  size="2pt"> <c:forEach begin="1" end="2">
									<i class="fas fa-star"></i>
								</c:forEach> <c:forEach begin="3" end="5">
									<i class="far fa-star"></i>
								</c:forEach>
							</font>
						</c:if> <c:if test="${dto.r_stars eq '3'}">
							<font class="text-bsyellow"  size="2pt"> <c:forEach begin="1" end="3">
									<i class="fas fa-star"></i>
								</c:forEach> <c:forEach begin="4" end="5">
									<i class="far fa-star"></i>
								</c:forEach>
							</font>
						</c:if> <c:if test="${dto.r_stars eq '4'}">
							<font class="text-bsyellow"  size="2pt"> <c:forEach begin="1" end="4">
									<i class="fas fa-star"></i>
								</c:forEach> <i class="far fa-star"></i>
							</font>
						</c:if> <c:if test="${dto.r_stars eq '5'}">
							<font class="text-bsyellow"  size="2pt"> <c:forEach begin="1" end="5">
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
					
					<c:if test="${dto.r_id != userid }">  <!-- 로그인 안했을 경우 -->
					<input type="button" onclick="location.href='replyHit.do?ridx=${dto.r_num}&idx=${dto.bi_num}'" value="추천 ${dto.r_hit}"> 
					<input type="button" class="btn_re" r_num="${dto.r_num}" value="답글"> 
					</c:if>
					<c:if test="${dto.r_id == userid }">  <!-- 로그인 했을경우 -->
					<input type="button" class="btn_edt" r_num="${dto.r_num}" value="수정">
					<input type="button" onclick="deleteAlert('${dto.r_num}','${dto.bi_num}')"  value="삭제"> 
					</c:if>
					</td>
				</tr>
				
				<!-- =============== 대댓 입력==========   -->
				<tr id="replybox_re_${dto.r_num}" style="display: none" class="replybox_re">
					<td colspan="3">
						<form action="reply_reInsert.do">
							<input type="hidden" name="grp" value="${dto.r_num }">  
							<input type="hidden" name="lvl" value="${dto.lvl }">
							<input type="hidden" name="seq" value="${dto.seq }">
							<input type="hidden" name="bi_num" value="${dto.bi_num}">
							<input type="hidden" name="r_id" value="${userid}">
							<textarea name="r_content" class="txtbox2"  style="width:980px; height: 80px;" ></textarea>
							<input type="submit"  value="답글 등록" >
							
						</form>
					</td>
				</tr>
				<!-- 대댓 입력 끝 -->
				
				
				<!--  ============== 댓글 수정 ========== -->
				<tr id="replybox_edit_${dto.r_num}" style="display: none" class="replybox_edit">
					<td colspan="3" >
						<form action="replyEdit.do">
							<input type="hidden" name="bi_num" value="${dto.bi_num}">
							<input type="hidden" name="r_id" value="${userid}">
							<input type="hidden" name="r_num" value="${dto.r_num}">
							<p id="star_grade2">
							&nbsp; 평가하기 
							<a href="#" value="1">★</a> 
							<a href="#" value="2">★</a> 
							<a href="#" value="3">★</a> 
							<a href="#" value="4">★</a> 
							<a href="#" value="5">★</a>
							</p>
							<input type="hidden" id="r_stars2" name="r_stars" value="0">
							<textarea name="r_content"  style="width:980px; height: 80px; margin-left: 10px; margin-right: 5px; margin-bottom: -34px; resize: none;">${dto.r_content}</textarea>
							<input type="submit" value="수정" style="width: 80px; height: 80px">							
						</form>
					</td>
				</tr>
				
				<!-- 댓글 수정 끝 -->
				
			</c:if>

			<c:if test="${dto.lvl > 0}">
				<tr>
					<td colspan="3">
						<!-- 대댓글 테이블을 기존 댓글 테이블 안에 추가해주었다 -->
						<table align="center" bgcolor="#F8F8FF" style="width: 100%;">
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
								<c:if test="${dto.r_id != userid }">  <!-- 로그인 안했을 경우 -->
								<input type="button" onclick="location.href='replyHit.do?ridx=${dto.r_num}&idx=${dto.bi_num}'" value="추천 ${dto.r_hit}"> 
								</c:if>
								<c:if test="${dto.r_id == userid }">
								<input type="button" class="btn_edt" r_num="${dto.r_num}" value="수정"> 
								<input type="button" onclick="deleteAlert('${dto.r_num}','${dto.bi_num}')" value="삭제">
								</c:if>   
						       </td>
						   </tr>
						</table>
					</td>
				</tr>
				
				<!--  ============== 대댓글 수정 ========== -->
				<tr id="replybox_edit_${dto.r_num}" style="display: none" class="replybox_edit">
					<td colspan="3" >
						<form action="replyEdit.do">
							<input type="hidden" name="bi_num" value="${dto.bi_num}">
							<input type="hidden" name="r_id" value="${userid}">
							<input type="hidden" name="r_num" value="${dto.r_num}">
							
							<input type="hidden" id="r_stars" name="r_stars" value="0">
							<textarea name="r_content"  style="width:980px; height: 80px; margin-left: 10px; margin-right: 5px; margin-bottom: -34px; resize: none;">${dto.r_content}</textarea>
							<input type="submit" value="수정" style="width: 80px; height: 80px">							
						</form>
					</td>
				</tr>
				
				<!-- 대댓글 수정 끝 -->					
	
			</c:if>
		</table>
	</c:forEach>
	<br>
		<div style="text-align: center">	  
  		<c:if test="${startpage != 1}"><a href="bookdetail.do?idx=${dto.bi_num}&pageNum=${startpage-10}">[이전]</a></c:if> 	
  			<c:forEach var="i" begin="${startpage}" end="${endpage}">	
  				<c:choose>
  	  					<c:when test="${i==pageNUM}"> 
  	  				  <font style='color:black;font-size:12pt'>[${i}]</font> 
  	  			</c:when>
  	  					<c:otherwise>
  	  		 				<a href="bookdetail.do?idx=${dto.bi_num}&pageNum=${i}">[${i}]</a>
  	  					</c:otherwise>
  	  			</c:choose>
  			</c:forEach> 
  		<c:if test="${endpage < pagecount}"><a href="bookdetail.do?idx=${dto.bi_num}&pageNum=${startpage+10}">[다음]</a></c:if> 	 	
    	</div>				
	<br>
	
	<form action="replyInsert.do">
		<div class="replybox">
			<!-- 0425 by kjr value의 임시값 110을 ${bi_num}으로 바꿈 -->
			<input type="hidden" name="bi_num" value="${dto.bi_num }"> <input type="hidden" name="r_id" value="${userid}"> <br>
			<p id="star_grade1">
				&nbsp;&nbsp; 평가하기 
				<a href="#" value="1">★</a> 
				<a href="#" value="2">★</a> 
				<a href="#" value="3">★</a> 
				<a href="#" value="4">★</a> 
				<a href="#" value="5">★</a>
			</p>
			<input type="hidden" id="r_stars1" name="r_stars" value="0">
			<textarea class="txtbox" name="r_content"></textarea>
			<input type="submit" name="btn_save" class="replybtn" value="등록">
		</div>
	</form>
	<br>

	</div>
	

</body>
</html>