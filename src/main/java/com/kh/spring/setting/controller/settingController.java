package com.kh.spring.setting.controller;




import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.setting.model.service.SettingService;
import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;
import com.kh.spring.setting.model.vo.Question;

@SessionAttributes("notification")
@Controller
public class settingController {
	
	@Autowired
	SettingService sService;

	@Autowired
	MemberService mService;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping(value="goSetting.do")
	public ModelAndView userSetting(HttpServletRequest request,ModelAndView mv) {
		HttpSession session = request.getSession();
		Member m = (Member)session.getAttribute("loginUser");

		int mNo = m.getmNo();
		
		NotificationSetting ns = sService.notificationSetting(mNo);
		PersonalSetting ps = sService.personalSetting(mNo);
		
		ArrayList<Member> bList = new ArrayList();
		String blocked = ps.getBlockedNo();
		if(blocked != null) {
			String[] blist = blocked.split(",");
			
			if(blist!=null) {
				
				for (Member b : bList) {
					b.getmImage();
				}
				
				for (String string : blist) {
					Member blockedMember = mService.selectOne(string);
					bList.add(blockedMember);
				}
		}
		}
		mv.addObject("blocked",blocked);
		mv.addObject("bList",bList);
		mv.addObject("ns",ns);
		mv.addObject("ps",ps);
		ps.getBlockedNo();
		mv.setViewName("setting");
		
		return mv;
	}
	
	@RequestMapping("setting.do")
	public String goSetting() {
		return "setting";
	}
	
	@ResponseBody
	@RequestMapping(value="updateSetting.do", produces="application/json; charset=utf-8")
	public String updateSetting(@RequestParam("aAll") String aAll,
								@RequestParam("aLike") String aLike,
								@RequestParam("aReply") String aReply,
								@RequestParam("aFriends") String aFriends,
								@RequestParam("aMessage") String aMessage,
								@RequestParam("pwdSaved") String pwdSaved,
								@RequestParam("openStatus") String openStatus
								
			) {
		Member m = (Member)session.getAttribute("loginUser");
		int mNo = m.getmNo();
		NotificationSetting ns = null;
		if(aAll.equals("Y")){
			ns = new NotificationSetting(mNo,aAll,aLike,aReply,aFriends,aMessage);			
		}else {
			ns = new NotificationSetting(mNo,aAll,"N","N","N","N");
		}
		
		PersonalSetting ps = new PersonalSetting(mNo,openStatus,pwdSaved);
		
		
		if(ns != null) {
			System.out.println(sService.updateSetting(ns));
			
			System.out.println("update notificationSetting check");
		}
		if(ps != null) {
			sService.updateSetting(ps);
			System.out.println("update personalSetting check");
		}
		
		return null;
	}
	
	@ResponseBody
	@RequestMapping("disableAccount.do")
	public String disableAccount(@RequestParam("userPwd") String userPwd) {
		Member m = (Member)session.getAttribute("loginUser");
		int mNo = m.getmNo();
		
		if(bcryptPasswordEncoder.matches(userPwd,m.getUserPwd())) {
			int result  = mService.disableAccount(mNo);	
			System.out.println(result);
			if(result > 0) {
				return "success";				
			}
			return"server error";
		}else {
			return"incorrect pwd";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("deleteAccount.do")
	public String deleteAccount(@RequestParam("userPwd") String userPwd) {
		Member m = (Member)session.getAttribute("loginUser");
		int mNo = m.getmNo();
		
		if(bcryptPasswordEncoder.matches(userPwd,m.getUserPwd())) {
			int result  = mService.deleteAccount(mNo);	
			System.out.println(result);
			if(result > 0) {
				session.invalidate();
				return "success";				
			}
			return"server error";
		}else {
			return"incorrect pwd";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("updateQuestion.do")
	public String updateQuestion(@RequestParam("questionText") String questionText) {
		Member m = (Member)session.getAttribute("loginUser");
		int mNo = m.getmNo();
		
		Question q = new Question(questionText,mNo);
		int result = sService.insertQuestion(q);
		
		
		return"sended question";
	}
	
	@ResponseBody
	@RequestMapping("disableBlock.do")
	public String disableBlock(	
								@RequestParam("blocked") String blocked,
								@RequestParam("disblockId") String disblockId ) {
		Member m = (Member)session.getAttribute("loginUser");
		
		String[] bList = blocked.split(",");
		String updateList =	null;
		for (String b : bList) {
			if(!b.equals(disblockId)) {
				if(updateList == null) {
					updateList = b;
				}else {
					updateList += "," + b;					
				}
			}
		}
		PersonalSetting p = new PersonalSetting(m.getmNo(),updateList);
		int result = sService.disableblock(p);
		if(result >0 ) {
			return updateList;			
		}else {
			return"error";
		}
	}
	
	@ResponseBody
	@RequestMapping("blockAccount.do")
	public String blockAccount(@RequestParam("newblock") String newblock,
								@RequestParam("blocked") String blocked){
		String updateList = blocked +","+newblock;
		Member m = (Member)session.getAttribute("loginUser");
		PersonalSetting p = new PersonalSetting(m.getmNo(),updateList);
		int result = sService.disableblock(p);
		if(result >0 ) {
			return updateList;			
		}else {
			return"error";
		}

	}
	
	@ResponseBody
	@RequestMapping("notifyset.do")
	public String notifyset(@RequestParam("mNo") String mNo) {
		NotificationSetting ns = sService.notifyset(mNo);
		
		return ns.getaAll()+"|"+ns.getaLike()+"|"+ns.getaReply()+"|"+ns.getaFriends()+"|"+ns.getaMessage();
	}
}
