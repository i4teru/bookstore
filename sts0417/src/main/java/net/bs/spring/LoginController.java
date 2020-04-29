package net.bs.spring;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.RequestMethod;
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
	public String login_table(HttpSession session, Model model, HttpServletRequest request) throws Exception {

		String msg = request.getParameter("msg");
		if (msg == null)
			model.addAttribute("msg", "");
		else if (msg.equals("err"))
			model.addAttribute("msg", "로그인에 실패했습니다.<br>아이디와 비밀번호를 확인해주세요.");
		else
			model.addAttribute("msg", msg);

		if (session.getAttribute("userid") != null) {
			// 이미 로그인이 되어있으면
			return "redirect:/main.do";
		} else {
			return "login";
		}
	}

	@RequestMapping("/mypage.do")
	public String my_page(HttpSession session, HttpServletResponse response, Model model) throws Exception {
		if (session.getAttribute("userid") == null) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().append("<script>" + "alert('로그인 후에 이용가능합니다.');" + "</script>").flush();
			return "login";
		}
		String id = (String) session.getAttribute("userid");
		LoginDTO dto = dao.dbaccountdata(id);
		model.addAttribute("dto", dto);
		model.addAttribute("id", id);
		return "mypage";
	}

	@RequestMapping("/signupcomplete.do")
	public String signup_complete(LoginDTO dto) throws UnsupportedEncodingException {

		dao.dbAcInsert(dto);

		return "redirect:/signupfinish.do?username=" + URLEncoder.encode(dto.getName(), "UTF-8") + "&userid="
				+ dto.getId();
	}

	@RequestMapping("/signupfinish.do")
	public String signup_complete(@RequestParam("username") String name, @RequestParam("userid") String id,
			Model model) {

		model.addAttribute("uname", name);
		model.addAttribute("uid", id);

		return "signup_finish";
	}

	@RequestMapping("/logincheck.do")
	public String login_check(LoginDTO dto, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) throws Exception {
		response.setContentType("text/html; charset=utf-8");

		String result = dao.dblogin(dto);

		if (result == null) {
			// 로그인 실패시
			return "redirect:/login.do?msg=err";
		} else {
			// 로그인 성공시
			LoginDTO ldto = dao.dbaccountdata(result);
			session.setAttribute("userid", result);
			session.setAttribute("username", ldto.getName());
			session.setAttribute("usergrade", ldto.getGrade());
			System.out.println(ldto.getName() + " , " + ldto.getGrade());
			return "redirect:/main.do";
		}

	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session, HttpServletResponse response) throws IOException {

		session.invalidate();

		return "redirect:/main.do";
	}

	@RequestMapping("/idcheck.do")
	public void idcheck(@RequestParam String userid, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		int result = dao.dbcheckid(userid);
		String idchk = "";
		if (result > 0) {
			idchk = "X";
		} else {
			idchk = "O";
		}
		logger.info("userid: " + userid);
		logger.info("idchk: " + idchk);
		logger.info("result: " + result);
		PrintWriter out = response.getWriter();
		out.println(idchk);
	}

	@RequestMapping("/notice_save.do")
	public String notice_save(LoginDTO dto) {
		dao.dbnoticeInsert(dto);
		return "redirect:/notice.do";
	}

	@RequestMapping("/noticeup.do")
	public String notice_write() {
		return "notice_write";
	}

	@RequestMapping("/notice.do")
	public String notice_table(HttpServletRequest request, Model model) {
		String pnum = "";
		int pageNUM = 0, pagecount = 0;
		int start = 0, end = 0;
		int startpage = 0, endpage = 0;
		int total = 0;

		pnum = request.getParameter("pageNum");
		if (pnum == "" || pnum == null) {
			pnum = "1";
		}

		pageNUM = Integer.parseInt(pnum);
		total = dao.dbcountnotice();
		if (total == 0)
			total = 1;
		start = (pageNUM - 1) * 10 + 1;
		end = (pageNUM * 10);

		if (total % 10 == 0) {
			pagecount = total / 10;
		} else {
			pagecount = (total / 10) + 1;
		}
		int temp = (pageNUM - 1) % 10;
		startpage = pageNUM - temp;
		endpage = startpage + 9;
		logger.info("total: " + total);
		logger.info("pagecount: " + pagecount);
		logger.info("startpage: " + startpage);
		logger.info("endpage: " + endpage);
		logger.info("pageNUM: " + pageNUM);
		if (endpage > pagecount) {
			endpage = pagecount;
		}

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
		logger.info("notice_title: " + num);
		model.addAttribute("dto", dao.dbshownotice_detail(num));
		return "notice_detail";
	}

	@RequestMapping("/notice_edit.do")
	public String notice_edit(Model model, LoginDTO dto) {
		int num = dto.getNotice_num();
		logger.info("넘어온 번호" + num);
		logger.info("넘어온 제목" + dto.getNotice_title());
		logger.info("넘어온 데이터" + dto.getNotice_content());
		dao.dbupdatenotice(dto);
		return "redirect:/notice_detail.do?num=" + num;
	}

	@RequestMapping("/notice_delete.do")
	public String notice_delete(@RequestParam("num") int num) {
		dao.dbdeletenotice(num);
		return "redirect:/notice.do";
	}

	@RequestMapping("/editaccount.do")
	public String edit_account(LoginDTO dto) {
		dao.dbaccountedit(dto);
		return "login_head";
	}

}
