package net.bs.spring;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class orderDAO {
	// class="org.mybatis.spring.SqlSessionTemplate"
	@Autowired
	SqlSessionTemplate temp;

	public List<pickitemDTO> dbPreList(List<pickitemDTO> list) {

		List<pickitemDTO> resultlist = new ArrayList<pickitemDTO>();
		for (int i = 0; i < list.size(); i++) {
			pickitemDTO dto = list.get(i);

			// 첫번째 요소에 대한 쿼리
			pickitemDTO tdto = temp.selectOne("order.preorder", dto);
			resultlist.add(tdto);
		}
		return resultlist;
	}
	
	public void dbPinsert(orderDTO dto) {
		temp.insert("order.padd", dto);
	}// end
	
	public void dbPdetailInsert(List<orderDTO> list) {
		//List<orderDTO> resultlist = new ArrayList<orderDTO>();
		for (int i = 0; i < list.size(); i++) {
			//orderDTO dto = list.get(i);
			
			temp.insert("order.pdetailInsert", list.get(i));			
		}
		
	}

	public List<orderDTO> dbselectAll(String ordernum) {
		return temp.selectList("order.selectAll", ordernum);
	}
	
	public List<orderDTO> dbPdetail(String ordernum){
		return temp.selectList("order.pdetail", ordernum);
	}

	public int dbGetOseq() {
		return temp.selectOne("order.oseq");
	}

	public LoginDTO loginDetail(String id) {
		
		return temp.selectOne("order.loginDetail", id);
	}
	
	public int dbPcount(String userid) {
		System.out.println("OrderDAO pcount uid : " + userid);
		return temp.selectOne("order.pcount", userid);
	}
	
	public List<orderDTO> dbmyorder(orderDTO dto) {
		
		return temp.selectList("order.myorder", dto);
	}
}// class END
