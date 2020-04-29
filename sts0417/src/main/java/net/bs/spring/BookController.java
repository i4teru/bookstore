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
	
	//���⼭���� ���Ǻ� ����Ʈ �߰� �۾�(0424 kjr)
	@RequestMapping("/bookSection1.do")
	public String book_Section1(HttpServletRequest request, Model model) {
		
		int maxcount = 10; //�� �������� ��µǴ� �Ǽ�
		int maxpage = 6; //�ִ� ������ ��ȣ ����(���� �Ѿ�� ȭ��ǥ ó��)
		
		//������ ��ȣ �޾ƿ���
		int page;
		try {
		page = 	Integer.parseInt(request.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}
		
		//���� 1�� ��ü å �� �޾ƿ��� 
		int total = dao.s1Count();
		
		//�� ��������ȣ ���� ���ϱ�
		int pagecount; 
		if(total%maxcount==0) {
			pagecount=total/maxcount;
		} else pagecount=total/maxcount+1;
		
		//������ �� ���ٰ� �� �Ʒ���
		int liststart = (page - 1) * maxcount + 1;
		int listend = liststart + maxcount - 1; 
		
		//���� ��������ȣ�� �� ��������ȣ
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
		//���� ��ȣ �޾ƿ���
		String scnum = request.getParameter("scnum");
		System.out.println("����#��: "+scnum);
		dto.setScnum(scnum);
		
		int maxcount = 10; //�� �������� ��µǴ� �Ǽ�
		int maxpage = 6; //�ִ� ������ ��ȣ ����(���� �Ѿ�� ȭ��ǥ ó��)
		
		//������ ��ȣ �޾ƿ���
		int page;
		try {
		page = 	Integer.parseInt(request.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}
				
		//�˻�ȭ�鿡�� ������ �� query���� �޾ƿ���
		String query = request.getParameter("query");
		if(query != null && query !="") {
			dto.setQuery(query);
		}
		
		//�ش缽���� ��ü å �� �޾ƿ��� 
		int total;
//		String query = dto.getQuery();
//		System.out.println(query);
//		if(scnum.equals("6")) { total = dao.scCount(scnum, dto.getQuery());
//		} else {total = dao.scCount(scnum);}
		total = dao.scCount(dto);
		System.out.println("����#��: "+scnum+" "+"�� �� ����"+total);
		
		//�� ��������ȣ ���� ���ϱ�
		int pagecount; 
		if(total%maxcount==0) {
			pagecount=total/maxcount;
		} else pagecount=total/maxcount+1;
		
		//������ �� ���ٰ� �� �Ʒ���
		int liststart = (page - 1) * maxcount + 1;
		int listend = liststart + maxcount - 1; 
		//���ǹ�ȣ, ����Ʈ���۹�ȣ, ����Ʈ����ȣ, �������� DTO�� �ֱ�
		dto.setListstart(liststart);
		dto.setListend(listend);
		
		//���� ��������ȣ�� �� ��������ȣ
		int pagestart = ((page - 1) / maxpage) * maxpage + 1;
		int pageend = pagestart + maxpage -1;

		if (pageend > pagecount)
			pageend = pagecount;
		
		//��������
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
	
	//===========å ������=========(0428 minji)
	
	@RequestMapping("/bookdetail.do")
	//public String book_detail( Model model) {
	//0425 �ӽ� idx �ּ�ó���ϰ� ���� �޾ƿ��°ɷ� ���� by kjr	
	public String book_detail(@RequestParam("idx") int data, Model model) {
		int idx=data;
		//int idx=1;  //����Ʈ�� ��ĥ�� idx�� �Ķ��Ÿ�� �� �޾ƿ;� ��(@RequestParam("idx")int idx, Model model)
		model.addAttribute("reply_cnt", dao.dbreplycnt(idx));
		model.addAttribute("staravg", dao.dbStaravg(idx));
		model.addAttribute("dto", dao.dbDetail(idx));
		return "bookDetail";
	}
	
}
