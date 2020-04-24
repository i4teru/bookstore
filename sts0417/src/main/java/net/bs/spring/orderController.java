package net.bs.spring;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
public class orderController {

	private static final Logger logger = LoggerFactory.getLogger(orderController.class);

	// dao개체연결
	@Inject
	@Autowired
	orderDAO dao;
	@Autowired
	pickitemDAO pdao;

	@Autowired
	private ServletContext application;
	
	@RequestMapping(value = "/order.do", method = RequestMethod.GET)
	public String order(orderDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		 int ok = dao.dbRcnt(userid);
		 System.out.println("ok= "+ok);
		 if (ok <= 0) {
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			 Date date = new Date();
			 String ordernum = sdf.format(date);
			 String orderstatus = "is";
			 
			 System.out.println(ordernum);
			 dto.setOrdernum(ordernum);
			 dto.setOrderstatus(orderstatus);
			 
			 System.out.println(dto.getOrdernum());
			 System.out.println(dto.getUserid());
			 
			 dao.dbRinsert(dto);
			 dao.dbPinsert(dto);
		 }
		return "redirect:/orderDetail.do";
	}

	@RequestMapping("/orderList.do")
	public String orderList(Model model, HttpServletRequest request, @RequestParam("checkItem") int[] bnum) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");

		ArrayList<pickitemDTO> list = new ArrayList<pickitemDTO>();
		for (int i = 0; i < bnum.length; i++) {
			pickitemDTO dto = new pickitemDTO();
			dto.setBnum(bnum[i]);
			dto.setUserid(userid);

			list.add(dto);
		}

		
		model.addAttribute("order", dao.dbPreList(list));
		model.addAttribute("userid", userid);
		model.addAttribute("login", dao.loginDetail(userid));

		return "orderList";
	}
	
	@RequestMapping("/orderDetail.do")
	public String orderDetail(Model model) {
		
		model.addAttribute("od", dao.dbselectAll());
		return "orderDetail";
	}
	
	@RequestMapping("/orderDetail2.do")
	public String orderDetail2(Model model) {
		
		return "orderDetail2";
	}

}//class END
