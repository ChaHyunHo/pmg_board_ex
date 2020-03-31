package com.test.example.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int realEnd;
	private int total;
	private PageVO pagevo;
	
	public PageDTO(PageVO pagevo, int total) {
		
		this.pagevo = pagevo;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(pagevo.getPage() / 10.0)) * 10;
		
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / pagevo.getPerPageNum()));
		
		this.realEnd = realEnd;
						
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

}
