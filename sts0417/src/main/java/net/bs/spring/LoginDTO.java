package net.bs.spring;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginDTO {
	
	//���� ������
	private int grade, gender, zipcode;
	private String id, password, email, phone, birthday, address1, address2;
	private Date  signupdate;
	
}//class END
