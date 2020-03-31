package com.test.example.dao;

import java.util.List;

import com.test.example.domain.BoardVO;
import com.test.example.domain.PageVO;
import com.test.example.domain.SearchVO;

public interface BoardDAO {
	
	public int insert(BoardVO vo) throws Exception;
	
	public BoardVO read(Integer bno) throws Exception;
	
	public void update(BoardVO vo) throws Exception;
	
	public int delete(Integer bno) throws Exception;
	
	public List<BoardVO> listAll(PageVO vo) throws Exception;
	
	public int listTotalCount(SearchVO vo) throws Exception;
	
	public void updateView(Integer bno) throws Exception;
	
	public List<BoardVO> noticeList() throws Exception;
	
	public List<BoardVO> orderList(SearchVO vo) throws Exception;
}
