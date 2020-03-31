package com.test.example.dao;

import java.util.Arrays;
import java.util.List;

import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.test.example.domain.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardDAOTest {

	@Autowired
	private BoardDAO boardDAO;
	
	@Test
	@Ignore
	public void insertTest() throws Exception {
		
		log.info("insert TEST");
		
		String[] title = {
				"오피스텔/도시형 생활주택",
				"대출 가능 1.5룸 이가격에 구하기 힘든방",
				"서울대입구역 원룸, 전세대출상담&문의 ",
				"서울대입구 가성비 끝판왕저보증금월세물건빠르게연락주세요",
				"서울대입구역 보증금대출가능,10평,완전신축급원룸!"
		};
		
		BoardVO board = new BoardVO();
		
		for(int i = 0; i <= 20; i ++) {
			int randomNum = (int)(Math.random() * 5); 
			
			log.info(title[randomNum]);
			
			board.setTitle(title[randomNum]);
			board.setContent(title[randomNum]);
			board.setWriter("차무개");
			
			boardDAO.insert(board);
		
		}
	}
	
	
	
	@Test
	@Ignore
	public void updateTest() throws Exception {
		
		Integer boardNum = 7;
		
		BoardVO board = boardDAO.read(boardNum);
		
		Assert.assertNotNull(board);
		
		board.setTitle("수정된 게시글4");
		board.setContent("수정된 내용4");
		board.setWriter("수정된 이름4");
		
		boardDAO.update(board);
	}
	
	@Test
	@Ignore
	public void deleteTest() throws Exception {
		
		int bno = 8;
		
		boardDAO.delete(bno);
		
		BoardVO board = boardDAO.read(bno);
		
		Assert.assertNull(board);
	}

}
