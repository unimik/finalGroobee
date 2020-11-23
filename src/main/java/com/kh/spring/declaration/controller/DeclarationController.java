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
	
	/** 1. 그룹 신고
	 * @param feedType
	 * @param reportType
	 * @param content
	 * @param gNo
	 */
	@ResponseBody
	@RequestMapping("reportGInsert.do")
	public void insertReport(@RequestParam("feedType") String feedType,
								@RequestParam("reportType") String reportType,
								@RequestParam("content") String content,
								@RequestParam("gNo")int gNo) {
		Member m = (Member)session.getAttribute("loginUser");
		Declaration d = new Declaration(feedType,reportType,content,m.getmNo(), gNo);
		int result = dService.insertReport(d);

	}
	
	/** 2. 회원 신고
	 * @param feedType
	 * @param reportType
	 * @param content
	 * @param memberInfo
	 */
	@ResponseBody
	@RequestMapping("reportMInsert.do")
	public void reportMInsert(@RequestParam("feedType") String feedType,
			@RequestParam("reportType") String reportType,
			@RequestParam("content") String content,
			@RequestParam("targetmNo")int targetmNo) {
		Member m = (Member)session.getAttribute("loginUser");
		Declaration d = new Declaration(feedType,reportType,content,m.getmNo(), targetmNo);
		int result = dService.insertReport(d);
		
	}
	
	
	/** 3. 피드 신고
	 * @param feedType
	 * @param reportType
	 * @param content
	 * @param targetmNo
	 */
	@ResponseBody
	@RequestMapping("reportFInsert.do")
	public void reportFInsert(@RequestParam("feedType") String feedType,
			@RequestParam("reportType") String reportType,
			@RequestParam("content") String content,
			@RequestParam("targetfNo")int targetfNo) {
		Member m = (Member)session.getAttribute("loginUser");
		Declaration d = new Declaration(feedType,reportType,content,m.getmNo(), targetfNo);
		int result = dService.insertReport(d);
		
	}
}
