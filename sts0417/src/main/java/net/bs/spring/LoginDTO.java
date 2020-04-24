package net.bs.spring;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginDTO {
	
	//���� ������
	private int grade, gender, zipcode;
	private String name, id, password, email, phone, birthday, address1, address2;
	private Date  signupdate;

	//�������� ������
	private int rn, start, end, pagecount, pageNUM, total, notice_num;
	private String notice_content, notice_title;
	private Date upload_date;
	
}//class END
