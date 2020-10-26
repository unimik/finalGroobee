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

import com.google.gson.JsonArray;
import com.kh.spring.chat.model.service.ChatService;
import com.kh.spring.chat.model.vo.Chat;

@Controller
public class ChatController {

	@Autowired
	private ChatService cService;
	
	@RequestMapping("oneChatList.do")
	public void oneChatList(String userId,HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		ArrayList<Chat> cList = cService.getChatList(userId);
		JSONObject job = null;
		JSONArray result = new JSONArray();
		for(Chat c : cList) {
			job = new JSONObject();
			job.put("crNo", c.getCrNo());
			job.put("fromId", c.getFromId());
			job.put("toId", c.getToId());
			job.put("cContent",c.getcContent());
			
			result.add(job);
		}
		PrintWriter out = response.getWriter();
		out.print(result);
	}
	
	@RequestMapping("oneChatContentList.do")
	public void oneChatContentList(String crNo, HttpServletResponse response) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		int rcrNo = Integer.parseInt(crNo);
		ArrayList<Chat> cList = cService.getChatContentList(rcrNo);
		
		JSONObject job = null;
		JSONArray result = new JSONArray();
		for(Chat c : cList) {
			job = new JSONObject();
			
			job.put("crNo", c.getCrNo());
			job.put("fromId", c.getFromId());
			job.put("toId", c.getToId());
			job.put("cContent", c.getcContent());
			
			result.add(job);
		}
		PrintWriter out = response.getWriter();
		out.print(result);
	}

	public int sendMessage(Chat c,String fromId, String toId, String rmsg, int crNo) {
		c.setFromId(fromId);
		c.setToId(toId);
		c.setcContent(rmsg);
		c.setCrNo(crNo);
		int result = cService.insertChat(c);
		if(result > 0) {
			return result;
		} else {
			return -1;
		}
	}
	
}
