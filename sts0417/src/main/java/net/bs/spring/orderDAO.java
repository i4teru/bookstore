package net.bs.spring;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class orderDAO  {
		//class="org.mybatis.spring.SqlSessionTemplate"
	@Autowired
	SqlSessionTemplate temp;
	
		public List<pickitemDTO> dbPreList(List<pickitemDTO> list){
			
			List<pickitemDTO> resultlist = new ArrayList<pickitemDTO>();
			for (int i=0; i<list.size();i++) {
				pickitemDTO dto = list.get(i);
				
				//첫번째 요소에 대한 쿼리
				pickitemDTO tdto = temp.selectOne("order.preorder", dto); 
				resultlist.add(tdto);
			} 
			return resultlist;
		}
	
		public void dbPinsert(orderDTO dto) {
			System.out.println("다오 : "+dto.getOrdernum());
			 System.out.println("다오 : "+dto.getUserid());
			temp.insert("order.padd", dto);
		}//end
		
		public void dbRinsert(orderDTO dto) {
			temp.insert("order.radd", dto);
		}//end
		
		public int dbCount(String userid) {
		
			return temp.selectOne("order.pcount", userid);
		}
		
		public List<orderDTO> dbselectAll(){
			return temp.selectList("order.selectAll");
		}
		
		public List<orderDTO> dbOrderList(orderDTO dto){
			return temp.selectList("order.pselect", dto);
		}
		
		public List<orderDTO> dbRList(String userid){
			return temp.selectList("order.rselect", userid);
		}
		
		public int dbRcnt(String userid) {
			return temp.selectOne("order.rcnt", userid);
		}
		
		public void dbRdel(orderDTO dto) {
			temp.delete("order.rdelete", dto);
		}
		
		public LoginDTO loginDetail(String id) {
			System.out.println(id);
		    return temp.selectOne("order.loginDetail", id);
		}

		
}//class END
