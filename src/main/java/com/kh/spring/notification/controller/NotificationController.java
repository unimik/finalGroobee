package com.kh.spring.notification.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.spring.member.model.vo.Member;
import com.kh.spring.notification.model.service.NotificationService;
import com.kh.spring.notification.model.vo.Notification;
import com.kh.spring.notification.model.vo.PushAlram;

@Controller("nController")
public class NotificationController {

	@Autowired
	NotificationService nService;
	
	@Autowired
	HttpSession session;
	
	
	@ResponseBody
	@RequestMapping("getNotification.do")
	public List getNotification() {
	
		Member m = (Member)session.getAttribute("loginUser");
		
		List<Notification> nt = nService.getNotification(m.getmNo());
		int i = 0;
		System.out.println(nt);
		while(nt.isEmpty()) {
			System.out.println(nt);
		}
		return nt;
	}
	
	public int sendAlram(PushAlram a,String fromId, String toId, String rmsg, int crNo) {
		a.setFromId(fromId);
		a.setToId(toId);
		a.setType(rmsg);
		a.setTypeNo(crNo);
		int result = nService.insertAlram(a);
		if(result > 0) {
			return result;
		} else {
			return -1;
		}
	}

}
