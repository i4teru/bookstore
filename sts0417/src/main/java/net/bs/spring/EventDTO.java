package net.bs.spring;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EventDTO {
	
	/*
	num number not null primary key,
	title varchar2(200) not null,
	url varchar2(200) not null,
	image varchar2(200) not null,
	startdate date not null,
	enddate date not null
	*/
	
	private int num;
	private String title, url, image, startdate, enddate;
	
	//select¿ë
	private int liststart, listend;
	
	public EventDTO(int liststart, int listend) {
		this.liststart = liststart;
		this.listend = listend;
	}
	
}//class END
