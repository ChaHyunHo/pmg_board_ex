package com.test.example.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.example.dao.BoardDAO;
import com.test.example.domain.BoardVO;
import com.test.example.domain.PageVO;
import com.test.example.domain.SearchVO;
import com.test.example.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO boardDAO;
	
	@Override
	public List<BoardVO> listAll(PageVO pagevo) throws Exception {
		return boardDAO.listAll(pagevo);
	}

	@Override
	public int insert(BoardVO vo) throws Exception {
		return boardDAO.insert(vo);
	}

	@Override
	public BoardVO read(Integer bno) throws Exception {
		return boardDAO.read(bno);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		boardDAO.update(vo);
	}

	@Override
	public int delete(Integer bno) throws Exception {
		return boardDAO.delete(bno);
	}

	@Override
	public int listTotalCount(SearchVO vo) throws Exception {
		return boardDAO.listTotalCount(vo);
	}

	@Override
	public void updateView(Integer bno) throws Exception {
		boardDAO.updateView(bno);
	}

	@Override
	public List<BoardVO> noticeList() throws Exception {
		return boardDAO.noticeList();
	}

	@Override
	public List<BoardVO> orderList(SearchVO vo) throws Exception {
		return boardDAO.orderList(vo);
	}

}
