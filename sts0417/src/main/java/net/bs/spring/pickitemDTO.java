package net.bs.spring;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
//장바구니 아이템	bookcart
public class pickitemDTO {
	//status : 재고있음'is'/품절'so'/절판'oe', amount : 동일한 책 선택 갯수
	 private String userid, isbn, status;
	 private int amount, bnum;
	 
	 private String bi_title, bi_writer, bi_publisher, bi_image;
	 private int bi_price, bi_sprice;
	
	 private int rn;
	 private int start, end, startpage, endpage;
	 private int pageNUM;

}//class END
