package net.bs.spring;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class LoginInterceptor extends HandlerInterceptorAdapter {

   private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
   
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String userid= (String)session.getAttribute("userid");	
		System.out.println("LoginInterceptor인셉 세션=" + userid);
		
		
		String uri = request.getRequestURI();
		 System.out.println("LoginInterceptor인셉  uri " + uri);    
	     int idx = uri.lastIndexOf("/");
	     uri = uri.substring(idx+1); 
		 System.out.println("LoginInterceptor인셉  uri " + uri); 
		
		boolean flag = false;
		if(userid!=null){
			flag=true;	
		}else{
		  response.setContentType("text/html; charset=utf-8");
		  response.getWriter().append("<script>"
		       		+ "location.href='login.do?msg="+URLEncoder.encode("로그인이 필요합니다.","UTF-8")+"';"
				    + "</script>").flush();
		 flag=false;
		}
		return flag;
	}//end

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object arg2, Exception arg3)		throws Exception {
		//컨트롤러의 메소드 끝나고 , 화면처리후 처리 
        logger.info("=======================afterCompletion start========================");
		logger.info("=======================afterCompletion end=========================");
	}//end
			
	
	 @Override
	 public void postHandle(HttpServletRequest request, HttpServletResponse response, Object arg2, ModelAndView arg3)		throws Exception {
		//컨트롤러의 메소드 끝나고 ,1처리 
	   logger.info("=======================postHandle start======================");
	   logger.info("=======================postHandle end=========================");	
	}//end

}//class LoginInterceptor END
