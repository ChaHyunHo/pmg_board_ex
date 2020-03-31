package com.test.example.service;

import java.util.List;

import com.test.example.domain.BoardVO;
import com.test.example.domain.PageVO;
import com.test.example.domain.SearchVO;

public interface BoardService {
	
	/**
	 * 리스트
	 * @return
	 * @throws Exception
	 */
	public List<BoardVO> listAll(PageVO pagevo) throws Exception;
	
	/**
	 * 게시글 등록
	 * @param vo
	 * @throws Exception
	 */
	public int insert(BoardVO vo) throws Exception;
	
	/**
	 * 게시글 읽기
	 * @param vo
	 * @throws Exception
	 */
	public BoardVO read(Integer bno) throws Exception;

	/**
	 * 게시글 수정
	 * @param vo
	 * @throws Exception
	 */
	public void update(BoardVO vo) throws Exception;
	
	/**
	 * 게시글 삭제
	 * @param vo
	 * @throws Exception
	 */
	public int delete(Integer bno) throws Exception;
	
	/**
	 * 게시글 토탈수
	 * @param vo
	 * @throws Exception
	 */
	public int listTotalCount(SearchVO vo) throws Exception;
	
	/**
	 * 게시글 조회수
	 * @param vo
	 * @throws Exception
	 */
	public void updateView(Integer bno) throws Exception;
	
	/**
	 * 공지사항 리스트
	 * @param vo
	 * @throws Exception
	 */
	public List<BoardVO> noticeList() throws Exception;
	
	/**
	 * 정렬 리스트
	 * @param vo
	 * @throws Exception
	 */
	public List<BoardVO> orderList(SearchVO vo) throws Exception;
	
	
}
