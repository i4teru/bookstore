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
	
/*	public List<BookReplyDTO> dbSelect(BookReplyDTO dto) {
		List<BookReplyDTO> list = temp.selectList("book_reply.select",dto);
		return list;
	} */
	
	public List<BookReplyDTO> dbSelect(int start, int end) {
		BookReplyDTO dto = new BookReplyDTO();
		dto.setStart(start);
		dto.setEnd(end);
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
	
	public int dbReplycnt() {   //대댓포함 총 카운트
		return temp.selectOne("book_reply.replycnt");
	}
	
	public int dbReplycount() {  //원댓글만 있는 카운트
		return temp.selectOne("book_reply.replycount");
	}
	
	
	/*
	 * public int dbReplycnt(int bi_num) { return
	 * temp.selectOne("book_reply.replycnt", bi_num); }
	 */
	
}//BoardReplyDAO class END
