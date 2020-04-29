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
	
	public void dbReinsert(BookReplyDTO dto) {
		temp.insert("book_reply.readd", dto);
	}

	public List<BookReplyDTO> dbSelect(int start, int end, int data) {
		BookReplyDTO dto = new BookReplyDTO();
		dto.setStart(start);
		dto.setEnd(end);
		dto.setBi_num(data); //0425 �߰� by kjr
		return temp.selectList("book_reply.select",dto);
	}	
	
	public int dbDelete(int ridx) {
		return temp.delete("book_reply.delete", ridx);
	}  

	public void dbEdit(BookReplyDTO dto) {
		temp.update("book_reply.edit", dto);
	}
	
	public void dbHit(int ridx) {
		temp.update("book_reply.rehit",ridx);
	}  
	
	public int dbReplycnt(int idx) {   //������� �� ī��Ʈ
		return temp.selectOne("book_reply.replycnt", idx);
	}
	
	public int dbReplycount(int idx) {  //����۸� �ִ� ī��Ʈ
		return temp.selectOne("book_reply.replycount", idx);
	}
	
	
	
	/*
	 * public int dbReplycnt(int bi_num) { return
	 * temp.selectOne("book_reply.replycnt", bi_num); }
	 */
	
}//BoardReplyDAO class END
