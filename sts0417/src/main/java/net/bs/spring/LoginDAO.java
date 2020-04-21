package net.bs.spring;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
@Repository
public class LoginDAO  { 
   
	@Autowired
	SqlSessionTemplate temp ;
	
	public void AcInsert(LoginDTO dto) {
		temp.insert("login.accountinsert",dto);
	}
	
	public String login(LoginDTO dto) {
		String logindata=temp.selectOne("login.loginselect", dto);
		return logindata;
	}
	

}//BoardDAO class END
