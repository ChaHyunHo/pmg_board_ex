package com.test.example.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;

import lombok.extern.log4j.Log4j;

@Log4j
public class LogoutSuccessHandler implements org.springframework.security.web.authentication.logout.LogoutSuccessHandler {
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onLogoutSuccess(HttpServletRequest req, HttpServletResponse res, Authentication authentication)
			throws IOException, ServletException {
		
		log.info("로그아웃 하셨습니다.");
		
		// 로그아웃시에 해당 페이지를 경로로 받아온다.
		String targetUrl = req.getHeader("REFERER");
		redirectStrategy.sendRedirect(req, res , targetUrl);
	}

}
