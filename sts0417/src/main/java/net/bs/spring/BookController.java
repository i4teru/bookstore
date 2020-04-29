package net.bs.spring;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

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
	
	//여기서부터 섹션별 리스트 추가 작업(0424 kjr)
	@RequestMapping("/bookSection1.do")
	public String book_Section1(HttpServletRequest request, Model model) {
		
		int maxcount = 10; //한 페이지에 출력되는 권수
		int maxpage = 6; //최대 페이지 번호 갯수(범위 넘어가면 화살표 처리)
		
		//페이지 번호 받아오기
		int page;
		try {
		page = 	Integer.parseInt(request.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}
		
		//섹션 1의 전체 책 수 받아오기 
		int total = dao.s1Count();
		
		//총 페이지번호 갯수 구하기
		int pagecount; 
		if(total%maxcount==0) {
			pagecount=total/maxcount;
		} else pagecount=total/maxcount+1;
		
		//페이지 맨 윗줄과 맨 아랫줄
		int liststart = (page - 1) * maxcount + 1;
		int listend = liststart + maxcount - 1; 
		
		//시작 페이지번호와 끝 페이지번호
		int pagestart = ((page - 1) / maxpage) * maxpage + 1;
		int pageend = pagestart + maxpage -1;

		if (pageend > pagecount)
			pageend = pagecount;
		
		String sort = request.getParameter("sort");
		List<BookinfoDTO> S1L = dao.sc1SelectAll(liststart, listend, sort);
		model.addAttribute("S1L", S1L);
		model.addAttribute("S1Total", total);
		model.addAttribute("page", page);
		model.addAttribute("pagestart", pagestart);
		model.addAttribute("pageend", pageend);
		model.addAttribute("pagecount", pagecount);
		model.addAttribute("sort", sort);
		
		return "bookSection1";
	}
	
	@RequestMapping("/bookSection.do")
	public String book_Section(HttpServletRequest request, Model model, BookinfoDTO dto) {
		//섹션 번호 받아오기
		String scnum = request.getParameter("scnum");
		System.out.println("섹션#는: "+scnum);
		dto.setScnum(scnum);
		
		int maxcount = 10; //한 페이지에 출력되는 권수
		int maxpage = 6; //최대 페이지 번호 갯수(범위 넘어가면 화살표 처리)
		
		//페이지 번호 받아오기
		int page;
		try {
		page = 	Integer.parseInt(request.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}
				
		//검색화면에서 정렬할 때 query조건 받아오기
		String query = request.getParameter("query");
		if(query != null && query !="") {
			dto.setQuery(query);
		}
		
		//해당섹션의 전체 책 수 받아오기 
		int total;
//		String query = dto.getQuery();
//		System.out.println(query);
//		if(scnum.equals("6")) { total = dao.scCount(scnum, dto.getQuery());
//		} else {total = dao.scCount(scnum);}
		total = dao.scCount(dto);
		System.out.println("섹션#는: "+scnum+" "+"총 권 수는"+total);
		
		//총 페이지번호 갯수 구하기
		int pagecount; 
		if(total%maxcount==0) {
			pagecount=total/maxcount;
		} else pagecount=total/maxcount+1;
		
		//페이지 맨 윗줄과 맨 아랫줄
		int liststart = (page - 1) * maxcount + 1;
		int listend = liststart + maxcount - 1; 
		//섹션번호, 리스트시작번호, 리스트끝번호, 정렬조건 DTO에 넣기
		dto.setListstart(liststart);
		dto.setListend(listend);
		
		//시작 페이지번호와 끝 페이지번호
		int pagestart = ((page - 1) / maxpage) * maxpage + 1;
		int pageend = pagestart + maxpage -1;

		if (pageend > pagecount)
			pageend = pagecount;
		
		//정렬조건
		String sort = request.getParameter("sort");
		dto.setSort(sort);
				
		//List<BookinfoDTO> SL = dao.scSelectAll(scnum, liststart, listend, sort);
		List<BookinfoDTO> SL = dao.scSelectAll(dto);
		model.addAttribute("SL", SL);
		model.addAttribute("STotal", total);
		model.addAttribute("page", page);
		model.addAttribute("pagestart", pagestart);
		model.addAttribute("pageend", pageend);
		model.addAttribute("pagecount", pagecount);
		model.addAttribute("sort", sort);
		model.addAttribute("scnum",scnum);
		model.addAttribute("query", query);
		return "bookSection";
	}
	
	//===========책 디테일=========(0428 minji)
	
	@RequestMapping("/bookdetail.do")
	//public String book_detail( Model model) {
	//0425 임시 idx 주석처리하고 직접 받아오는걸로 수정 by kjr	
	public String book_detail(@RequestParam("idx") int data, Model model) {
		int idx=data;
		//int idx=1;  //리스트랑 합칠때 idx는 파라메타로 값 받아와야 함(@RequestParam("idx")int idx, Model model)
		model.addAttribute("reply_cnt", dao.dbreplycnt(idx));
		model.addAttribute("staravg", dao.dbStaravg(idx));
		model.addAttribute("dto", dao.dbDetail(idx));
		return "bookDetail";
	}
	
}
