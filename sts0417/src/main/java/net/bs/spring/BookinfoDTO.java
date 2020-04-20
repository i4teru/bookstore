package net.bs.spring;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BookinfoDTO {
	private String bi_isbn, bi_title, bi_image, bi_writer, bi_publisher, bi_pdate, bi_content, bi_comment, bi_status;
	//책ISBN, 책제목, 책썸네일url, 저자, 출판사, 출간일, 책소개, 판매자멘트, 책재고상태
	private int bi_num, bi_price, bi_sprice, bi_reco, bi_stars, bi_ratings, bi_event;
	//책등록번호, 책정가, 책판매가, 추천도서여부, 누적별점점수, 누적별점hit수, 적용된이벤트
	private java.util.Date bi_rdate;
	//사이트등록일
}
