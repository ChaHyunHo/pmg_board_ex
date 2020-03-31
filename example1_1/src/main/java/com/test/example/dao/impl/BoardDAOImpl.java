package com.test.example.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.example.dao.BoardDAO;
import com.test.example.domain.BoardVO;
import com.test.example.domain.PageVO;
import com.test.example.domain.SearchVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;

	private static final String namespace = "board.";
	
	@Override
	public BoardVO read(Integer testNumber) throws Exception {
		return sqlSession.selectOne(namespace + "read", testNumber);
	}

	@Override
	public int insert(BoardVO vo) throws Exception {
		return sqlSession.insert(namespace + "insert", vo);
	}

	@Override
	public List<BoardVO> listAll(PageVO pagevo) throws Exception {
		return sqlSession.selectList(namespace + "listAll", pagevo);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		sqlSession.update(namespace + "update", vo);
	}

	@Override
	public int delete(Integer bno) throws Exception {
		return sqlSession.delete(namespace + "delete", bno);
	}

	@Override
	public int listTotalCount(SearchVO vo) throws Exception {
		return sqlSession.selectOne(namespace + "listTotalCount", vo);
	}

	@Override
	public void updateView(Integer bno) throws Exception {
		sqlSession.update(namespace + "updateView", bno);
	}

	@Override
	public List<BoardVO> noticeList() throws Exception {
		return sqlSession.selectList(namespace + "noticeList");
	}

	@Override
	public List<BoardVO> orderList(SearchVO vo) throws Exception {
		return sqlSession.selectList(namespace + "orderList", vo);
	}
}
