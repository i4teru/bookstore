package net.bs.spring;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@Autowired
	LoginDAO dao;

	@RequestMapping("loginhead.do")
	public String goto_main() {
		return "loginhead";
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
		logger.info("�Ѿ�� ���̵�"+ dto.getId());
		logger.info("�Ѿ�� ��й�ȣ"+ dto.getPassword());
		logger.info("�Ѿ�� ������"+ dto.getEmail());
		logger.info("�Ѿ�� ������"+ dto.getLocation());
		logger.info("�Ѿ�� ������"+ dto.getPhone());
		logger.info("�Ѿ�� �������"+ dto.getBirthday());
		logger.info("�Ѿ�� ����"+ dto.getGender());
		dao.AcInsert(dto);
		logger.info("%����� ���� �Ϸ�%");
		return "signup_finish";
	}
	
	@RequestMapping("/logincheck.do")
	public String login_check(LoginDTO dto , HttpServletResponse response, HttpSession session)	throws Exception {
		logger.info("�Էµ� ���̵�"+dto.getId());
		logger.info("�Էµ� ��й�ȣ"+dto.getPassword());
		
		String result=dao.login(dto);	
		logger.info("�α��ε� ���̵��" + result);
		session.setAttribute("userid", result);
				
		if(result==null || result=="" || result.equals("") ){
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().append("<script>"
				   + "alert('LoginController ���̵�,��� ��ġ�����ʽ��ϴ�');"
				   + "window.history.back();"
				   + "</script>").flush();
		return "redirect:/login.do";
		}
	return "login_finish";
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate(); 
		logger.info("�α׾ƿ��Ǿ����ϴ�.");
		return "loginhead";
	}
	
}
