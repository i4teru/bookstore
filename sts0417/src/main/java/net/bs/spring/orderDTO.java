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
	private String ordernum, userid, orderstatus ;
	 private int amount;
	 java.util.Date buydate;
	 
	 //purchasedetail table 주문내역
	 private int bnum, price;
	 
	//receiver table 수취인 배송지 정보
	 private String receiver, contact, postcode, address1, address2;
	 private int rnum;
	 
	 private int rn, rcnt;
	 private int start, end, startpage, endpage;
	 private int pageNUM;
	 private String skey, sval;

	 
}//class end
