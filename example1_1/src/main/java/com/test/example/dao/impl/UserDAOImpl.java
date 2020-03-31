package com.test.example.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.example.dao.UserDAO;
import com.test.example.domain.AuthVO;
import com.test.example.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	private SqlSession sqlSession;

	private static final String namespace = "user.";

	@Override
	public UserVO read(String email) throws Exception {
		return sqlSession.selectOne(namespace + "read", email);
	}

	@Override
	public int register(UserVO vo) throws Exception {
		return sqlSession.insert(namespace + "register", vo);
	}

	@Override
	public int update(UserVO vo) throws Exception {
		return sqlSession.update(namespace + "update", vo);
	}

	@Override
	public int delete(String email) throws Exception {
		return sqlSession.delete(namespace + "delete", email);
	}

	@Override
	public int registerAuth(AuthVO vo) throws Exception {
		return sqlSession.insert(namespace + "registerAuth", vo);
	}

	@Override
	public int emailCheck(String email) throws Exception {
		return sqlSession.selectOne(namespace + "emailCheck", email);
	}

}
