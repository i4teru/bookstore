package net.bs.spring;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@Inject
	@Autowired
	LoginDAO dao;

	@RequestMapping("login_head.do")
	public String goto_main() {
		return "login_head";
	}

	@RequestMapping("/signup.do")
	public String signup_table() {
		return "SignUp";
	}

	@RequestMapping("/login.do")
	public String login_table(HttpSession session, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=utf-8");
		if(session.getAttribute("userid")!=null) {
			response.getWriter().append(
					"<script>" + "alert('�̹� �α��� �Ǿ��ֽ��ϴ�, ���� �α׾ƿ� �Ͻʽÿ�');" + "window.history.back();" + "</script>")
					.flush();
			return "redirect:/login_head.do";
		}else {
		return "login";
		}
	}

	@RequestMapping("/noticeup.do")
	public String notice_write() {
		return "notice_write";
	}
	
	@RequestMapping("/mypage.do")
	public String my_page(HttpSession session, HttpServletResponse response, Model model) throws Exception {
		if(session.getAttribute("userid")==null) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().append(
					"<script>" + "alert('�α��� �Ŀ� �̿밡���մϴ�.');" + "</script>")
					.flush();
			return "login";
		}
		String id=(String)session.getAttribute("userid");
		LoginDTO dto = dao.dbaccountdata(id);
		model.addAttribute("dto", dto);
		model.addAttribute("id", id);
		return "mypage";
	}

	@RequestMapping("/signupcomplete.do")
	public String signup_complete(LoginDTO dto) {
		logger.info("�Ѿ�� �̸�" + dto.getName());
		logger.info("�Ѿ�� ���̵�" + dto.getId());
		logger.info("�Ѿ�� ��й�ȣ" + dto.getPassword());
		logger.info("�Ѿ�� ������" + dto.getEmail());
		logger.info("�Ѿ�� ������" + dto.getZipcode());
		logger.info("�Ѿ�� ������" + dto.getAddress1());
		logger.info("�Ѿ�� ������" + dto.getAddress2());
		logger.info("�Ѿ�� ������" + dto.getPhone());
		logger.info("�Ѿ�� �������" + dto.getBirthday());
		logger.info("�Ѿ�� ����" + dto.getGender());
		dao.dbAcInsert(dto);
		logger.info("%����� ���� �Ϸ�%");
		return "signup_finish";
	}

	@RequestMapping("/logincheck.do")
	public String login_check(LoginDTO dto, HttpServletResponse response, HttpSession session) throws Exception {
		response.setContentType("text/html; charset=utf-8");
		logger.info("�Էµ� ���̵�" + dto.getId());
		logger.info("�Էµ� ��й�ȣ" + dto.getPassword());

		String result = dao.dblogin(dto);
		logger.info("�α��ε� ���̵��" + result);
		session.setAttribute("userid", result);

		if (result == null || result == "" || result.equals("")) {
			response.getWriter().append(
					"<script>" + "alert('���̵�,��� ��ġ�����ʽ��ϴ�. �ٽ��Է��Ͻʽÿ�');" + "window.history.back();" + "</script>")
					.flush();
			return "redirect:/login.do";
		}
		return "login_finish";
	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");
		session.invalidate();
		response.getWriter().append("<script>" + "alert('�α׾ƿ� �Ǿ����ϴ�');" + "location.href='login_head.do'" + "</script>")
				.flush();
		logger.info("�α׾ƿ��Ǿ����ϴ�.");
		return "login_head";
	}

	@RequestMapping("/idcheck.do")
	public void idcheck(@RequestParam String userid, HttpServletRequest request, HttpServletResponse response) throws IOException {
		int result = dao.dbcheckid(userid);
		String idchk = "";
		if (result > 0) { idchk = "X"; }
		else { idchk = "O"; }
		logger.info("userid: " + userid);
		logger.info("idchk: " + idchk);
		logger.info("result: " + result);
		PrintWriter out = response.getWriter();
		out.println(idchk);
	}

	@RequestMapping("/notice_save.do")
	public String notice_save(LoginDTO dto) {
		logger.info("title: ", dto.getNotice_title());
		logger.info("content: ", dto.getNotice_content());
		dao.dbnoticeInsert(dto);
		return "notice_finish";
	}

	@RequestMapping("/notice.do")
	public String notice_table(HttpServletRequest request, Model model) {
		String pnum="";
		int pageNUM=0, pagecount=0;
		int start=0, end=0;
		int startpage=0, endpage=0;
		int total=0;
		
		pnum=request.getParameter("pageNum");
		if(pnum==""||pnum==null) { pnum="1"; }
		
		pageNUM = Integer.parseInt(pnum);
		total=dao.dbcountnotice();
		start=(pageNUM-1)*10+1;
		end=(pageNUM*10);
		
		if(total%10==0) { pagecount=total/10; }
		else { pagecount=(total/10)+1; }
		int temp =(pageNUM-1)%10;
		startpage=pageNUM-temp;
		endpage=startpage+9;
		logger.info("total: "+total);
		logger.info("pagecount: "+pagecount);
		logger.info("startpage: "+startpage);
		logger.info("endpage: "+endpage);
		logger.info("pageNUM: "+pageNUM);
		if(endpage>pagecount) { endpage=pagecount;}
		
		List<LoginDTO> list = dao.dbshownotice(start, end);
		model.addAttribute("list", list);
		model.addAttribute("total", total);
		model.addAttribute("pageNUM", pageNUM);
		model.addAttribute("start", start);
		model.addAttribute("end", end);
		model.addAttribute("startpage", startpage);
		model.addAttribute("endpage", endpage);
		model.addAttribute("pagecount", pagecount);
		return "notice_table";
	}
	
	@RequestMapping("/notice_detail")
	public String notice_detail(Model model, HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		logger.info("notice_title: "+num);
		model.addAttribute("dto", dao.dbshownotice_detail(num));
		return "notice_detail";
	}
	
	@RequestMapping("/notice_edit.do")
	public String notice_edit(Model model, LoginDTO dto) {
		int num=dto.getNotice_num();
		logger.info("�Ѿ�� ��ȣ" + num);
		logger.info("�Ѿ�� ����" + dto.getNotice_title());
		logger.info("�Ѿ�� ������" + dto.getNotice_content());
		dao.dbupdatenotice(dto);
		return "redirect:/notice_detail.do?num=" + num;
	}
	
	@RequestMapping("/notice_delete.do")
	public String notice_delete(@RequestParam("num") int num ) {
		dao.dbdeletenotice(num);
		return "redirect:/notice.do";
	}
	
	@RequestMapping("/editaccount.do")
	public String edit_account(LoginDTO dto) {
		dao.dbaccountedit(dto);
		return "login_head";
	}
	
	
}
