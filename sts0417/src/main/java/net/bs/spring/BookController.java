package net.bs.spring;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
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
			msg = "new";
		}
		model.addAttribute("msg", msg);
		return "bookInsert";  
	}
	
	@RequestMapping("/bookInsert.do")
	public String book_insert(BookinfoDTO dto) {
		System.out.println(dto.getBi_title());
		dao.dbInsert(dto);
		return "redirect:bookRegister.do?msg=insertok";
		//return "bookInsert_test";
	}
	
	@RequestMapping("/bookList.do")
	public String book_List(Model model) {
		List<BookinfoDTO> Sc1 = dao.sc1Select();
		List<BookinfoDTO> Sc2 = dao.sc2Select();
		List<BookinfoDTO> Sc3 = dao.sc3Select();
		List<BookinfoDTO> Sc4 = dao.sc4Select();     
		List<BookinfoDTO> Sc5 = dao.sc5Select();
		model.addAttribute("Sc1", Sc1);
		model.addAttribute("Sc2", Sc2);
		model.addAttribute("Sc3", Sc3);
		model.addAttribute("Sc4", Sc4);
		model.addAttribute("Sc5", Sc5);
		model.addAttribute("RBTotal", dao.rbCount());
		return "bookList";
	}
	
}
