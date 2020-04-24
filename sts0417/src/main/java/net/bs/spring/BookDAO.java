package net.bs.spring;

import java.util.List;

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
	
	public List<BookinfoDTO> sc1Select() {
		return temp.selectList("books.select_s1");
	}
	
	public List<BookinfoDTO> sc2Select() {
		return temp.selectList("books.select_s2");
	}
	
	public List<BookinfoDTO> sc3Select() {
		return temp.selectList("books.select_s3");
	}
	
	public List<BookinfoDTO> sc4Select() {
		return temp.selectList("books.select_s4");
	}
	
	public List<BookinfoDTO> sc5Select() {
		return temp.selectList("books.select_s5");
	}
	
	public int rbCount() { //등록된 도서 총 수 
		int cnt = temp.selectOne("books.count_rbs");
		return cnt;		
	}
	
}
