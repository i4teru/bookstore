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
	//BookDAO dao; //0426 by kjr 리뷰 달 때 bookinfo테이블에도 업데이트 하려고 추가
	
	private static final Logger logger = LoggerFactory.getLogger(BookReplyController.class);
	
	@RequestMapping(value="/replyInsert.do")
	public String reply_insert(BookReplyDTO dto) {
		rdao.dbInsert(dto);
		//int point = dto.getR_stars();
		//int data = dto.getBi_num();
		//dao.dbUpdate(point, data); //0426 by kjr 리뷰 저장 후에 bookinfo에 리뷰수랑 별점 업데이트	(실패)	
		
		//0425 by kjr 리뷰 저장 후에는 다시 해당 책의 디테일 페이지로 돌아오도록 idx값 지정해줌
		return "redirect:/bookdetail.do?idx="+dto.getBi_num();	
	}
	

	@RequestMapping(value="/reply_reInsert.do")
	public String reply_re_insert(BookReplyDTO dto) {
		rdao.dbReinsert(dto);
		return "redirect:/bookreply.do";
	}
	
	
	@RequestMapping(value="/bookreply.do")
	public String reply_select( BookReplyDTO dto , HttpServletRequest request, Model model) {
		//0425 bi_num 담기 위해서 data변수 추가 by kjr 
		//bookdetail.do에서 bookreply.do를 import했기 때문에 idx값(bi_num) 그대로 받아서 쓸 수 있음
		int data = Integer.parseInt(request.getParameter("idx")); //bi_num
		int replycnt = rdao.dbReplycnt();  //리뷰(댓글)의 갯수 @RequestParam("bi_num") int bi_num,와 괄호에 bi_num 넣어줄 것
		int replycount = rdao.dbReplycount();
		
		String pnum;
		int pageNUM, pagecount;
		int start, end;
		int startpage, endpage;
		int temp;
		
		pnum=request.getParameter("pageNum");
		
		if(pnum == "" || pnum == null) {
			pnum = "1";
		}
		
		pageNUM = Integer.parseInt(pnum);
		
		start = (pageNUM-1)*10+1;
		end = pageNUM*10;
		
		if(replycnt%10==0) {
			pagecount = replycnt/10;
		}else {
			pagecount = (replycnt/10)+1; 
		}
		
		temp = (pageNUM-1) % 10;
		
		startpage = pageNUM - temp;
		endpage = startpage + 9;
		
		if(endpage > pagecount) {
			endpage = pagecount;
		}
		
		List<BookReplyDTO> BR = rdao.dbSelect(start, end, data);
		model.addAttribute("replycount",replycount);
		model.addAttribute("replycnt",replycnt);
		model.addAttribute("pagecount",pagecount);
		model.addAttribute("startpage",startpage);
		model.addAttribute("endpage", endpage);
		model.addAttribute("pageNUM", pageNUM);
		model.addAttribute("BR", BR);
		return "book_reply";
	}
	
	@RequestMapping(value="/replyDelete.do")
	public String reply_delete(@RequestParam("ridx") int ridx) {
		rdao.dbDelete(ridx);
		return "redirect:/bookdetail.do";
		//return "bookDetail";
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


