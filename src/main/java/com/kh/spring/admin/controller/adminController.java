package com.kh.spring.admin.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.spring.admin.service.AdminService;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;


@Controller
public class adminController {
	
	@Autowired
	private AdminService aService;
	
	/** 1.sidebar에서 adminmemberPage로 이동
	 * @return
	 */
	@RequestMapping("adminmember.do")
	public String goAdminMember() {
		return "admin/adminmember";
	}
	
	/** 2.sidebar에서 adminfeedPage로 이동
	 * @return
	 */
	@RequestMapping("adminfeed.do")
	public String goAdminFeed() {
		return "admin/adminfeed";
	}
	
	/** 3.sidebar에서 admingroupsPage로 이동
	 * @return
	 */
	@RequestMapping("admingroup.do")
	public String goAdminGroup() {
		return "admin/admingroup";
	}
	
	/** 4.sidebar에서 adminreportPage로 이동
	 * @return
	 */
	@RequestMapping("adminreport.do")
	public String goAdminReport() {
		return "admin/adminreport";
	}
	
	/** 1-1. member정보 조회 기능
	 * @param response
	 * @param request
	 * @throws IOException
	 */
	@RequestMapping(value="memberSearch.do", method=RequestMethod.POST)
	public void memberSearchList(HttpServletResponse response,HttpServletRequest request) throws IOException {
		response.setContentType("application/json; charset=utf-8");
		
		System.out.println(request.getParameter("enrolldate"));
		Member m = new Member(); // 받아온 파라미터를 정보를 담을 객체
		
		if(!request.getParameter("id").equals("")) {
			m.setUserId(request.getParameter("id"));
		}
		if(!request.getParameter("name").equals("")) {
			m.setUserName(request.getParameter("name"));
		}
		if(!request.getParameter("getOut").equals("")) {
			m.setmStatus(request.getParameter("getOut"));			
		}
		
		if(!request.getParameter("enrolldate").equals("")) {
		Date todate = java.sql.Date.valueOf((request.getParameter("enrolldate")));
		m.setcDate(todate);
		}
		
		System.out.println(m);
		ArrayList<Member> memberList = aService.memberSearchList(m);
		
		System.out.println("컨트롤러로 돌아왔니?");

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(memberList,response.getWriter());
	}
	
	@ResponseBody
	@RequestMapping(value="groupSearch.do", method=RequestMethod.POST)
	public void groupsSearchList(HttpServletResponse response,HttpServletRequest request) throws IOException {
		response.setContentType("application/json; charset=utf-8");
		
		Group g= new Group(); // 받아온 파라미터를 정보를 담을 객체
		
		if(!request.getParameter("name").equals("")) {
			g.setgName(request.getParameter("name"));
		}
		if(!request.getParameter("category").equals("")) {
			g.setgCategory(request.getParameter("category"));
		}
		if(!request.getParameter("tag").equals("")) {
			g.setgTag(request.getParameter("tag"));			
		}
		
		if(!request.getParameter("enrolldate").equals("")) {
		Date todate = java.sql.Date.valueOf((request.getParameter("enrolldate")));
			g.setgDate(todate);
		}
		
		System.out.println(g);
		ArrayList<Group> groupList = aService.groupSearchList(g);
		
		System.out.println("컨트롤러로 돌아왔니?");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(groupList,response.getWriter());
	}
	
}
