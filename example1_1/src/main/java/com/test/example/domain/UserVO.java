package com.test.example.domain;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("userVO")
public class UserVO {
	private Integer idx;
	private String email;
	private String password;
	private String name;
	private List<AuthVO> authList;
	
}
