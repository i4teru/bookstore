<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>책 등록 페이지</title>
  
  <link rel="stylesheet" href="/resources/demos/style.css">

<!-- 아래 세개는 세트 jsp 생성시마다 import -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>

<script>
  $(window).on("load", function() {
	var c = "${msg}".trim();//$( "#dialog-message").val();
	if(c == "insertok"){
		$("#myModal").modal('show'); 
	}
  });
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
			  data: { query: $("#bkquery").val(),
				  	  size: 15 },
			  headers: {Authorization: "KakaoAK 8f3dd6862256234f37e949a43e4e0c2d"}
			})
			  .done(function( msg ) {
				  var len = msg.documents.length; //한 페이지에 보여지는 권수
				  var len2 = msg.meta.total_count; //검색된 총 권수
				  var len3 = msg.meta.pageable_count; //검색된 책 가운데 보여질 수 있는 총 권수
				  var end = msg.meta.is_end; //
				  $("#message").html("총 "+len2+"권의 검색 결과 중 "+len+"권의 책만 보여집니다. <hr>"); 
				  

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

					$("#bklist").append("<ul class='bkitem"+i+"'>");
					$("#bklist").append("<img src='"+img+"' class='bkimg' />");
					$("#bklist").append("<li class='hide li_img"+i+"'>"+img+"</li>");
					$("#bklist").append("<li class='li_title"+i+"'>"+title+"</li>");
					$("#bklist").append("<li class='li_isbn"+i+"'>"+isbn+"</li>");
					$("#bklist").append("<li class='li_author"+i+"'>"+author+"</li>");
					$("#bklist").append("<li class='li_publ"+i+"'>"+publ+"</li>");
					$("#bklist").append("<li class='li_pubd"+i+"'>"+pubd+"</li>");
					$("#bklist").append("<li class='li_prc"+i+"'>"+prc+"</li>");
					$("#bklist").append("<li class='li_sprc"+i+"'>"+sprc+"</li>");
					$("#bklist").append("<li class='li_contt"+i+"'>"+contt.substring(0,145)+"...</li>");
					$("#bklist").append("<button type='button' onclick='addBook("+i+")'>선택</button>");
					$("#bklist").append("<hr>");
					$("#bklist").append("</ul>");
					if ( i == len-1 ) return false; });
			  });
		});
});

function addBook(ul_idx){ //선택한 책의 데이터들(isbn, 제목 등)을 숨은 input 태그의 value로 넣어줌
	$("#btn_insert").show();
	$("#message").html("등록 버튼을 누르면 저장됩니다.");
	$("ul").css("border","");
	$(".bkitem"+ul_idx).css("border", "1px solid #f00" );
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
<c:import url="header.jsp"></c:import>

<div class="container">
<h2>
	[bookInsert.jsp] 책 입력 Form  
</h2>

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
<!-- 
<div id="dialog-message" title="${msg}" >
  <p>
    <span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span>
	저장에 성공했습니다. 
  </p>
</div> -->


 <!-- Bootstrap Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->   
        <div class="modal-header">  
          <h4 class="modal-title">저장 성공</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          	데이터 저장에 성공했습니다.
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
          <button type="button" class="btn btn-danger" onclick="location.href='./main.do'" >메인으로</button>
        </div>
        
      </div>
    </div>
  </div>
</div>
</body>
</html>
