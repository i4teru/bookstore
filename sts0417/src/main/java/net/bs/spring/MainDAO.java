package net.bs.spring;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
@Repository
public class MainDAO  { 
   
	@Autowired
	SqlSessionTemplate temp ;
	
	public List<BookinfoDTO> getNewBooks(){
		
		return temp.selectList("mainsql.newBooks");
		
	}

}//
