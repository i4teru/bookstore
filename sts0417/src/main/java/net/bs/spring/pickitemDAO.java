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
			System.out.println("DAO : "+dto.getIsbn());
			System.out.println(dto.getUserid());
			temp.delete("pickitem.del", dto);
		}
		
		public void dbpickDel2(pickitemDTO dto) {
			System.out.println("DAO : "+dto.getIsbn());
			System.out.println(dto.getUserid());
			temp.update("pickitem.del2", dto);
		}
		
}//class END
