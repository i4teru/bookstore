package net.bs.spring;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Component
@Repository
public class MainDAO {

	@Autowired
	SqlSessionTemplate temp;

	public List<BookinfoDTO> getNewBooks() {

		return temp.selectList("mainsql.newBooks");

	}

	public boolean checkImage(String image) {
		int cnt = temp.selectOne("mainsql.checkImage", image);
		if (cnt > 0)
			return false;
		else
			return true;
	}
	
	public void insertEvent(EventDTO edto) {
		temp.insert("mainsql.insertEvent", edto);
	}
	
	public int eventCount() {
		return temp.selectOne("mainsql.eventCount");
	}
	
	public List<EventDTO> getEvents(int liststart, int listend){
		
		EventDTO edto = new EventDTO();
		edto.setListstart(liststart);
		edto.setListend(listend);
		
		return temp.selectList("mainsql.getEvents", edto);
	}
	
	public List<EventDTO> getMainEvents(){
		return temp.selectList("mainsql.getMainEvents");
	}
	
	public int mainEventCount() {
		return temp.selectOne("mainsql.mainEventCount");
	}
	
	public int pickCount(String userid) {
		return temp.selectOne("mainsql.pickCount", userid);
	}

}//
