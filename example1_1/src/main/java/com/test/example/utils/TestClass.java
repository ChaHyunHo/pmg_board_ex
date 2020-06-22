package com.test.example.utils;

public class TestClass {
	
	public static void main(String[] args) {
		
		String password = "gusgh1234";
		
		String result =  Sha256.encrypt(password);
		
		System.out.println(result);
	}

}
