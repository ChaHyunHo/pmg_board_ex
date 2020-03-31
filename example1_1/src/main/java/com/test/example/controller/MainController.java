package com.test.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/main/*")
@Log4j
public class MainController {
	
	@GetMapping
	public String main() throws Exception {
	
		log.info("main page");
		return "main";
	}
}
