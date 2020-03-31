package com.test.example.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("authVO")
public class AuthVO {
	private String email;
	private String auth;
}
