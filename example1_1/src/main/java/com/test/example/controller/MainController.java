package com.test.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.example.domain.BoardVO;

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
	
	@GetMapping("get")
	public String mainGet() throws Exception {
		return "exget";
	}
	
	@PostMapping("/ex")
	@ResponseBody
	public String mainPost(BoardVO vo) throws Exception {
		log.info(vo);
		return null;
	}
}
