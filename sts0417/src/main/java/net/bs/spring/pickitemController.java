package net.bs.spring;


import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class pickitemController {
	
	private static final Logger logger = LoggerFactory.getLogger(pickitemController.class);
	
	//dao개체연결
	@Inject 
	@Autowired
	pickitemDAO dao;
	@Autowired
	private ServletContext application;
	
	@RequestMapping("/pickInsert.do")
	public String pick(HttpServletRequest request, pickitemDTO dto) { //0427 by kjr 장바구니에 넣으려고 수정
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userid");
		String isbn = request.getParameter("idx");
		int bnum = Integer.parseInt(request.getParameter("nidx"));
		String status = request.getParameter("sidx");
		//System.out.println(dto.getAmount()+", "+id);
		dto.setUserid(id);
		dto.setIsbn(isbn);
		dto.setBnum(bnum);
		dto.setStatus(status);
		
		dao.dbInsert(dto);
		return "redirect:/pickList.do";
	}
	
	@RequestMapping("/pickList.do")
	public String pickList(Model model, HttpServletRequest request) {
		int start, end, startpage, endpage, temp, pagecount;		
//		String pnum = request.getParameter("pageNum");
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("userid");
		
//		if(pnum == null || pnum == "" || pnum.equals("")) {pnum = "1";}
//		int pageNUM = Integer.parseInt(pnum);
		
		pickitemDTO dto = new pickitemDTO();	
		int total = dao.dbCount(userid);
		System.out.println(total);
		
//		if(total%5 == 0) {pagecount = total/5;}
//		else {pagecount = (total/5) + 1;}
//		
//		start = (pageNUM-1)*5+1;
//		end = start*5;
//		temp=(pageNUM-1)%5;
//		startpage = pageNUM-temp;
//		endpage = startpage + 4;
//		
//		if(endpage>pagecount) {endpage = pagecount;}	
		
		end = total;
		
//		dto.setStart(start);
		dto.setEnd(end);
		dto.setUserid(userid);
//		System.out.println(startpage);
		model.addAttribute("pick", dao.dbPickList(dto));
//		model.addAttribute("pageNUM", pageNUM);
//		model.addAttribute("startpage", startpage);
//		model.addAttribute("endpage", endpage);
//		model.addAttribute("pagecount", pagecount);
		
		return "pickList"; 
	}//end
	
	@RequestMapping("/checkDel.do")
	public String checkDel(HttpServletRequest request, @RequestParam("checkItem") int[] bnum, @RequestParam("userid") String[] userid, @RequestParam("amount") int[] amount) {
		HttpSession session = request.getSession();
		pickitemDTO dto = new pickitemDTO();
		
		for (int s : bnum) {
			System.out.println(s);
			dto.setBnum(s); 
		}
		for (String u : userid) {
			System.out.println(u);
			dto.setUserid(u);
		}
			
		for (int a : amount) {
			System.out.println("amount : "+a);
			if(a>1) {
				dao.dbpickDel2(dto); break;
			}
			else if(a<2) {dao.dbPickDel(dto);}
		}
		return "redirect:/pickList.do";
	}
	
	
}//pickitemController class END

