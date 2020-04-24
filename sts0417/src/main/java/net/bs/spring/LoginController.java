package net.bs.spring;

import java.io.IOException;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String login_table() {
		return "login";
	}

	@RequestMapping("/signupcomplete.do")
	public String signup_complete(LoginDTO dto) {
		logger.info("넘어온 아이디" + dto.getId());
		logger.info("넘어온 비밀번호" + dto.getPassword());
		logger.info("넘어온 데이터" + dto.getEmail());
		logger.info("넘어온 데이터" + dto.getZipcode());
		logger.info("넘어온 데이터" + dto.getAddress1());
		logger.info("넘어온 데이터" + dto.getAddress2());
		logger.info("넘어온 데이터" + dto.getPhone());
		logger.info("넘어온 생년월일" + dto.getBirthday());
		logger.info("넘어온 성별" + dto.getGender());
		dao.AcInsert(dto);
		logger.info("%사용자 생성 완료%");
		return "signup_finish";
	}

	@RequestMapping("/logincheck.do")
	public String login_check(LoginDTO dto, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("입력된 아이디" + dto.getId());
		logger.info("입력된 비밀번호" + dto.getPassword());

		String result = dao.login(dto);
		logger.info("로그인된 아이디는" + result);
		session.setAttribute("userid", result);

		if (result == null || result == "" || result.equals("")) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().append(
					"<script>" + "alert('LoginController 아이디,비번 일치하지않습니다');" + "window.history.back();" + "</script>")
					.flush();
			return "redirect:/login.do";
		}
		return "login_finish";
	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session, HttpServletResponse response) throws IOException {
		session.invalidate();
		response.setContentType("text/html; charset=utf-8");
		response.getWriter().append(
				"<script>" + "alert('logout 로그아웃 되었습니다');"+ "location.href='login_head.do'" +"</script>")
				.flush();
		logger.info("로그아웃되었습니다.");
		return "login_head";
	}

	@RequestMapping("/idcheck.do")
	public void idcheck(@RequestParam String userid, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		int result = dao.checkid(userid);
		String idchk = "";
		if (result > 0) {
			idchk = "X";
		} else {
			idchk = "O";
		}
		logger.info("userid: "+ userid );
		logger.info("idchk: " + idchk);
		logger.info("result: "+result);
		PrintWriter out = response.getWriter();
		out.println(idchk);
	}

}
