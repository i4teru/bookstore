package net.bs.spring;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class pickitemDAO  {
		//class="org.mybatis.spring.SqlSessionTemplate"
	@Autowired
	SqlSessionTemplate temp;
	
		public void dbInsert(pickitemDTO dto) {
			temp.insert("pickitem.add", dto);
		}//end
		
		public int dbCount(String userid) {
			System.out.println(userid);
			return temp.selectOne("pickitem.count", userid);
		}
		
		public List<pickitemDTO> dbPickList(pickitemDTO dto){
			return temp.selectList("pickitem.selectAll", dto);
		}
		
		public void dbPickDel(pickitemDTO dto) {
			
			temp.delete("pickitem.del", dto);
		}
		
		public void dbpickDel2(pickitemDTO dto) {
			
			temp.update("pickitem.del2", dto);
		}
		
		//0429 by kjr 장바구니에 중복된 항목이 있으면 수량만 증가시키기 위해 추가한 항목
		public int chkCart(int bnum) {
			return temp.selectOne("pre_count", bnum);
		}
		
		public void dbUpdate(pickitemDTO dto) {
			temp.update("pickitem.add_amount", dto);
		}
		
}//class END
