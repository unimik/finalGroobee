package com.kh.spring.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.spring.member.model.service.MailService;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;

@SessionAttributes("loginUser")
@Controller
public class MemberController {

	@Autowired
	private MemberService mService;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	/**
	 * - 로그인
	 * @param m
	 * @param model
	 * @return
	 */
	@RequestMapping(value="login.do",method=RequestMethod.POST) 
	public String memberLogin(Member m,String userId,String userPwd,Model model) {      
		m.setUserId(userId);
		m.setUserPwd(userPwd);
		Member loginUser = mService.loginMember(m);
		
		if(loginUser != null && bcryptPasswordEncoder.matches(userPwd, loginUser.getUserPwd())) {
			model.addAttribute("loginUser", loginUser);
			if(loginUser.getUserId().equals("admin")) {
				return "redirect:adminmember.do";
			}else {
				return "redirect:home.do";
			}
		}else {
			model.addAttribute("msg", "로그인실패!");
			return "common/errorPage";
		}
	}
	

	/**
	 * - 아이디 중복체크
	 * @param userId
	 * @return
	 */
	@ResponseBody
	@RequestMapping("idCheck.do")
	public String idCehck(String userId) {
		int result = mService.idCheck(userId);
		if(result > 0) {
			return "fail";
		} else {
			return "ok";
		}
	}
	
	/**
	 * - 이메일 인증 난수 생성
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("random.do")
	public void sendMail(HttpServletResponse response) throws IOException {
		int random = new Random().nextInt(900000);
		response.setContentType("application/json; charset=UTF-8");
		
		JSONObject job = new JSONObject();
		job.put("random", random);
		PrintWriter out = response.getWriter();
		out.print(job);
	}
	
	/**
	 * - 입력받은 이메일로 인증버호 보내기
	 * @param email
	 * @param random
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("sendEmail.do")
	public boolean sendEmail(String email,int random,HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		String authCode = String.valueOf(random);
		session.setAttribute("authCode", authCode);
		session.setAttribute("random", random);
		String subject = "회원가입 인증 코드 발급 안내 입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append("귀하의 인증코드는 "+authCode+" 입니다.");
		return mailService.send(subject, sb.toString(), "whgnltj37@gmail.com", email, null);
	}
	
	/**
	 * - 입력받은 이메일로 임시비밀번호 보내기
	 * @param m
	 * @param userId
	 * @param email
	 * @param random
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping("sendEmailPwd.do")
	public boolean sendEmailPwd(Member m,String userId,String email,int random,HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		String authCode = String.valueOf(random);
		String encPwd = bcryptPasswordEncoder.encode(authCode);
		m.setUserId(userId);
		m.setUserPwd(encPwd);
		m.setEmail(email);
		int result = mService.findPwd(m);
		if(result > 0) {
			session.setAttribute("authCode", authCode);
			session.setAttribute("random", random);
			String subject = "귀하의 임시비밀번호 발급 안내 입니다.";
			StringBuilder sb = new StringBuilder();
			sb.append("귀하의 임시비밀번호는 "+authCode+" 입니다.");
			return mailService.send(subject, sb.toString(), "whgnltj37@gmail.com", email, null);
		} else {
			return false;
		}
	}
	
	/**
	 * - 회원가입
	 * @param m
	 * @param userPwd1
	 * @param email1
	 * @param email2
	 * @param interest
	 * @return
	 */
	@RequestMapping("memberJoin.do")
	public String memberJoin(Member m,String userPwd1,String email1,String email2,String interest) {
		m.setEmail(email1+"@"+email2);
		m.setInterestes(interest);
		String encPwd = bcryptPasswordEncoder.encode(userPwd1);
		m.setUserPwd(encPwd);
		
		int result = mService.insertMember(m);
		if(result > 0) {
			return"redirect:loginView.do";
		} else {
			return"error";
		}
	}
	
	/**
	 * - 아이디 찾기
	 * @param m
	 * @param userName
	 * @param email
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("findId.do")
	public void findId(Member m,String userName,String email,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		m.setUserName(userName);
		m.setEmail(email);
		System.out.println(m);
		String userId = mService.findId(m);
		System.out.println(userId);
		JSONObject job = new JSONObject();
		
		if(userId == null || userId.equals("")) {
			userId = "no";
			job.put("userId", userId);
		} else {
			job.put("userId", userId);
		}
		PrintWriter out = response.getWriter();
		out.print(job);
	}
	
	@RequestMapping("home.do")
	public String goHome() {
		return "home";
	}
	
	@RequestMapping("adminmain.do")
	public String goAdmin() {
		return "adminmain";
	}
	
	@RequestMapping("goMemberJoinForm.do")
	public String goMemberJoinForm() {
		return "member/memberJoinForm";
	}
	
	@RequestMapping("goMemberFindForm.do")
	public String goMemberFindForm() {
		return "member/memberFindForm";
	}

	
}
