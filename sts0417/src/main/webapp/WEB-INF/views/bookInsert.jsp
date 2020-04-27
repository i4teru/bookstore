<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
		if (c == "insertok") {
			$("#myModal").modal('show');
		}
	});
</script>

<style type="text/css">
.bkimg {
	width: 200px;
}

li {
	list-style: none;
}

.hide {
	display: none;
}
</style>

<script>
	$(document).ready(function() {
		$("#search").click(function() {
			$("#bklist").html("");
			$.ajax({
				method : "GET",
				url : "https://dapi.kakao.com/v3/search/book?target=title",
				data : {
					query : $("#bkquery").val(),
					size : 15
				},
				headers : {
					Authorization : "KakaoAK 8f3dd6862256234f37e949a43e4e0c2d"
				}
			}).done(function(msg) {
				var len = msg.documents.length; //한 페이지에 보여지는 권수
				var len2 = msg.meta.total_count; //검색된 총 권수
				var len3 = msg.meta.pageable_count; //검색된 책 가운데 보여질 수 있는 총 권수
				var end = msg.meta.is_end; //마지막 페이지인가
				$("#message").html("<hr>총 " + len2 + "권의 검색 결과 중 " + len + "권의 책이 출력되었습니다.");

				$.each(msg.documents, function(i, item) {
					var isbn = item.isbn.split(" ")[1];
					var title = item.title;
					var img = item.thumbnail;
					var author = item.authors;
					var publ = item.publisher;
					var pubd = item.datetime.substring(0, 10);
					var prc = item.price;
					var sprc = item.sale_price;
					var contt = item.contents;

					var result = "";
					result += "<tr><td><hr></tr></td><tr><td>";
					result += "<table class='table table-borderless' id='bkitem"+i+"'>";
					result += "<tr><td rowspan='10' style='width:220px'><img src='"+img+"' class='bkimg' /></td>";
					result += "<th style='width:100px'>제목</th><td class='li_title"+i+"'>" + title + "</td>";
					result += "<td rowspan='10' style='width:100px'><button type='button' class='btn btn-brown1' onclick='addBook(" + i + ")'>선택</button></td></tr>";

					result += "<tr><th>ISBN</th><td class='li_isbn"+i+"'>" + isbn + "</td></tr>";
					result += "<tr><th>저자</th><td class='li_author"+i+"'>" + author + "</td></tr>";
					result += "<tr><th>출판사</th><td class='li_publ"+i+"'>" + publ + "</td></tr>";
					result += "<tr><th>출판일</th><td class='li_pubd"+i+"'>" + pubd + "</td></tr>";
					result += "<tr><th>가격</th><td class='li_prc"+i+"'>" + prc + "</td></tr>";
					result += "<tr><th>할인가</th><td class='li_sprc"+i+"'>" + sprc + "</td></tr>";
					result += "<tr><th>내용</th><td class='li_contt"+i+"'>" + contt.substring(0, 145) + "...</td></tr>";
					result += "<tr style='display:none' ><th>이미지주소</th><td class='li_img"+i+"'>" + img + "</td></tr>";
					result += "</table></td></tr>";

					$("#bklist").append(result);
					if (i == len - 1)
						return false;
				});
			});
		});
	});

	function addBook(ul_idx) { //선택한 책의 데이터들(isbn, 제목 등)을 숨은 input 태그의 value로 넣어줌

		$("ul").css("border", "");
		//$(".bkitem" + ul_idx).css("border", "1px solid #f00");
		$("#bi_isbn").val($(".li_isbn" + ul_idx).text());

		$("#bi_title").val($(".li_title" + ul_idx).text());
		$("#bi_image").val($(".li_img" + ul_idx).text());
		$("#bi_writer").val($(".li_author" + ul_idx).text());
		$("#bi_publisher").val($(".li_publ" + ul_idx).text());
		$("#bi_pdate").val($(".li_pubd" + ul_idx).text());
		$("#bi_price").val($(".li_prc" + ul_idx).text());
		$("#bi_sprice").val($(".li_sprc" + ul_idx).text());
		$("#bi_content").val($(".li_contt" + ul_idx).text());

		var result = "<hr><h4 class='text-darkgray'>선택된 상품</h4>";
		result += "<table class='table table-borderless'>";
		result += "<tr><td rowspan='10' style='width:220px'><img src='" + $("#bi_image").val() + "' class='bkimg' /></td>";
		result += "<th style='width:100px'>제목</th><td>" + $("#bi_title").val() + "</td>";
		result += "<tr><th>ISBN</th><td>" + $("#bi_isbn").val() + "</td></tr>";
		result += "<tr><th>저자</th><td>" + $("#bi_writer").val() + "</td></tr>";
		result += "<tr><th>출판사</th><td>" + $("#bi_publisher").val() + "</td></tr>";
		result += "<tr><th>출판일</th><td>" + $("#bi_pdate").val() + "</td></tr>";
		result += "<tr><th>가격</th><td>" + $("#bi_price").val() + "</td></tr>";
		result += "<tr><th>할인가</th><td>" + $("#bi_sprice").val() + "</td></tr>";
		result += "<tr><th>내용</th><td>" + $("#bi_content").val().substring(0, 145) + "...</td></tr>";
		result += "<tr style='display:none' ><th>이미지주소</th><td>" + $("#bi_image").val() + "</td></tr>";
		result += "</table>";

		$("#bklist").html("");
		$("#message").html(result);
		$("#btn_insert").css("display", "block");

	}
</script>

</head>
<body>
	<!-- header 추가 -->
	<c:import url="/header.do"></c:import>

	<div class="bg-lightgray">
		<div class="container pt-5 pb-5">

			<div class="mainbox p-3">
				<div class="pagetitle">
					<h2 class="text-darkgray">
						<i class="fas fa-book text-brown1"></i> 도서 등록
					</h2>
				</div>
				<!-- 등록할 책 검색 영역  -->
				<div>
					<div class="input-group" style="width: 50%">
						<input class="form-control" type="text" id="bkquery" value="">
						<div class="input-group-append">
							<button class="btn btn-brown1" id="search">검색</button>
						</div>
					</div>
				</div>

				<!-- 메시지가 나타나는 곳 -->
				<div id="message">
					<p class="mt-5 pb-5 pt-5 text-darkgray acenter">
						검색된 자료가 없습니다.<br> <br>검색창에 ISBN, 책제목, 저자 등을 입력해주세요.
					</p>
				</div>

				<!-- 선택된 책의 데이터를 DB에 저장 -->
				<div style="text-align: center">
					<form name="biform" action="bookInsert.do" method="get">
						<input type="hidden" name="bi_isbn" id="bi_isbn" value=""> <input type="hidden" name="bi_title" id="bi_title" value=""> <input type="hidden" name="bi_image" id="bi_image" value=""> <input type="hidden" name="bi_writer" id="bi_writer" value=""> <input
							type="hidden" name="bi_publisher" id="bi_publisher" value=""> <input type="hidden" name="bi_pdate" id="bi_pdate" value=""> <input type="hidden" name="bi_price" id="bi_price" value=""> <input type="hidden" name="bi_sprice" id="bi_sprice" value=""> <input
							type="hidden" name="bi_content" id="bi_content" value=""><br>
						<button class="btn btn-brown1" type="submit" id="btn_insert" style="display: none; margin: auto">선택 상품 등록</button>
					</form>
				</div>

				<!-- 검색한 책 목록이 나타나는 곳 -->
				<table id="bklist" class="table table-borderless" style="width: 100%;">

				</table>
				
				<!-- Bootstrap Modal -->
				<div class="modal" id="myModal">
					<div class="modal-dialog">
						<div class="modal-content">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">저장 성공</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>

							<!-- Modal body -->
							<div class="modal-body">데이터 저장에 성공했습니다.</div>

							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
								<button type="button" class="btn btn-danger" onclick="location.href='./main.do'">메인으로</button>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="footer.jsp"></c:import>
</body>
</html>
