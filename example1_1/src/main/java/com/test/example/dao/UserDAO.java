package com.test.example.dao;

import com.test.example.domain.AuthVO;
import com.test.example.domain.UserVO;

public interface UserDAO {
	
	public UserVO read(String email) throws Exception;
	
	public int register(UserVO vo) throws  Exception;
	
	public int update(UserVO vo) throws Exception;
	
	public int delete(String email) throws Exception;
	
	public int registerAuth(AuthVO vo) throws Exception;
	
	public int emailCheck(String email) throws Exception;
	
}
