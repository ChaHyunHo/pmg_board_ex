package com.test.example.dao;

import java.util.List;

import com.test.example.domain.BoardFileVO;

public interface BoardFileDAO {
	
	public void insert(BoardFileVO vo) throws Exception;
	
	public void delete(String uuid) throws Exception;
	
	public List<BoardFileVO> findByBno(Long bno) throws Exception;

}
