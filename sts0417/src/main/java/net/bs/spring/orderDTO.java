package net.bs.spring;

import org.springframework.web.multipart.MultipartFile;
import lombok.Data;
import lombok.Setter;
import lombok.Getter;

@Data
@Setter
@Getter
public class orderDTO { 
	//purchase table 주문
	private String ordernum, userid, orderstatus;
	private int totalamount, totalprice;	
	 private String receiver, contact, postcode, address1, address2;
	 java.util.Date buydate;
	 
	 private String wdate;
	 
	 //purchasedetail table 주문내역
	 private int p_bnum, p_price, p_amount;
	 
	 //주문상세내역에 출력할 bookinfo 변수
	 private String bi_image, bi_title, bi_writer, bi_publisher;
	 private int bi_sprice;
	 
	 private int rn, rcnt;
	 private int start, end, startpage, endpage;
	 private int pageNUM;
	 private String skey, sval;

	 
}//class end
