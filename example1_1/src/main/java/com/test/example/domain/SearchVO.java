package com.test.example.domain;

import lombok.Data;

@Data
public class SearchVO extends PageVO {
	
	private String searchTitle;
	private String searchType;
	private String order ="";
	private Integer myBoardIdx;
	private Integer tempIdx;
	
}
