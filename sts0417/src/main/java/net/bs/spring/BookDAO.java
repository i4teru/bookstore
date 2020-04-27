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
	
	public int rbCount() { //��ϵ� ���� �� �� 
		int cnt = temp.selectOne("books.count_rbs");
		return cnt;		
	}
	
	//0424 ���Ǻ� ����Ʈ ��¿� �߰� by kjr
	public int s1Count() {
		int s1cnt = temp.selectOne("books.count_s1");
		return s1cnt;
	}
	
	public List<BookinfoDTO> sc1SelectAll() {
		return temp.selectList("books.select_s1All");
	}
	
	//0424 =================������============= by minji
	public BookinfoDTO dbDetail(int idx) {
		return temp.selectOne("books.select_detail", idx);
	}
	
	/*public BookinfoDTO dbDetail(int idx) {   ����Ʈ���� ������ �������� �Ѿ�ö� ��� �� �κ�
		return temp.selectOne("books.select_detail", idx);
	}*/
	
	//0426 ���� ������� �� �ش� å�� ������� �Ѵ������� ���� by kjr
	public void dbUpdate(int point, int data) {
		BookinfoDTO dto = new BookinfoDTO();
		dto.setBi_stars(point);
		dto.setBi_num(data);
		System.out.println(dto.getBi_stars()+","+dto.getBi_num());
		temp.update("books.add_ratings", dto);
	}
}
