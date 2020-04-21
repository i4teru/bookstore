package net.bs.spring;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class BookReplyController {

	@Autowired
	BookReplyDAO rdao;
	
	private static final Logger logger = LoggerFactory.getLogger(BookReplyController.class);
	
	@RequestMapping(value="/bookreply.do")
	public String reply_insert(BookReplyDTO dto) {
		return "book_reply";
		
	}//end
	
	
}//BoardReplyController class END


