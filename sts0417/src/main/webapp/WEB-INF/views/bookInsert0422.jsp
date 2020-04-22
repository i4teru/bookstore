<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Dialog - Modal message</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
  $(window).on("load", function() {
	var c = $( "#dialog-message").attr("title");
	if(c == "insertok"){
    $( "#dialog-message" ).dialog({
      modal: true,
      buttons: {
        "닫기": function() {$( this ).dialog( "close" );},
        "메인으로": function() { location.href="./main.do";}
      }
    });
	  } else {
	$("#dialog-message").hide();
		  }
  } );
</script>

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
				  $("#message").html("총 "+len+"권의 책이 검색되었습니다.<hr>");

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

function addBook(ul_idx){ //선택한 책의 데이터들(isbn, 제목 등)을 숨은 input 태그의 value로 넣어줌
	$("#btn_insert").show();
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
<!-- header 추가 -->

<h1>
	[bookInsert.jsp] 책 입력 Form  
</h1>

<!-- 등록할 책 검색 영역  -->
<div>
	<h3>검색창에 ISBN, 책제목, 저자 등을 입력하고 검색 버튼 Click </h3>
	<input type="text" id="bkquery" value="">
	<button id="search">검색</button>
</div>

<!-- 선택된 책의 데이터를 DB에 저장 -->
<div>	
	<form name="biform" action="bookInsert.do" method="get">
	<input type="hidden" name="bi_isbn" id="bi_isbn" value="">
	<input type="hidden" name="bi_title" id="bi_title" value="">
	<input type="hidden" name="bi_image" id="bi_image" value="">
	<input type="hidden" name="bi_writer" id="bi_writer" value="">
	<input type="hidden" name="bi_publisher" id="bi_publisher" value="">
	<input type="hidden" name="bi_pdate" id="bi_pdate" value="">
	<input type="hidden" name="bi_price" id="bi_price" value="">
	<input type="hidden" name="bi_sprice" id="bi_sprice" value="">
	<input type="hidden" name="bi_content" id="bi_content" value=""><br>
	<input type="submit" id="btn_insert" class="hide" value="선택 상품 등록">
	</form>
</div>

<!-- 메시지가 나타나는 곳 -->
<div id="message">
</div>

<!-- 검색한 책 목록이 나타나는 곳 -->
<div id="bklist">
</div>

<!-- DB에 저장 완료 했을 때 뜨는 대화창 영역 -->
<div id="dialog-message" title="${msg}" >
  <p>
    <span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span>
	저장에 성공했습니다. 
  </p>
</div>

</body>
</html>
