package com.kh.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;

@SessionAttributes("loginUser")
@Controller
public class MemberController {

	@Autowired
	MemberService mService;
	
	@RequestMapping(value="login.do",method=RequestMethod.POST) 
	public String memberLogin(Member m,Model model) {          
		
		
		Member loginUser = mService.loginMember(m);
		
		if(loginUser != null) {
			model.addAttribute("loginUser", loginUser);
			return "redirect:home.do";
		}else {
			model.addAttribute("msg", "로그인실패!");
			return "common/errorPage";
		}
	}
	
	@RequestMapping("home.do")
	public String goHome() {
		return "home";
	}
}
