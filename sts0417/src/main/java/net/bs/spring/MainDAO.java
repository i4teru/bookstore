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
		
		return temp.selectList("mainsql.getEvents", new EventDTO(liststart, listend));
	}

}//
