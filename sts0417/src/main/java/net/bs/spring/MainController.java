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
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	MainDAO dao;
	@Autowired
	private ServletContext application;

	//에러
	@RequestMapping("/error.do")
	public String error(@RequestParam("msg") String msg, Model model) {

		model.addAttribute("msg", msg);
		return "error";
	}

	//header.do
	@RequestMapping(value = "/header.do", method = RequestMethod.GET)
	public String header(HttpSession session, Model model, HttpServletRequest request) {

		String uid = (String) session.getAttribute("userid");
		if (uid == null)
			uid = "";
		else {
			//로그인했을때만 등급과 이름 세션에 기록
			model.addAttribute("username", (String) session.getAttribute("username"));
			model.addAttribute("usergrade", session.getAttribute("usergrade"));
		}

		System.out.println("[header.do] 세션 아이디 : " + uid);
		model.addAttribute("userid", uid);

		//내 장바구니 개수
		model.addAttribute("pickCount", dao.pickCount(uid));
		
		//검색어쿼리 있을 때
		model.addAttribute("search_query", (String) request.getParameter("query"));
		return "header";
	}

	//main.do
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String mainDo(Model model) {

		// 이벤트 목록 불러오기
		model.addAttribute("mainEventCount", dao.mainEventCount());
		model.addAttribute("mainEvents", dao.getMainEvents());

		// 베스트 게시물 불러오기
		model.addAttribute("bestBooks", dao.getBestBooks());

		// 신규 입고 도서 불러오기
		model.addAttribute("newBooks", dao.getNewBooks());

		// 최근 공지사항 불러오기
		model.addAttribute("notice", dao.getNotice());

		// 최근 댓글 불러오기
		model.addAttribute("newReplies", dao.getNewReplies());

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

		//전체 이벤트 개수 받아오기
		int total = dao.eventCount();

		int pagecount = ((total - 1) / maxcount) * maxcount + 1;

		if (page > pagecount)
			page = pagecount;
		System.out.println("전체페이지" + pagecount);

		int liststart = (page - 1) * maxcount + 1;
		int listend = liststart + maxcount - 1;

		int pagestart = ((page - 1) / maxcount) * maxcount + 1;
		int pageend = pagestart + 9;

		if (pageend > pagecount)
			pageend = pagecount;

		System.out.println(page);
		System.out.println(liststart + "~" + listend);

		model.addAttribute("events", dao.getEvents(liststart, listend));
		model.addAttribute("pagecount", pagecount);
		model.addAttribute("pagestart", pagestart);
		model.addAttribute("pageend", pageend);
		model.addAttribute("total", total);
		model.addAttribute("page", page);

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

	//이벤트 삭제
	@RequestMapping(value = "/deleteEvent.do")
	public String deleteEvent(@RequestParam("num") int num, Model model, HttpSession session) throws Exception {
		
		//권한 없는 계정 URL 직접 접근 차단
		String userid = (String) session.getAttribute("userid");
		
		if (userid == null) {
			return "redirect:/error.do?msg="+URLEncoder.encode("권한이 없습니다.", "UTF-8");
		} else {
			int grade = (Integer) session.getAttribute("usergrade");
			if (grade!=0)
				return "redirect:/error.do?msg="+URLEncoder.encode("권한이 없습니다.", "UTF-8");
		}
		
		
		dao.deleteEvent(num);
		
		return "redirect:/eventlist.do";
	}
}
