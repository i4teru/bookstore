<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<html>
<head>
<title>개발서점</title>

<script src="./resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<style type="text/css">
img.border-shadow {
	border: 1px solid #888888;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}
</style>

<script type="text/javascript">
function addToCart(num){
	var id = "addform"+num;
	document.getElementById(id).submit();
}
</script>

</head>
<body>
	<!-- 헤더 분리 -->
	<c:import url="/header.do"></c:import>
	<div class="container">
		<br> <br> <br>
		<form id="addform${dto.bi_num }" action="pickInsert.do?nidx=${dto.bi_num}&sidx=${dto.bi_status}&idx=${dto.bi_isbn}" method="post">
		<table align="center" style="width: 100%; height: 550px;">
			<tr style="border-bottom: 1px solid #BBBBBB; border-top: 1px solid #BBBBBB;">
				<td rowspan="2" width="27%" style="border-right: 1px solid #BBBBBB;"><img class="border-shadow" alt="image" src="${dto.bi_image}" width="90%" height="90%"></td>
				<td height="250px;">
					<h1>${dto.bi_title}</h1> &nbsp; <font style="font-size: 11pt; color: #696969">ISBN : ${dto.bi_isbn}</font> <br> &nbsp; <font style="color: #444444;"> ${dto.bi_writer} | ${dto.bi_publisher} | ${dto.bi_pdate}<br> <br> &nbsp; 
					별점<font class="text-bsyellow" size="2pt"> <c:if
								test="${staravg eq 0 }">
								<c:forEach begin="1" end="5">
									<i class="far fa-star text-bsyellow"></i>
								</c:forEach>
							</c:if> 
							<c:if test="${staravg eq 1 }">
								<i class="fas fa-star text-bsyellow"></i>
								<c:forEach begin="2" end="5">
									<i class="far fa-star text-bsyellow"></i>
								</c:forEach>
							</c:if><c:if test="${staravg eq 2 }">
								<c:forEach begin="1" end="2">
									<i class="fas fa-star text-bsyellow"></i>
								</c:forEach>
								<c:forEach begin="3" end="5">
									<i class="far fa-star text-bsyellow"></i>
								</c:forEach>
							</c:if> <c:if test="${staravg eq 3 }">
								<c:forEach begin="1" end="3">
									<i class="fas fa-star text-bsyellow"></i>
								</c:forEach>
								<c:forEach begin="4" end="5">
									<i class="far fa-star text-bsyellow"></i>
								</c:forEach>
							</c:if><c:if test="${staravg eq 4 }">
								<c:forEach begin="1" end="4">
									<i class="fas fa-star text-bsyellow"></i>
								</c:forEach>
								<i class="far fa-star text-bsyellow"></i>
							</c:if> <c:if test="${staravg eq 5 }">
								<c:forEach begin="1" end="5">
									<i class="fas fa-star text-bsyellow"></i>
								</c:forEach>
							</c:if>
					</font>${staravg}점 &nbsp;&nbsp;리뷰 ${reply_cnt} 개
				</font><br>
				</td>
			</tr>
			<tr style="border-bottom: 1px solid #BBBBBB;">
			
				<td>&nbsp; 판매가 : <font style="color: #F08080; font-size: 15pt; font-weight: bold"><fmt:formatNumber value="${dto.bi_price}" pattern="#,###,###" />원</font> 
				<br> <br> &nbsp; 
					
					수량 : <input type="number" min="1" max="100" name="amount" value="1" /> &nbsp;  
					<button type="button" class="fas fa-shopping-cart btn-brown1" onclick="addToCart(${dto.bi_num});">장바구니</button>
				</td>
			</tr>
			<tr style="border-bottom: 1px solid #BBBBBB;">
				<td colspan="2">&nbsp;<font style="color: #696969; font-size: 14pt; font-weight: bold">책소개</font><br> ${dto.bi_content}
				</td>
			</tr>
		</table>
	</form>
	</div>
	
	
	<!-- 리뷰 import -->
	<c:import url="/bookreply.do"></c:import>

	<!-- footer 분리 -->
	<c:import url="footer.jsp"></c:import>
</body>
</html>
