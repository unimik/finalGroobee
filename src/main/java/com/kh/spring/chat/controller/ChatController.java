package com.kh.spring.chat.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.kh.spring.chat.model.service.ChatService;
import com.kh.spring.chat.model.vo.Chat;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;

@Controller
public class ChatController {

	@Autowired
	private ChatService cService;
	
	/**
	 * - 채팅한사람 목록(리스트) 불러오기
	 * @param userId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("oneChatList.do")
	public void oneChatList(String userId,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		ArrayList<Chat> cList = cService.getChatList(userId);
		ArrayList<Member> mList = new ArrayList<Member>();
		Member m = null;
		for(Chat c : cList) {
			if(c == null) {
				continue;
			} else if(c.getCrNo() > 0 && (c.getcContent() == null || c.getcContent().equals(""))) {
				continue;
			} else if(c.getFromId().equals("group") || c.getToId().equals("group")) {
				continue;
			} else if(c.getFromId().equals(userId)) {
				m = new Member();
				m.setUserId(c.getToId());
				mList.add(m);
			} else {
				m = new Member();
				m.setUserId(c.getFromId());
				mList.add(m);
			}
		}
		ArrayList<Member> rmList = cService.getChatImage(mList);
		JSONObject job = null;
		JSONArray result = new JSONArray();
		for(Chat c : cList) {
			if(c == null) {
				continue;
			} else if(c.getCrNo() > 0 && (c.getcContent() == null || c.getcContent().equals(""))) {
				continue;
			} else if(c.getFromId().equals("group") || c.getToId().equals("group")){
				continue;
			} else {
				job = new JSONObject();
				for(Member m2 : rmList) {
					if(c.getFromId().equals(m2.getUserId()) || c.getToId().equals(m2.getUserId())) {
						job.put("crNo", c.getCrNo());
						job.put("fromId", c.getFromId());
						job.put("toId", c.getToId());
						job.put("cContent",c.getcContent());
						if(!c.getFromId().equals(userId)) {
							job.put("read",c.getcRead());
						}
						if(m2.getmRenameImage() == null || m2.getmRenameImage().equals("")) {
							if(m2.getmImage() == null || m2.getmImage().equals("")) {
								job.put("chatImage", "icons/logo.png");
							} else {
								job.put("chatImage", "memberProfileFiles/"+m2.getmImage());
							}
						} else {
							job.put("chatImage", "memberProfileFiles/"+m2.getmRenameImage());
						}
					result.add(job);
					} else {
						continue;
					}
				}
			}
		}
		PrintWriter out = response.getWriter();
		out.print(result);
	}
	
	/**
	 * - 채팅 내용 불러오기
	 * @param crNo
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("oneChatContentList.do")
	public void oneChatContentList(String crNo,String readId, HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		int rcrNo = Integer.parseInt(crNo);
		Chat readC = new Chat();
		readC.setCrNo(rcrNo);
		readC.setFromId(readId);
		ArrayList<Chat> cList = cService.getChatContentList(readC);
		ArrayList<Member> mList = new ArrayList<Member>();
		for(Chat c : cList) {
			Member m = new Member();
			m.setUserId(c.getFromId());
			mList.add(m);
		}
		ArrayList<Member> resultList = cService.getChatImage(mList); 
		JSONObject job = null;
		JSONArray result = new JSONArray();
		for(Chat c : cList) {
			job = new JSONObject();
			for(Member m2 : resultList) {
				if(c.getFromId().equals(m2.getUserId())) {
					job.put("crNo", c.getCrNo());
					job.put("fromId", c.getFromId());
					job.put("toId", c.getToId());
					job.put("cContent",c.getcContent());
					if(m2.getmRenameImage() == null || m2.getmRenameImage().equals("")) {
						if(m2.getmImage() == null || m2.getmImage().equals("")) {
							job.put("chatImage", "icons/logo.png");
						} else {
							job.put("chatImage", "memberProfileFiles/"+m2.getmImage());
						}
					} else {
						job.put("chatImage", "memberProfileFiles/"+m2.getmRenameImage());
					}
				result.add(job);
				break;
				} 
			}
		}
		PrintWriter out = response.getWriter();
		out.print(result);
	}
	
	/**
	 * - 채팅방 생성
	 * @param myId
	 * @param otherId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("insertChatRoom.do")
	public void insertChatRoom(String myId, String otherId,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		int crNo = cService.insertChatRoom(myId,otherId);
		JSONObject job = new JSONObject();
		if(crNo > 0) {
			job.put("toId", otherId);
			job.put("crNo", crNo);
		}
		PrintWriter out = response.getWriter();
		out.print(job);
	}
	
	/**
	 * - 읽은 채팅 카운트
	 * @param myId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("countChat.do")
	public void countChat(String myId,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		int count = cService.countChat(myId);
		JSONObject job = new JSONObject();
		job.put("countChat", count);
		PrintWriter out = response.getWriter();
		out.print(job);
	}
	
	/**
	 * - 그룹 채팅방 만들기
	 * @param createId
	 * @param gNo
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("insertGroupChatRoom.do")
	public void insertGroupChatRoom(String createId, String gNo,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		System.out.println(createId+":"+gNo);
		int crNo = cService.insertGroupChatRoom(createId);
		JSONObject job = new JSONObject();
		job.put("crNo", crNo);
		job.put("gNo", gNo);
		PrintWriter out = response.getWriter();
		out.print(job);
	}
	
	/**
	 * - 그룹 채팅 목록 불러오기
	 * @param userId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("GroupChatList.do")
	public void groupChatList(String userId,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		ArrayList<Chat> cList = cService.getGroupChatList(userId);
		JSONArray result = new JSONArray();
		for(Chat c : cList) {
			JSONObject job = new JSONObject();
			job.put("crNo", c.getCrNo());
			job.put("fromId", c.getFromId());
			job.put("cContent",c.getcContent());
			job.put("gName",c.getgName());
			if(!c.getFromId().equals(userId)) {
				job.put("read",c.getcRead());
			}
			if(c.getgReImage() == null || c.getgReImage().equals("")) {
				job.put("chatImage", "icons/logo.png");
			} else {
				job.put("chatImage", "gUploadFiles/"+c.getgReImage());
			}
			result.add(job);
		}
		PrintWriter out = response.getWriter();
		out.print(result);
	}

	/**
	 * - 메세지 보내기
	 * @param c
	 * @param fromId
	 * @param toId
	 * @param rmsg
	 * @param crNo
	 * @return
	 */
	public int sendMessage(Chat c,String fromId, String toId, String rmsg, int crNo) {
		int result = 0;
		if(Integer.parseInt(toId) > 0) {
			c.setFromId(fromId);
			c.setToId("group");
			c.setcContent(rmsg);
			c.setCrNo(crNo);
			c.setgNo(Integer.parseInt(toId));
			result = cService.insertGroupChat(c);
		} else {
			c.setFromId(fromId);
			c.setToId(toId);
			c.setcContent(rmsg);
			c.setCrNo(crNo);
			result = cService.insertChat(c);
		}
		
		if(result > 0) {
			return result;
		} else {
			return -1;
		}
	}
	
}
