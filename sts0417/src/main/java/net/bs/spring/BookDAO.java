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
	
	//0424 섹션별 리스트 출력용 추가 by kjr
	public int s1Count() {
		int s1cnt = temp.selectOne("books.count_s1");
		return s1cnt;
	}
	
	public List<BookinfoDTO> sc1SelectAll(int liststart, int listend, String sort) {
		BookinfoDTO dto = new BookinfoDTO();
		dto.setListstart(liststart);
		dto.setListend(listend);
		dto.setSort(sort);
		return temp.selectList("books.select_s1All", dto);
	}
	
	//0428 섹션번호에 따라 똑같은 객체 사용할 수 있도록 통합
	public int scCount(String scnum) {
		BookinfoDTO dto = new BookinfoDTO();
		dto.setScnum(scnum);
		int sccnt = temp.selectOne("books.count_sc", dto);
		return sccnt;
	}
	
	public int scCount(String scnum, String query) {
		BookinfoDTO dto = new BookinfoDTO();
		dto.setScnum(scnum);
		dto.setQuery(query);
		int sccnt = temp.selectOne("books.count_sc", dto);
		return sccnt;
	}
	
	public int scCount(BookinfoDTO dto) {
		int sccnt = temp.selectOne("books.count_sc", dto);
		return sccnt;
	}
	
	public List<BookinfoDTO> scSelectAll(String scnum, int liststart, int listend, String sort) {
		BookinfoDTO dto = new BookinfoDTO();
		dto.setScnum(scnum);
		dto.setListstart(liststart);
		dto.setListend(listend);
		dto.setSort(sort);
		return temp.selectList("books.select_scAll", dto);
	}
	
	public List<BookinfoDTO> scSelectAll(BookinfoDTO dto) {
		return temp.selectList("books.select_scAll", dto);
	}
	
	
	
	//0424 =================디테일============= by minji
	public BookinfoDTO dbDetail(int idx) {
		return temp.selectOne("books.select_detail", idx);
	}
	
	public double dbStaravg(int idx) {   //디테일 별점 평균
		return temp.selectOne("books.star_avg", idx);
	}  
	
	public int dbreplycnt(int idx) {  //디테일 리뷰 갯수
		return temp.selectOne("books.reply_cnt", idx);
	}
	
	/*public BookinfoDTO dbDetail(int idx) {   리스트에서 디테일 페이지로 넘어올때 사용 할 부분
		return temp.selectOne("books.select_detail", idx);
	}*/
	
	//0426 리뷰 등록했을 때 해당 책의 리뷰수랑 총누적별점 업뎃 by kjr
	public void dbUpdate(int point, int data) {
		BookinfoDTO dto = new BookinfoDTO();
		dto.setBi_stars(point);
		dto.setBi_num(data);
		System.out.println(dto.getBi_stars()+","+dto.getBi_num());
		temp.update("books.add_ratings", dto);
	}
}
