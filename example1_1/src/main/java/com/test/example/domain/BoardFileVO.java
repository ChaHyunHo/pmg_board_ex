package com.test.example.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("fileVO")
public class BoardFileVO {
	
	private Integer bno;
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	

}
