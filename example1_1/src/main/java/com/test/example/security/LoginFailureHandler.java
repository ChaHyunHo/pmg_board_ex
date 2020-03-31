package com.test.example.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;

import com.test.example.utils.MessageUtils;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Data
@Log4j
public class LoginFailureHandler implements AuthenticationFailureHandler {
	
	private String loginusername; // 로그인시 사용아이디
    private String loginpwdname; // 로그인시 사용 비밀번호
    private String errormsgname; // 로그인 페이지에서 jstl을 이용하여 에러메시지를 가져올 때 사용할 변수 이름.
    private String defaultFailureUrl; // 실패시 보여줄 화면 url 

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String username = request.getParameter(loginusername);
		String userpw = request.getParameter(loginpwdname);
		String errormsg = null;
		
		log.info(username);
		log.info(userpw);
		log.info(exception.getClass());
		log.info(defaultFailureUrl);
		
		if (exception instanceof BadCredentialsException) {
			errormsg = MessageUtils.getMessage("error.BadCredentials");
		} else if (exception instanceof InternalAuthenticationServiceException) {
			errormsg = MessageUtils.getMessage("error.BadCredentials");
		} else if (exception instanceof DisabledException) {
			errormsg = MessageUtils.getMessage("error.Disabled"); 
		} else if (exception instanceof CredentialsExpiredException) {
			errormsg = MessageUtils.getMessage("error.CredentialsExpired");
		}  else if (exception instanceof SessionAuthenticationException) {
			errormsg = MessageUtils.getMessage("error.SessionAuthentication"); // 중복 로그인
		}
	
		request.setAttribute(loginusername, username);
		request.setAttribute(loginpwdname, userpw);
		request.setAttribute(errormsgname, errormsg); 
		
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
		
	}
		
}

