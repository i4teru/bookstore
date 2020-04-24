package net.bs.spring;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
@Repository
public class LoginDAO  { 
   
	@Autowired
	SqlSessionTemplate temp ;
	
	public void dbAcInsert(LoginDTO dto) {
		temp.insert("login.dbaccountinsert",dto);
	}
	
	public String dblogin(LoginDTO dto) {
		String logindata=temp.selectOne("login.dbloginselect", dto);
		return logindata;
	}
	
	public int dbcheckid(String id) {
		return temp.selectOne("login.dbcheckid", id);
	}
	
	public void dbnoticeInsert(LoginDTO dto) {
		temp.insert("login.dbnoticeinsert", dto);
	}
	
	public List<LoginDTO> dbshownotice(int start, int end){
		LoginDTO dto = new LoginDTO();
		dto.setStart(start);
		dto.setEnd(end);
		return temp.selectList("login.dbshownotice", dto);
	}
	
	public int dbcountnotice() {
		return temp.selectOne("login.dbcountnotice");
	}
	
	public LoginDTO dbshownotice_detail(int num){
		return temp.selectOne("login.dbshownotice_detail", num);
	}
	
	public void dbupdatenotice(LoginDTO dto) {
		temp.update("login.dbupdatenotice", dto);
	}
	
	public void dbdeletenotice(int num) {
		temp.delete("login.dbdeletenotice", num);
	}
	
	public LoginDTO dbaccountdata(String id) {
		return temp.selectOne("login.dbaccountdata", id);
	}
	
	public void dbaccountedit(LoginDTO dto) {
		temp.update("login.dbeditaccount", dto);
	}

}//BoardDAO class END
