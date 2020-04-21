package net.bs.spring;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BookReplyDAO {
	
	@Autowired
	SqlSessionTemplate temp;
	
	public void dbInsert(BookReplyDTO dto) {
		temp.insert("book_reply.add",dto);
		
	}
	

		
	
	
	
}//BoardReplyDAO class END
