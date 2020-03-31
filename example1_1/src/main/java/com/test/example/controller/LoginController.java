package com.test.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	
	@RequestMapping(value = "/loginform", method = RequestMethod.GET)
	public String loginGet() throws Exception {
		return "/loginform";
	}
	
	@RequestMapping(value = "/loginform", method = RequestMethod.POST)
	public String loginPost() throws Exception {
		return "/loginform";
	}
}
