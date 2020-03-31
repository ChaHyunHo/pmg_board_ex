package com.test.example.service;

import com.test.example.domain.AuthVO;
import com.test.example.domain.UserVO;

public interface UserService {
	
	/**
	 * 회원정보
	 * @return
	 * @throws Exception
	 */
	public UserVO read(String email) throws Exception;
	
	/**
	 * 회원가입
	 * @return
	 * @throws Exception
	 */
	public void register(UserVO vo) throws  Exception;
	
	/**
	 * 회원수정
	 * @return
	 * @throws Exception
	 */
	public int update(UserVO vo) throws Exception;
	
	/**
	 * 회원삭제
	 * @return
	 * @throws Exception
	 */
	public int delete(String email) throws Exception;
	
	/**
	 * 권한부여
	 * @return
	 * @throws Exception
	 */
	public int registerAuth(AuthVO vo) throws Exception;
	
	/**
	 * 중복체크
	 * @return
	 * @throws Exception
	 */
	public int emailCheck(String email) throws Exception;
}
