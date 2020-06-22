package com.test.example.domain;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("boardVO")
public class BoardVO {
	private Integer newcount;
	private Integer bno;		   // 게시글 번호
	private String title;		   // 게시글 제목
	private String content; 	   // 게시글 내용
	private String writer;		   // 게시글 작성자
	private Date registerDate;	   // 게시글 등록일
	private Date updateDate; 	   // 게시글 수정일
	private Integer viewCount; 	   // 게시글 조회수
	private String category;       // 게시글 카테고리
	private boolean newLabel = false; // 게시글 NEW 라벨
	private Integer id;
	
	private List<BoardFileVO> attachList;
	
}
