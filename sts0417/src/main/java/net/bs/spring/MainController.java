package net.bs.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	MainDAO dao;
	@Autowired
	private ServletContext application;

	//main.do
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String mainDo(Model model) {

		// 신규 입고 도서 불러오기
		model.addAttribute("newBooks", dao.getNewBooks());

		return "main";
	}

	//이벤트 페이지
	@RequestMapping(value = "/eventlist.do", method = RequestMethod.GET)
	public String eventList(HttpServletRequest request, Model model) {

		int maxcount = 10; // 표시 개수

		//페이지 번호 받아오기
		int page;
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			page = 1;
		}

		int liststart = (page - 1) * maxcount + 1;
		int listend = liststart + maxcount - 1;
		
		//전체 이벤트 개수 받아오기
		int total = dao.eventCount();
		
		int pagecount = ((total-1)/maxcount)*maxcount+1;
		
		int pagestart = ((page-1)/maxcount)*maxcount+1;
		int pageend = pagestart + 9;

		System.out.println(page);
		
		model.addAttribute("events", dao.getEvents(liststart, listend));

		return "eventlist";
	}

	//이벤트 작성 페이지
	@RequestMapping(value = "/eventwrite.do", method = RequestMethod.GET)
	public String eventWrite(Model model) {

		return "eventwrite";
	}

	//이벤트 작성 처리
	@RequestMapping(value = "/insertEvent.do", method = RequestMethod.POST)
	public String insertEvent(MultipartFile file, EventDTO edto) {

		String path = application.getRealPath("/resources/event");
		String image = file.getOriginalFilename();
		System.out.println(image);
		//파일명 중복체크
		String filename = image;
		int i = 0;
		while (!dao.checkImage(filename)) {
			i++;
			filename = i + image;
		}
		image = filename;

		File destFile = new File(path, image); // 경로에 파일 생성
		try {
			file.transferTo(destFile);
		} catch (Exception e) {
			System.out.println("MainController File Error : " + e.toString());
		}
		edto.setImage(image);
		try {
			dao.insertEvent(edto);
			System.out.println("success");
		} catch (Exception e) {
			System.out.println("MainController>insertEvent : " + e.toString());
		}
		return "redirect:/eventlist.do";
	}
}
