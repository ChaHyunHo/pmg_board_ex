package com.test.example.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.test.example.dao.UserDAO;
import com.test.example.domain.AuthVO;
import com.test.example.domain.UserVO;
import com.test.example.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public UserVO read(String email) throws Exception {
		return userDAO.read(email);
	}
	
	@Transactional
	@Override
	public void register(UserVO vo) throws Exception {
		vo.setPassword(passwordEncoder.encode(vo.getPassword()) );
		userDAO.register(vo);
		
		AuthVO auth = new AuthVO();
		auth.setEmail(vo.getEmail());
		auth.setAuth("ROLE_USER");
		
		userDAO.registerAuth(auth);
		
		
	}

	@Override
	public int update(UserVO vo) throws Exception {
		return userDAO.update(vo);
	}

	@Override
	public int delete(String email) throws Exception {
		return userDAO.delete(email);
	}

	@Override
	public int registerAuth(AuthVO vo) throws Exception {
		return userDAO.registerAuth(vo);
	}

	@Override
	public int emailCheck(String email) throws Exception {
		return userDAO.emailCheck(email);
	}

}
