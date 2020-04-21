<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bookInsert.jsp</title>
<style type="text/css">
.bkimg {
	float: left;	
	margin-right: 20px;
	margin-top: 20px;
	clear: both;
}

li {
	list-style: none;
}

.hide {
	display: none;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.0.js"
  integrity="sha256-r/AaFHrszJtwpe+tHyNi/XCfMxYpbsRg2Uqn0x3s2zc="
  crossorigin="anonymous">
</script>
<script>
$(document).ready(function(){
	$("#search").click(function(){
		$("#bklist").empty();
		$.ajax({
			  method: "GET",
			  url: "https://dapi.kakao.com/v3/search/book?target=title",
			  data: { query: $("#bkquery").val() },
			  headers: {Authorization: "KakaoAK 8f3dd6862256234f37e949a43e4e0c2d"}
			})
			  .done(function( msg ) {
				  var len = msg.documents.length;
				  $("#bklist").html("총 "+len+"권의 책이 검색되었습니다.<hr>");

				$.each(msg.documents, function(i,item) { 
					var isbn = item.isbn.split(" ")[1];
				    var title = item.title;
				    var img = item.thumbnail;
				    var author = item.authors;
				    var publ = item.publisher;
				    var pubd = item.datetime.substring(0,10);
				    var prc = item.price;
				    var sprc = item.sale_price;
				    var contt = item.contents;

					$("#bklist").append("<ul class='bkitem'>");
					$("#bklist").append("<img src='"+img+"' class='bkimg' />");
					$("#bklist").append("<li class='hide li_img"+i+"'>"+img+"</li>");
					$("#bklist").append("<li class='li_title"+i+"'>"+title+"</li>");
					$("#bklist").append("<li class='li_isbn"+i+"'>"+isbn+"</li>");
					$("#bklist").append("<li class='li_author"+i+"'>"+author+"</li>");
					$("#bklist").append("<li class='li_publ"+i+"'>"+publ+"</li>");
					$("#bklist").append("<li class='li_pubd"+i+"'>"+pubd+"</li>");
					$("#bklist").append("<li class='li_prc"+i+"'>"+prc+"</li>");
					$("#bklist").append("<li class='li_sprc"+i+"'>"+sprc+"</li>");
					$("#bklist").append("<li class='li_contt"+i+"'>"+contt.substring(0,100)+"...</li>");
					$("#bklist").append("<button type='button' onclick='addBook("+i+")'>선택</button>");
					$("#bklist").append("<hr>");
					$("#bklist").append("</ul>");
					if ( i == len-1 ) return false; });
			  });
		});

});

$(document).on("click", ".selected", function(){
 	//var $li_list = $(this).prevAll[class^=li];  
 	//console.log($li_list.eq(0));
 	//alert($(this).siblings().filter(".li_title").text());
 	//$(this).text("dfsdfa");
});

function addBook(ul_idx){

//	var a = new Array();
//	var b = a[ul_idx].split("");
	
	alert(ul_idx);
	//var $a = $("ul.bkitem li");
	var $ul_list = $("#bkitem"+ul_idx).siblings();
	console.log($ul_list);
	var c = $(".li_title"+ul_idx).text();
	console.log(c);
	//console.log($a);

    $("#bi_isbn").val($(".li_isbn"+ul_idx).text());
    $("#bi_title").val($(".li_title"+ul_idx).text());
    $("#bi_image").val($(".li_img"+ul_idx).text());
    $("#bi_writer").val($(".li_author"+ul_idx).text());
    $("#bi_publisher").val($(".li_publ"+ul_idx).text());
    $("#bi_pdate").val($(".li_pubd"+ul_idx).text());
    $("#bi_price").val($(".li_prc"+ul_idx).text());
    $("#bi_sprice").val($(".li_sprc"+ul_idx).text());
    $("#bi_content").val($(".li_contt"+ul_idx).text());
}
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

<div id="bklist">
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
