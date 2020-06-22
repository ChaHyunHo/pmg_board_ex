package com.test.example.controller;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class FileController {
	
	@Autowired @Qualifier("uploadPath")
	private String uploadPath;

	 @RequestMapping(value = "/upload/file", method = RequestMethod.GET )
	 public String fileGet() throws Exception {
		 log.info("file GET");
		 return "/upload/file";
	 }
	 
	 @RequestMapping(value = "/upload/file", method = RequestMethod.POST )
	 public String filePost(MultipartFile file, Model model) throws Exception {
		 log.info("file POST");
		 
		 log.info("uploadPath : "+uploadPath);
		 log.info("originalName : " +  file.getOriginalFilename());
		 log.info("size : " +  file.getSize());
		 log.info("contentType : " +  file.getContentType());
		 
		 String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		 
		 model.addAttribute("savedName", savedName);
		 
		 return "/upload/file";
	 }
	 
	 private String uploadFile(String originalName , byte[] fileData) throws Exception {
		 
		 UUID uid = UUID.randomUUID();
		 
		 String savedName = uid.toString() + "_" + originalName;
		 
		 File target = new File(uploadPath, savedName);
		 
		 FileCopyUtils.copy(fileData, target);
		 
		 return savedName;
	 }
	 
	 @ResponseBody
	 @RequestMapping(value = "/ajaxUpload", method = RequestMethod.POST, 
	 produces = "text/plain; charset=UTF-8")
	 public ResponseEntity<String> ajaxUpload(MultipartFile file) throws Exception {
		 
		 log.info("uploadPath : "+uploadPath);
		 log.info("originalName : " +  file.getOriginalFilename());
		 log.info("size : " +  file.getSize());
		 log.info("contentType : " +  file.getContentType());
		 
		 
		 return new ResponseEntity<String>(file.getOriginalFilename(),HttpStatus.OK);
	 }
}