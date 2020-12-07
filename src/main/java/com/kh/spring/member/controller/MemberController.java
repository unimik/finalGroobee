package com.kh.spring.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.spring.feed.model.service.FeedService;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.service.MailService;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.service.MypageService;
import com.kh.spring.myPage.model.vo.Mypage;
import com.kh.spring.notification.model.service.NotificationService;
import com.kh.spring.pushAlarm.model.vo.PushAlarm;
import com.kh.spring.setting.model.service.SettingService;

@SessionAttributes({"loginUser","alarmList"})
@Controller
public class MemberController {

	@Autowired
	private MemberService mService;
	
	@Autowired
	private SettingService sService;
	
	@Autowired
	private MypageService mpService;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private FeedService fService; 
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private NotificationService nService;
	/**
	 * - 로그인
	 * @param m
	 * @param model
	 * @return
	 */
	@RequestMapping(value="login.do",method= {RequestMethod.POST,RequestMethod.GET}) 
	public String memberLogin(Member m, String userId, String userPwd, Model model) {      
		m.setUserId(userId);
		m.setUserPwd(userPwd);
		String name = m.getUserId();
		Member loginUser = mService.loginMember(m);
		ArrayList<Feed> feed = fService.selectFeed(userId);
		
		//내가 가입 안한 그룹은 게시글에서 제거하기
		
		/*ArrayList<Mypage> mp = mpService.selectGroupInfo(m.getgNo());
		for(int j = 0; j < feed.size(); j++) {
			for(int i = 0 ; i < mp.size(); i++) {
				if(feed.get(j).getgNo() != mp.get(i).getgNo()) {
					feed.remove(j);
				}
			}
		}*/
		
		
		
		ArrayList<PushAlarm> alarmList = nService.selectAlarmList(name);
		
		ArrayList<Feed> newFeed = new ArrayList<>();
		ArrayList<Reply> r = new ArrayList<>();
		
		ArrayList<Photo> fp = null;
		for(Feed f : feed) {
			fp = fService.selectPhotoList(f.getfNo());
			
			for(Photo p : fp) {
				if(p.getChangeName() != null) {
					f.setPhotoList(fp);
				}else {
					f.setPhotoList(null);
				}
			}
		}


		if(loginUser != null && bcryptPasswordEncoder.matches(userPwd, loginUser.getUserPwd())) {
			model.addAttribute("feed", feed);
			model.addAttribute("loginUser", loginUser);
			model.addAttribute("alarmList", alarmList);
			if(loginUser.getUserId().equals("admin")) {
				return "admin/adminmember";
			}else {
				return "home";
			}
		}else {
			model.addAttribute("msg", "로그인 실패!");
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
	 * - 입력받은 이메일로 인증번호 보내기
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
		
		Member newUser = mService.selectNo(m.getUserId());
		System.out.println(newUser.getmNo());
		
		int result2 = sService.insertNSetting(newUser.getmNo()) + sService.insertPSetting(newUser.getmNo());
		int result3 = mpService.insertBox(newUser.getmNo());
		
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
	
	@RequestMapping("logout.do")
	public String logout(SessionStatus status) {
		status.setComplete(); 
		return "redirect:index.jsp";
	}
	



	@RequestMapping("home.do")
	public String goHome(Model model, String userId) {
		ArrayList<Feed> feed = fService.selectFeed(userId);
		ArrayList<Photo> fp = null;
		for(Feed f : feed) {
			fp = fService.selectPhotoList(f.getfNo());
			for(Photo p : fp) {
				if(p.getChangeName() != null) {
					f.setPhotoList(fp);
				}else {
					f.setPhotoList(null);
				}
			}
		}
		
		model.addAttribute("feed", feed);
		return "home";
	}
	
	@RequestMapping("goMemberJoinForm.do")
	public String goMemberJoinForm() {
		return "member/memberJoinForm";
	}
	
	@RequestMapping("goMemberFindForm.do")
	public String goMemberFindForm() {
		return "member/memberFindForm";
	}
	
	@ResponseBody
	@RequestMapping("userData.do")
	public Member userData(@RequestParam("fromId") String fromId) {
		
		Member userData = mService.selectNo(fromId);
		
		return userData;
	}
	

}
