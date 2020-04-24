package net.bs.spring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	MainDAO dao;

	//main.do
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String mainDo(Model model) {

		// �ű� �԰� ���� �ҷ�����
		model.addAttribute("newBooks", dao.getNewBooks());

		return "main";
	}

	//�̺�Ʈ ������
	@RequestMapping(value = "/eventlist.do", method = RequestMethod.GET)
	public String eventList(Model model) {

		return "eventlist";
	}

	//�̺�Ʈ �ۼ� ������
	@RequestMapping(value = "/eventwrite.do", method = RequestMethod.GET)
	public String eventWrite(Model model) {

		return "eventwrite";
	}
}
