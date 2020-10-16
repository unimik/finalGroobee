package com.kh.spring.setting.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.setting.model.service.SettingService;
import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;

@SessionAttributes("notification")
@Controller
public class settingController {
	
	@Autowired
	SettingService sService;
	
	@RequestMapping(value="goSetting.do")
	public ModelAndView userSetting(ModelAndView mv,int mNo) {
		
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

}
