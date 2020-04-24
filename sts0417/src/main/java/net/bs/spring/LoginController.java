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
		logger.info("�Ѿ�� ���̵�" + dto.getId());
		logger.info("�Ѿ�� ��й�ȣ" + dto.getPassword());
		logger.info("�Ѿ�� ������" + dto.getEmail());
		logger.info("�Ѿ�� ������" + dto.getZipcode());
		logger.info("�Ѿ�� ������" + dto.getAddress1());
		logger.info("�Ѿ�� ������" + dto.getAddress2());
		logger.info("�Ѿ�� ������" + dto.getPhone());
		logger.info("�Ѿ�� �������" + dto.getBirthday());
		logger.info("�Ѿ�� ����" + dto.getGender());
		dao.AcInsert(dto);
		logger.info("%����� ���� �Ϸ�%");
		return "signup_finish";
	}

	@RequestMapping("/logincheck.do")
	public String login_check(LoginDTO dto, HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("�Էµ� ���̵�" + dto.getId());
		logger.info("�Էµ� ��й�ȣ" + dto.getPassword());

		String result = dao.login(dto);
		logger.info("�α��ε� ���̵��" + result);
		session.setAttribute("userid", result);

		if (result == null || result == "" || result.equals("")) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().append(
					"<script>" + "alert('LoginController ���̵�,��� ��ġ�����ʽ��ϴ�');" + "window.history.back();" + "</script>")
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
				"<script>" + "alert('logout �α׾ƿ� �Ǿ����ϴ�');"+ "location.href='login_head.do'" +"</script>")
				.flush();
		logger.info("�α׾ƿ��Ǿ����ϴ�.");
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
