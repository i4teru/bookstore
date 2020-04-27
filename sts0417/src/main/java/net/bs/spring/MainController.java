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
import javax.servlet.http.HttpSession;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	MainDAO dao;
	@Autowired
	private ServletContext application;

	//header.do
	@RequestMapping(value = "/header.do", method = RequestMethod.GET)
	public String header(HttpSession session, Model model) {

		String uid = (String) session.getAttribute("userid");
		if (uid == null)
			uid = "";
		else {
			//�α����������� ��ް� �̸� ���ǿ� ���
			model.addAttribute("username", (String) session.getAttribute("username"));
			model.addAttribute("usergrade", session.getAttribute("usergrade"));
		}

		System.out.println("[header.do] ���� ���̵� : " + uid);
		model.addAttribute("userid", uid);

		return "header";
	}

	//main.do
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String mainDo(Model model) {

		// �̺�Ʈ ��� �ҷ�����
		model.addAttribute("mainEventCount", dao.mainEventCount());
		model.addAttribute("mainEvents", dao.getMainEvents());

		// �ű� �԰� ���� �ҷ�����
		model.addAttribute("newBooks", dao.getNewBooks());

		return "main";
	}

	//�̺�Ʈ ������
	@RequestMapping(value = "/eventlist.do", method = RequestMethod.GET)
	public String eventList(HttpServletRequest request, Model model) {

		int maxcount = 10; // ǥ�� ����

		//������ ��ȣ �޾ƿ���
		int page;
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (Exception e) {
			page = 1;
		}

		//��ü �̺�Ʈ ���� �޾ƿ���
		int total = dao.eventCount();

		int pagecount = ((total - 1) / maxcount) * maxcount + 1;

		if (page > pagecount)
			page = pagecount;
		System.out.println("��ü������" + pagecount);

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

	//�̺�Ʈ �ۼ� ������
	@RequestMapping(value = "/eventwrite.do", method = RequestMethod.GET)
	public String eventWrite(Model model) {

		return "eventwrite";
	}

	//�̺�Ʈ �ۼ� ó��
	@RequestMapping(value = "/insertEvent.do", method = RequestMethod.POST)
	public String insertEvent(MultipartFile file, EventDTO edto) {

		String path = application.getRealPath("/resources/event");
		String image = file.getOriginalFilename();
		System.out.println(image);
		//���ϸ� �ߺ�üũ
		String filename = image;
		int i = 0;
		while (!dao.checkImage(filename)) {
			i++;
			filename = i + image;
		}
		image = filename;

		File destFile = new File(path, image); // ��ο� ���� ����
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
