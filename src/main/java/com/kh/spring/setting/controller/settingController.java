package com.kh.spring.setting.controller;




import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.member.model.vo.Member;
import com.kh.spring.setting.model.service.SettingService;
import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;

@SessionAttributes("notification")
@Controller
public class settingController {
	
	@Autowired
	SettingService sService;
	
	@Autowired
	HttpSession session;
	

	
	@RequestMapping(value="goSetting.do")
	public ModelAndView userSetting(HttpServletRequest request,ModelAndView mv) {
		HttpSession session = request.getSession();
		Member m = (Member)session.getAttribute("loginUser");

		int mNo = m.getmNo();
		System.out.println(mNo);
		
		NotificationSetting ns = sService.notificationSetting(mNo);
		PersonalSetting ps = sService.personalSetting(mNo);

	
		
		mv.addObject("ns",ns);
		mv.addObject("ps",ps);
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
								@RequestParam("aMessage") String aMessage
			) {
		System.out.println("실행확인");
		Member m = (Member)session.getAttribute("loginUser");
		int mNo = m.getmNo();
		NotificationSetting ns = new NotificationSetting(mNo,aAll,aLike,aReply,aFriends,aMessage);
		System.out.println(ns);
		PersonalSetting ps=null;
		if(ns != null) {
			System.out.println(sService.updateSetting(ns));
			
			System.out.println("update notificationSetting check");
		}/*else if(ps != null) {
			sService.updateSetting(ps);
			System.out.println("update personalSetting check");
		}*/
		
		return null;
	}
}
