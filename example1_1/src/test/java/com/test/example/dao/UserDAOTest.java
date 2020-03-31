package com.test.example.dao;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.test.example.domain.UserVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserDAOTest {

	@Autowired
	private UserDAO userDAO;
	
	@Test
	public void readTest() throws Exception {
		
		UserVO user = userDAO.read("chamym@naver.com");
		
		log.info(user);
	
	}
	
	@Test
	@Ignore
	public void insertTest() throws Exception {
		
		UserVO user = new UserVO();
		user.setEmail("aaaa@aaaaa.com");
		user.setPassword("111111");
		user.setName("차현호");
		
		int result = userDAO.register(user);
		
		if(result == 1) {
			log.info("등록성공");
		}
	}

}
