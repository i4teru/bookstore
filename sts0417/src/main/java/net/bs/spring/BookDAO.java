package net.bs.spring;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BookDAO {
	
	@Autowired
	SqlSessionTemplate temp;

	public void dbInsert(BookinfoDTO dto) {
		temp.insert("books.add", dto);
	}//end
	
	public void dbDelete() {
		
	}//end
	
}
