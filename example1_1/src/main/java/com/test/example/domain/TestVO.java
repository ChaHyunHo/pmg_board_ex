package com.test.example.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("testVO")
public class TestVO {
	
	private Integer num;
	private String name;
}
