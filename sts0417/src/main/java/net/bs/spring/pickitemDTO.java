package net.bs.spring;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
//��ٱ��� ������	bookcart
public class pickitemDTO {
	//status : �������'is'/ǰ��'so'/����'oe', amount : ������ å ���� ����
	 private String userid, isbn, status;
	 private int amount, bnum;
	 
	 private String bi_title, bi_writer, bi_publisher, bi_image;
	 private int bi_price, bi_sprice;
	
	 private int rn;
	 private int start, end, startpage, endpage;
	 private int pageNUM;

}//class END
