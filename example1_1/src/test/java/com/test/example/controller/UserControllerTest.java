package com.test.example.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.test.example.service.BoardService;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Log4j
public class UserControllerTest {
	
	@Autowired
	private WebApplicationContext ctx;
	
	@Autowired
	private BoardService userService;

	private MockMvc mockMvc;

	@Before
	public void contextSet() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}


	@Test
	public void register() throws Exception {
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.get("/user/read")
						.param("email", "chamym@naver.com")
						)
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}

}
