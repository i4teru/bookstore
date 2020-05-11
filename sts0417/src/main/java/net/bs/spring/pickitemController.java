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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	//0429 by kjr 장바구니에 넣기 전에 이미 항목이 있는지 체크하도록 수정
	@RequestMapping("/pickInsert.do")
	public String pre_insert(HttpServletRequest request, pickitemDTO dto) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userid");
		String isbn = request.getParameter("idx");
		int bnum = Integer.parseInt(request.getParameter("nidx"));
		String status = request.getParameter("sidx");
		
		dto.setUserid(id);
		dto.setIsbn(isbn);
		dto.setBnum(bnum);
		dto.setStatus(status);
		
		int chk;
		chk = dao.chkCart(bnum);
		System.out.println("chk="+chk);
		if(chk == 0) {
			dao.dbInsert(dto);		
		} else { dao.dbUpdate(dto); }
		
		return "redirect:/pickList.do";
	}
	
	//0502 장바구니에 여러개 추가하기 기능 구현
	@RequestMapping("/multiInsert.do")
	@ResponseBody
	public void multi_insert(HttpServletRequest request, @RequestBody pickitemDTO[] jsonArr) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userid");
		
		for(pickitemDTO dto: jsonArr) {
			pickitemDTO vo = new pickitemDTO();
			vo.setUserid(id);
			vo.setAmount(1);
			int bnum = dto.getBnum();
			vo.setBnum(bnum);
			vo.setIsbn(dto.getIsbn());
			vo.setStatus(dto.getStatus());
			
			int chk;
			chk = dao.chkCart(bnum);
			if(chk == 0) {
				dao.dbInsert(vo);		
			} else { dao.dbUpdate(vo); }
		}
		//return "redirect:/pickList.do";
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
	public String checkDel(HttpServletRequest request, @RequestParam("checkItem") int[] bnum,
			@RequestParam("amount") int[] amount) {
		HttpSession session = request.getSession();
		pickitemDTO dto = new pickitemDTO();
		String userid = (String) session.getAttribute("userid");
		dto.setUserid(userid);
		
		for (int i=0; i<bnum.length;i++) {
			
			dto.setBnum(bnum[i]);
			dto.setAmount(amount[i]);
		
			dao.dbPickDel(dto);		
		}
		return "redirect:/pickList.do";
	}
	
	
}//pickitemController class END

