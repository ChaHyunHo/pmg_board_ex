package com.test.example.connection;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JdbcConnectionTest {
	
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	
	private static final String URL = 
			"jdbc:mysql://127.0.0.1:3306/test?useSSL=false&serverTimezone=Asia/Seoul";
	
	private static final String USER = "root";
	
	private static final String PW = "root";
	
	@Test
	public void testConnection() throws Exception {
		
		Class.forName(DRIVER);
		
		try(Connection con = DriverManager.getConnection(URL,USER,PW)) {
			log.info(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
