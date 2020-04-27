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

	// dao��ü����
	@Inject
	@Autowired
	orderDAO dao;
	@Autowired
	pickitemDAO pdao;

	@Autowired
	private ServletContext application;

	@RequestMapping(value = "/order.do", method = RequestMethod.GET)
	public String order(Model model, orderDTO dto, HttpServletRequest request, @RequestParam("p_bnum") int[] p_bnum,
			@RequestParam("p_amount") int[] p_amount, @RequestParam("p_price") int[] p_price,
			@RequestParam("tprice") int tprice, @RequestParam("tamount") int tamount) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String ordernum = sdf.format(date);
		String orderstatus = "Ȯ�ο���";

		int oseq = dao.dbGetOseq();

		dto.setOrdernum(ordernum + oseq);
		dto.setOrderstatus(orderstatus);
		dto.setTotalamount(tamount);
		dto.setTotalprice(tprice);
		
		// purchase���̺� ����
		dao.dbPinsert(dto);

		ArrayList<orderDTO> list = new ArrayList<orderDTO>();
		for (int i = 0; i < p_bnum.length; i++) {
			orderDTO odto = new orderDTO();
			odto.setOrdernum(ordernum + oseq);
			odto.setP_bnum(p_bnum[i]);
			odto.setP_amount(p_amount[i]);
			odto.setP_price(p_price[i]);
			System.out.println("detail p_bnum : " + odto.getP_bnum());
			list.add(odto);
		}
		// ��ٱ��Ͽ��� ���õ� ���̵� purchasedetail���̺� ����(�ֹ�����)
		dao.dbPdetailInsert(list);

		model.addAttribute("ordernum", dto.getOrdernum());
	

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
		// �ֹ� �� ��ٱ��Ͽ� ���õ� ���̵� �����ֱ�(purchase ���̺� ����Ʈ ���)
		model.addAttribute("order", dao.dbPreList(list));
		model.addAttribute("userid", userid);
		// �α��� ���������� �ֹ��������� ������� �ڵ����
		model.addAttribute("login", dao.loginDetail(userid));

		return "orderList";
	}

	@RequestMapping("/orderDetail.do")
	public String orderDetail(Model model, HttpServletRequest request) {
		orderDTO dto = new orderDTO();
		String ordernum = request.getParameter("ordernum");
		dto.setOrdernum(ordernum);		
		
		// �ֹ���ȣ�� �ֹ�����, ����, ��������� ���(purchase)
		model.addAttribute("od", dao.dbselectAll(dto.getOrdernum()));
		
		return "orderDetail";
	}

	@RequestMapping("/orderDetail2.do")
	public String orderDetail2(Model model, HttpServletRequest request) {
		// �ֹ��������
		String ordernum = request.getParameter("ordernum");
		orderDTO dto = new orderDTO();
		dto.setOrdernum(ordernum);
		
		model.addAttribute("detail", dao.dbPdetail(dto.getOrdernum()));
		return "orderDetail2";
	}

}// class END
