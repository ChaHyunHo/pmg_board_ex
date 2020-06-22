package com.test.example.domain;

import lombok.Data;

@Data
public class FileDTO {
	
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;

}
