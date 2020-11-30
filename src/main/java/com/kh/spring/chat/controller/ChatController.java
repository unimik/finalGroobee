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
import com.kh.spring.group.model.service.GroupService;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;

@Controller
public class ChatController {

	@Autowired
	private ChatService cService;
	
	@Autowired
	private GroupService gService;
	
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
						if(c.getcContent().length() > 18) {
							job.put("cContent",c.getcContent().substring(0,17)+"...");
						} else {
							job.put("cContent",c.getcContent());
						}
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
					job.put("cNo",c.getcNo());
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
	
	@RequestMapping("GroupChatContentList.do")
	public void GroupChatContentList(int crNo,int readId, HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		Chat chat = new Chat();
		chat.setCrNo(crNo);
		ArrayList<Chat> cList = cService.getGroupChatContentList(chat);
		ArrayList<Member> mList = new ArrayList<Member>();
		for(Chat cc : cList) {
			Member m = new Member();
			m.setUserId(cc.getFromId());
			mList.add(m);
		}
		ArrayList<Member> resultList = cService.getChatImage(mList); 
		JSONObject job = null;
		JSONArray result = new JSONArray();
		for(Chat c : cList) {
			job = new JSONObject();
			for(Member m2 : resultList) {
				if(c.getFromId().equals(m2.getUserId())) {
					job.put("cNo",c.getcNo());
					job.put("crNo", c.getCrNo());
					job.put("fromId", c.getFromId());
					job.put("gNo", c.getgNo());
					job.put("cContent",c.getcContent());
					job.put("gName",c.getgName());
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
		if(crNo == -1) {
			job.put("crNo", -1);
		} else {
			if(crNo > 0) {
				job.put("toId", otherId);
				job.put("crNo", crNo);
			}
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
		Chat c = new Chat();
		int rgNo = Integer.parseInt(gNo);
		c.setgNo(rgNo);
		c.setFromId(createId);
		int crNo = cService.insertGroupChatRoom(c);
		JSONObject job = new JSONObject();
		if(crNo == -1) {
			job.put("crNo", -1);
		} else {
			job.put("crNo", crNo);
			job.put("gNo", gNo);
		}
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
			job.put("gNo",c.getgNo());
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
	 * - 채팅방 추가 상대 불러오기
	 * @param gNo
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("findGroupMember.do")
	public void findGroupMember(int gNo,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		ArrayList<GroupMember> gList = gService.selectGmList(gNo);
		ArrayList<Chat> cList = cService.getJoinMember(gNo);
		System.out.println(gNo);
		JSONObject job = null;
		JSONArray result = new JSONArray();
		for(Chat c : cList) {
			for(GroupMember g : gList) {
				if(c.getJoinId().equals(g.getGmId())) {
					gList.remove(g);
					break;
				} else {
					continue;
				}
			}
		}
		for(GroupMember g : gList) {
			job = new JSONObject();
			job.put("gmId", g.getGmId());
			if(g.getGmImage() == null || g.getGmImage().equals("")) {
				job.put("gmImage", "icons/logo.png");
			} else {
				job.put("gmImage","memberProfileFiles/"+g.getGmImage());
			}
			result.add(job);
		}
		PrintWriter out = response.getWriter();
		out.print(result);
		
	}
	
	/**
	 * - 스크롤 올리면 채팅내용 가져오기(1대1)
	 * @param crNo
	 * @param cNo
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("chatContentLoad.do")
	public void chatContentLoad(int crNo, int cNo, HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		Chat loadC = new Chat();
		loadC.setCrNo(crNo);
		loadC.setcNo(cNo);
		ArrayList<Chat> cList = cService.chatContentLoad(loadC);
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
					job.put("cNo",c.getcNo());
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
	 * - 스크롤 올리면 가져오기(그룹)
	 * @param gNo
	 * @param crNo
	 * @param cNo
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("groupChatContentLoad.do")
	public void groupChatContentLoad(int gNo,int crNo, int cNo, HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		Chat chat = new Chat();
		chat.setCrNo(crNo);
		chat.setgNo(gNo);
		chat.setcNo(cNo);
		ArrayList<Chat> cList = cService.groupChatContentLoad(chat);
		ArrayList<Member> mList = new ArrayList<Member>();
		for(Chat cc : cList) {
			Member m = new Member();
			m.setUserId(cc.getFromId());
			mList.add(m);
		}
		ArrayList<Member> resultList = cService.getChatImage(mList); 
		JSONObject job = null;
		JSONArray result = new JSONArray();
		for(Chat c : cList) {
			job = new JSONObject();
			for(Member m2 : resultList) {
				if(c.getFromId().equals(m2.getUserId())) {
					job.put("cNo",c.getcNo());
					job.put("crNo", c.getCrNo());
					job.put("fromId", c.getFromId());
					job.put("gNo", c.getgNo());
					job.put("cContent",c.getcContent());
					job.put("gName",c.getgName());
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
	 * - 채팅방 상대 추가하기
	 * @param plusId
	 * @param gNo
	 * @param crNo
	 */
	@ResponseBody
	@RequestMapping("plusGroupChatMember.do")
	public String plusGroupChatMember(String plusId, int gNo, int crNo) {
		Chat c = new Chat();
		c.setFromId(plusId);
		c.setgNo(gNo);
		c.setCrNo(crNo);
		int result = cService.insertJoinChatRoom(c);
		if(result > 0) {
			return "ok";
		} else {
			return "fail";
		}
	}
	
	/**
	 * - 일대일 채팅방 나가기
	 * @param crNo
	 * @return
	 */
	@ResponseBody
	@RequestMapping("deleteOneChat.do")
	public String deleteOneChat(int crNo) {
		int result = cService.deleteOneChat(crNo);
		
		if(result > 0) {
			return "ok";
		} else {
			if(result == -1) {
				return "chatError";
			} else if(result == -2) {
				return "joinRoomError";
			} else if(result == -3){
				return "chatRoomError";
			} else {
				return "fail";
			}
		}
	}
	
	@ResponseBody
	@RequestMapping("deleteGroupChat.do")
	public String deleteGroupChat(Chat c) {
		int result = cService.deleteGroupChat(c);
		if(result > 0) {
			return "ok";
		} else {
			return "fail";
		}
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
		c.setFromId(fromId);
		c.setToId(toId);
		c.setcContent(rmsg);
		c.setCrNo(crNo);
		result = cService.insertChat(c);
		
		if(result > 0) {
			return result;
		} else {
			return -1;
		}
	}

	/**
	 * - 그룹 메세지 보내기
	 * @param c
	 * @param fromId
	 * @param toId
	 * @param rmsg
	 * @param crNo
	 * @return
	 */
	public int sendMessageGroup(Chat c, String fromId, String toId, String rmsg, int crNo) {
		int gNo = Integer.parseInt(toId);
		int result = 0;
		c.setFromId(fromId);
		c.setgNo(gNo);
		c.setToId("group");
		if(rmsg.length() > 7) {
			if(rmsg.substring((rmsg.length()-4), rmsg.length()).equals("!@#$")) {
				c.setcContent(rmsg.substring(0, rmsg.length()-4)+"님이 입장하셨습니다.");
			} else {
				c.setcContent(rmsg);
			}
		} else {
			c.setcContent(rmsg);
		}
		c.setCrNo(crNo);
		System.out.println(c);
		result = cService.insertChat(c);
		if(rmsg.length() > 7) {
			if(rmsg.substring((rmsg.length()-4), rmsg.length()).equals("!@#$")) {
				return -1;
			} else {
				return result;
			}
		} else {
			return result;
		}
		
	}
	
}
