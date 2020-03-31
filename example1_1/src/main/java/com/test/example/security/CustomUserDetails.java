package com.test.example.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.test.example.domain.UserVO;

import lombok.Getter;

@Getter
public class CustomUserDetails extends User {
	
	private static final long serialVersionUID = 1L;
	
	private UserVO user;
	
	public CustomUserDetails(String email, String password, Collection<? extends GrantedAuthority> authorities) {
		super(email, password, authorities);
	}
	
	public CustomUserDetails(UserVO user) {
		
		super(user.getEmail(), user.getPassword(), user.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.user = user;
	}
}
