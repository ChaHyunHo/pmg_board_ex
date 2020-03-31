package com.test.example.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PageVO {
	
	private int page;
	private int perPageNum;
	
	public PageVO() {
		this.page = 1 ;
		this.perPageNum = 10;
		
	}
	
	public PageVO(int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
		
	}

	public void setPage(int page) {
		
		if( page <= 0) {
			this.page =1;
			return;
		}
		
		this.page = page;
	}
	
	public void  setPerPageNum(int perPageNum) {
		
		if( perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum =20;
			return;
		}
		
		this.perPageNum = perPageNum;
	}
	
	public int getPage() {
		return page;
	}
	
	public int getPageStart() {
		
		return (this.page -1 ) * perPageNum;   // 1 ~ 10  0,10  10~ 20 10,10 20~30 20,10  30~ 40 30,10
	}
	
	public int getPerPageNum() {
		
		return this.perPageNum;
	}

}
