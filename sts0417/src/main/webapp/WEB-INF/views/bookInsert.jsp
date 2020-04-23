<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookInsert.jsp</title>
<style type="text/css">
</style>
<script src="https://code.jquery.com/jquery-3.5.0.js"
  integrity="sha256-r/AaFHrszJtwpe+tHyNi/XCfMxYpbsRg2Uqn0x3s2zc="
  crossorigin="anonymous">
</script>
<script>
$(document).ready(function(){
	$("#search").click(function(){
		$("p").empty();
		$.ajax({
			  method: "GET",
			  url: "https://dapi.kakao.com/v3/search/book?target=title",
			  data: { query: $("#bkquery").val() },
			  headers: {Authorization: "KakaoAK 8f3dd6862256234f37e949a43e4e0c2d"}
			})
			  .done(function( msg ) {
				console.log(msg);
				var isbn = msg.documents[0].isbn.split(" ")[1];
			    var title = msg.documents[0].title;
			    var img = msg.documents[0].thumbnail;
			    var author = msg.documents[0].authors;
			    var publ = msg.documents[0].publisher;
			    var pubd = msg.documents[0].datetime.substring(0,10);
			    var prc = msg.documents[0].price;
			    var sprc = msg.documents[0].sale_price;
			    var contt = msg.documents[0].contents;
				
			    $("#bi_isbn").val(isbn);
			    $("#bi_title").val(title);
			    $("#bi_image").val(img);
			    $("#bi_writer").val(author);
			    $("#bi_publisher").val(publ);
			    $("#bi_pdate").val(pubd);
			    $("#bi_price").val(prc);
			    $("#bi_sprice").val(sprc);
			    $("#bi_content").val(contt);
			    console.log(msg.documents[0].thumbnail);
			    $("p").append("<hr>");
			    $("p").append("<img src='"+msg.documents[0].thumbnail+"' />"+title+", "+pubd+", "+isbn+"<hr>");
			  });
		});
});

</script>
  
</head>
<body>
<h1>
	[bookInsert.jsp] 책 입력 Form  
</h1>
<div>
	<h3>검색창에 ISBN, 책제목, 저자 등을 입력하고 검색 버튼 Click </h3>
	<input type="text" id="bkquery" value="">
	<button id="search">검색</button>
</div>

<div>
<p></p>
</div>
<div>	
	<form name="biform" action="bookInsert.do" method="get">
	<input type="text" name="bi_isbn" id="bi_isbn" value=""><br>
	<input type="text" name="bi_title" id="bi_title" value=""><br>
	<input type="text" name="bi_image" id="bi_image" value=""><br>
	<input type="text" name="bi_writer" id="bi_writer" value=""><br>
	<input type="text" name="bi_publisher" id="bi_publisher" value=""><br>
	<input type="text" name="bi_pdate" id="bi_pdate" value=""><br>
	<input type="text" name="bi_price" id="bi_price" value=""><br>
	<input type="text" name="bi_sprice" id="bi_sprice" value=""><br>
	<input type="text" name="bi_content" id="bi_content" value=""><br>
	<input type="submit" value="등록">
	</form>
</div>
</body>
</html>
