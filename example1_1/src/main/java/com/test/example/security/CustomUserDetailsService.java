package com.test.example.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.test.example.dao.UserDAO;
import com.test.example.domain.UserVO;

public class CustomUserDetailsService implements UserDetailsService  {
	
	@Autowired
	private UserDAO userDao;

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		UserVO userVO = null;
		
		try {
			userVO = userDao.read(email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return userVO == null ? null : new CustomUserDetails(userVO);
	}
}
