package net.bs.spring;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginDTO {
	
	//���� ������
	private int grade, gender;
	private String id, password, email,phone,birthday , location;
	private Date  signupdate;
	
}//class END
