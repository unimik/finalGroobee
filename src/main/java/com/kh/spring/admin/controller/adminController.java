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
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kh.spring.admin.service.AdminService;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.setting.model.vo.Question;


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
		
		Member m = new Member(); // 받아온 파라미터를 정보를 담을 객체
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String getOut = request.getParameter("getOut");
		String date =request.getParameter("enrolldate");
		
		if(!id.equals("")) {
			m.setUserId(id);
		}
		if(!name.equals("")) {
			m.setUserName(name);
		}
		if(!getOut.equals("")) {
			m.setmStatus(getOut);			
		}
		if(!date.equals("")) {
		Date todate = java.sql.Date.valueOf(date);
		m.setcDate(todate);
		}
		
		ArrayList<Member> memberList = aService.memberSearchList(m);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(memberList,response.getWriter());
	}
	
	/** 1-2. 회원 상태 변경 
	 * @param response
	 * @param request
	 * @throws IOException
	 */
	@RequestMapping(value="memberStatusChange.do", method=RequestMethod.POST)
	public String memberStatusChange(String id,String status){
		Member m = new Member();
		
		// 회원 상태를 Y-> N  , N -> Y로 만드는 구문
		if(status.equals("Y")) {	
			m.setmStatus("N");
		}else {
			m.setmStatus("Y");			
		}
		
		
		m.setUserId(id);
		int result = aService.memberStatusChange(m);
		
		System.out.println("result의 값 : "+result);
		
		if(result>0) {
			 return "redirect:adminmember.do";
		}else {
			return "common/errorPage";
		}
	}
	

	/** 2-1. 그룹 정보 조회
	 * @param response
	 * @param request
	 * @throws IOException
	 */
	@RequestMapping(value="groupSearch.do", method=RequestMethod.POST)
	public void groupSearchList(HttpServletResponse response,HttpServletRequest request) throws IOException {
		response.setContentType("application/json; charset=utf-8");
		
		Group g= new Group(); // 받아온 파라미터를 정보를 담을 객체
		
		String name = request.getParameter("name");
		String category = request.getParameter("category");
		String tag = request.getParameter("tag");
		String date = request.getParameter("enrolldate");
		
		if(!name.equals("")||!category.equals("")||!tag.equals("")||!date.equals("")) {
			if(!name.equals("")) {
				g.setgName(name);
			}
			if(!category.equals("")) {
				g.setgCategory(category);
			}
			if(!tag.equals("")) {
				g.setgTag(tag);
			}
			if(!date.equals("")) {
				Date todate = java.sql.Date.valueOf(date);
				g.setgDate(todate);
			}
		}
		
		ArrayList<Group> groupList = aService.groupSearchList(g);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(groupList,response.getWriter());
	}

	/** 2-2. 그룹 상태 변경
	 * @param no
	 * @param status
	 * @return
	 */
	@RequestMapping(value="groupStatusChange.do", method=RequestMethod.POST)
	public String groupStatusChange(String no,String status){
		Group g = new Group();
		
		// 회원 상태를 Y-> N  , N -> Y로 만드는 구문
		if(status.equals("Y")) {	
			g.setgStatus("N");
		}else {
			g.setgStatus("Y");			
		}
		
		
		g.setgNo(Integer.parseInt(no));
		int result = aService.groupStatusChange(g);
		
		
		if(result>0) {
			 return "redirect:admingroup.do";
		}else {
			return "../common/errorPage";
		}
	}
	
	
	
	/** 3-1. 댓글 정보 조회
	 * @param response
	 * @param request
	 * @throws IOException
	 */
	@RequestMapping(value="replySearch.do", method=RequestMethod.POST)
	public void replySearchList(HttpServletResponse response,HttpServletRequest request) throws IOException {
		response.setContentType("application/json; charset=utf-8");
				
		Reply re =  new Reply(); // 받아온 파라미터를 정보를 담을 객체
		
		String id = request.getParameter("re_id");
		String num = request.getParameter("re_num");
		String content =request.getParameter("re_Content");
		String date= request.getParameter("re_writedate");
		
		
		if(!id.equals("")||!num.equals("")||!content.equals("")||!date.equals("")) {
			if(!id.equals("")) {
				re.setrWriter(id);
			}
			if(!num.equals("")) {
				re.setrNo(Integer.parseInt(num));
			}
			if(!content.equals("")) {
				re.setrContent(content);
			}
			if(!date.equals("")) {
				re.setrCreateDate(date); // 스트링으로 저장해야하네??
			}
		}
			
		ArrayList<Reply> replyList = aService.replySearchList(re);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(replyList,response.getWriter());
	}
	/** 3-2. reply Status 변경
	 * @param no
	 * @param status
	 * @return
	 */
	@RequestMapping(value="replyStatusChange.do", method=RequestMethod.POST)
	public String replyStatusChange(String no,String status){
		Reply r = new Reply();
		// 회원 상태를 Y-> N  , N -> Y로 만드는 구문
		if(status.equals("Y")) {	
			r.setrStatus("N");
		}else {
			r.setrStatus("Y");			
		}
		
		
		r.setrNo(Integer.parseInt(no));
		int result = aService.replyStatusChange(r);
		
		
		if(result>0) {
			return "redirect:adminfeed.do";
		}else {
			return "../common/errorPage";
		}
	}
	
	
	/** 4-1. 피드 정보 조회
	 * @param response
	 * @param request
	 * @throws IOException
	 */
	@RequestMapping(value="feedSearch.do", method=RequestMethod.POST)
	public void feedSearchList(HttpServletResponse response,HttpServletRequest request) throws IOException {
		response.setContentType("application/json; charset=utf-8");
		
		Feed f = new Feed(); // 받아온 파라미터를 정보를 담을 객체
		
		String num = request.getParameter("f_num"); // 숫자
		String id = request.getParameter("f_id");
		String content = request.getParameter("f_Content");
		String date = request.getParameter("f_writedate");
		
		if(!num.equals("")||!id.equals("")||!content.equals("")||!date.equals("")) {
			if(!num.equals("")) {
				f.setfNo(Integer.parseInt(num));
			}
			if(!id.equals("")) {
				f.setfWriter(id);
			}
			if(!content.equals("")) {
				f.setfContent(content);
			}
			if(!date.equals("")) {
				Date todate = java.sql.Date.valueOf(date);
				f.setfCreateDate(todate);
			}
		}
		
		ArrayList<Feed> feedList = aService.feedSearchList(f);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(feedList,response.getWriter());
	}
	
	/** 4-2. feed status 변경
	 * @param id
	 * @param status
	 * @return
	 */
	@RequestMapping(value="feedStatusChange.do", method=RequestMethod.POST)
	public String feedStatusChange(String no,String status){
		Feed f = new Feed();
		
		// 회원 상태를 Y-> N  , N -> Y로 만드는 구문
		if(status.equals("Y")) {	
			f.setfStatus("N");
		}else {
			f.setfStatus("Y");			
		}
		
		
		f.setfNo(Integer.parseInt(no));
		int result = aService.feedStatusChange(f);
		
		
		if(result>0) {
			 return "redirect:adminfeed.do";
		}else {
			return "../common/errorPage";
		}
	}

	/** 5-1. 모달 - 문의사항 불러오기
	 * @param response
	 * @param request
	 * @throws IOException
	 */
	@RequestMapping(value="questionSearchList.do")
	public void questionSearchList(HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=utf-8");
		
		System.out.println("controller에 들어왔나?");
				
		ArrayList<Question> qList = aService.questionSearchList();
		System.out.println("controller로 다시 왔낭요??");
		System.out.println(qList);
		
		// qList에 담긴 mNo 값을 다시 보내어 아이디를 가지고 온다?
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(qList,response.getWriter());
	}
}
