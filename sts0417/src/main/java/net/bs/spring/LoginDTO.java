package net.bs.spring;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginDTO {
	
	//계정 데이터
	private int grade, gender, zipcode;
	private String id, password, email, phone, birthday, address1, address2;
	private Date  signupdate;
	
}//class END
