package com.test.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.example.domain.UserVO;
import com.test.example.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user/*")
@Log4j
public class UserController {
	
	@Autowired
	private UserService userService;
	
	/**
	 * 회원가입 폼
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerGet(UserVO user) throws Exception {
		log.info("회원가입 폼");
		return "/user/register";
	}
	
	/**
	 * 회원가입 
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(UserVO user) throws Exception {
		
		try {
			userService.register(user);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/loginform";
	}
	
	/**
	 * 이메일 중복 체크
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/emailCheck", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView emailCheck(UserVO vo) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		// '1'이면 이메일 중복
		if(userService.emailCheck(vo.getEmail()) == 1) {
			mav.addObject("duplicate", 1);
		}
		
		return mav;
	}
}
