package com.kh.spring.declaration.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.spring.declaration.model.service.DeclarationService;
import com.kh.spring.declaration.model.vo.Declaration;
import com.kh.spring.member.model.vo.Member;

@Controller
public class DeclarationController {

	@Autowired
	HttpSession session;
	
	@Autowired
	DeclarationService dService;
	
	@ResponseBody
	@RequestMapping("reportGInsert.do")
	public void insertReport(@RequestParam("feedType") String feedType,
								@RequestParam("reportType") String reportType,
								@RequestParam("content") String content,
								@RequestParam("gNo")int gNo) {
		// Group 정보를 가져와야 함
		Member m = (Member)session.getAttribute("loginUser");
		Declaration d = new Declaration(feedType,reportType,content,m.getmNo(), gNo);
		int result = dService.insertGReport(d);

	}
}
