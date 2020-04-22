package net.bs.spring;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class BookController {
	
	private static final Logger logger = LoggerFactory.getLogger(BookController.class);

	@Autowired
	BookDAO dao;
	
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "bookInsert";
	}
	
	@RequestMapping("/bookRegister.do")
	public String book_register(@RequestParam("msg") String data, Model model) {
		String msg = data;
		if(data=="" || data==null) {
			msg = "notyet";
		}
		model.addAttribute("msg", msg);
		return "bookInsert";
	}
	
	@RequestMapping("/bookInsert.do")
	public String book_Insert(BookinfoDTO dto) {
		System.out.println(dto.getBi_title());
		dao.dbInsert(dto);
		return "redirect:bookRegister.do?msg=insertok";
		//return "bookInsert_test";
	}
	
}
