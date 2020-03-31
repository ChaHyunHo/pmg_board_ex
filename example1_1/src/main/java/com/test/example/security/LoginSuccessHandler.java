package com.test.example.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
   
   private RequestCache requestCache = new HttpSessionRequestCache();
   
   private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
   
   private String defaultUrl;
   
   public LoginSuccessHandler() {
	   this.defaultUrl = "/board/list";
   }

   @Override
   public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse res,
         Authentication authentication) throws IOException, ServletException {
      
      log.info("login에 성공하셨습니다.");
      
      try {
    	  
    	  // 내가 이동하려 하는 페이지경로를 받아온다.
          SavedRequest savedRequest = requestCache.getRequest(req, res);
          
          if(savedRequest == null) {
        	  log.info("savedRequest is null");
        	  redirectStrategy.sendRedirect(req, res, defaultUrl);    	  
          } else {
        	  String targetUrl = savedRequest.getRedirectUrl();
        	  redirectStrategy.sendRedirect(req, res, targetUrl);  
          }
    	   
      } catch (Exception e) {
    	  e.printStackTrace();
      }
   }
}