package com.test.example.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.example.dao.BoardFileDAO;
import com.test.example.domain.BoardFileVO;

@Repository
public class BoardFileDAOImpl implements BoardFileDAO {
	
	@Autowired
	private SqlSession sqlSession;

	private static final String namespace = "boardFile.";

	@Override
	public void insert(BoardFileVO vo) throws Exception {
		sqlSession.insert(namespace + "insert", vo); 
	}

	@Override
	public void delete(String uuid) throws Exception {
		sqlSession.delete(namespace + "delete", uuid);
		
	}

	@Override
	public List<BoardFileVO> findByBno(Long bno) throws Exception {
		return sqlSession.selectList(namespace + "findByBno", bno);
	}

}
