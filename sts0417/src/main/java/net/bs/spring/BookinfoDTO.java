package net.bs.spring;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BookinfoDTO {
	private String bi_isbn, bi_title, bi_image, bi_writer, bi_publisher, bi_pdate, bi_content, bi_comment, bi_status, bi_rdate;
	//책ISBN, 책제목, 책썸네일url, 저자, 출판사, 출간일, 책소개, 판매자멘트, 책재고상태, 사이트등록일
	private int bi_num, bi_price, bi_sprice, bi_reco, bi_stars, bi_ratings, bi_event;
	//책등록번호, 책정가, 책판매가, 추천도서여부, 누적별점점수, 누적별점hit수, 적용된이벤트
	
	//0425 책 가격에 comma 찍으려고 bi_cprice 추가, 그리고 리뷰수 rcnt, 평균별점 avpnt 만들어 줌 by kjr
	private String bi_cprice;
	private int rcnt;
	private double avpnt;
	//0427 정렬 조건을 주려고 sort, order 추가
	private String sort;
	//0428 나중에 판매량 필드 추가하려고 (조인으로 select시) sales 추가/ 페이징하려고 liststart, listend 추가/ 섹션번호 scnum 추가
	private int sales, liststart, listend;
	private String scnum;
	//0429 검색하려고 query 추가
	private String query;
	
}
