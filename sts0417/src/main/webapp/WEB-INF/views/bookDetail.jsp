<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

</head>
<body>
	<!-- 헤더 분리 -->
	<c:import url="./header.jsp"></c:import>
	<div class="container">
		<br>
		<br>
		<br>

		<table align="center" style="width: 100%; height: 550px;">
			<tr style="border-bottom: 1px solid #BBBBBB; border-top: 1px solid #BBBBBB;">
				<td rowspan="2" width="27%" style="border-right: 1px solid #BBBBBB;"><img class="border-shadow" alt="image" src="${dto.bi_image}" width="90%" height="90%"></td>
				<td height="250px;">
					<h1>${dto.bi_title}</h1> 
					&nbsp; <font style="font-size: 11pt; color: #696969">ISBN : ${dto.bi_isbn}</font>
					<br> &nbsp; <font style="color: #444444;"> ${dto.bi_writer} | ${dto.bi_publisher} | ${dto.bi_pdate}<br>
					<br> &nbsp; 별점<font class="text-bsyellow" size="2pt"> <i class="fas fa-star "></i> <c:forEach begin="2" end="5">
								<i class="far fa-star"></i>
							</c:forEach>
					</font> ${dto.bi_stars}점 &nbsp;&nbsp;리뷰 0개
				</font><br>
				</td>
			</tr>
			<tr style="border-bottom: 1px solid #BBBBBB;">
				<td>&nbsp; 판매가 : <font style="color: #F08080; font-size: 15pt; font-weight: bold">${dto.bi_price}원</font> 
				<br>
				<br>
				&nbsp;
				<!-- 장바구니 넘어갈때 bi_num이랑 수량(디비에서 이름 확인)해서 &로 같이 넘어가게 할 것 -->
				<a href="#"><i class="fas fa-shopping-cart"></i>장바구니 담기 / 수량 : <input type="number" min="1" max="100" name="amount"/></a>
				</td>
			</tr>
			<tr style="border-bottom: 1px solid #BBBBBB;">
				<td colspan="2">&nbsp;<font style="color: #696969; font-size: 14pt; font-weight: bold">책소개</font><br> ${dto.bi_content}
				</td>
			</tr>
		</table>
	</div>
	<!-- 리뷰 import -->
	<c:import url="/bookreply.do"></c:import>

	<!-- footer 분리 -->
	<c:import url="footer.jsp"></c:import>
</body>
</html>
