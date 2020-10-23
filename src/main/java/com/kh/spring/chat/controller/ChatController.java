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
		System.out.println(userId);
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

	public int sendMessage(String fromId, String toId, String rmsg, int crNo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
