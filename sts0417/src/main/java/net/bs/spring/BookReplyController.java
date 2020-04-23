package net.bs.spring;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class BookReplyController {

	@Autowired
	BookReplyDAO rdao;
	
	private static final Logger logger = LoggerFactory.getLogger(BookReplyController.class);
	
	@RequestMapping(value="/replyInsert.do")
	public String reply_insert(BookReplyDTO dto) {
		rdao.dbInsert(dto);
		return "redirect:/bookreply.do";	
	}
	
	@RequestMapping(value="/bookreply.do")
	public String reply_select(  BookReplyDTO dto ,Model model) {
		int replycnt = rdao.dbReplycnt();  //¸®ºä(´ñ±Û)ÀÇ °¹¼ö @RequestParam("bi_num") int bi_num,¿Í °ýÈ£¿¡ bi_num ³Ö¾îÁÙ °Í
		List<BookReplyDTO> BR = rdao.dbSelect(dto);		
		model.addAttribute("replycnt",replycnt);
		model.addAttribute("BR", BR);
		return "book_reply";
	}
	
	@RequestMapping(value="/replyDelete.do")
	public String reply_delete(@RequestParam("ridx") int ridx) {
		rdao.dbDelete(ridx);
		return "redirect:/bookreply.do";
	}
	
	/*@RequestMapping(value="/replypreEdit.do")
	public String reply_preedit(@RequestParam("ridx") int ridx) {
		return "replyEdit.do";
	}*/
	
	@RequestMapping(value="/replyEdit.do")
	public String reply_edit(@RequestParam("r_num") int r_num, @RequestParam("r_stars") int r_stars, @RequestParam("r_content") String r_content) {
		BookReplyDTO dto = new BookReplyDTO();
		dto.setR_num(r_num);
		dto.setR_stars(r_stars);
		dto.setR_content(r_content);
		rdao.dbEdit(dto);
		return "bookreply.do";
	}
	
	@RequestMapping(value="/replyHit.do")
	public String reply_hit( @RequestParam("ridx") int ridx) {
		rdao.dbHit(ridx);
		return "redirect:/bookreply.do";
	}
	
	
}//BoardReplyController class END


