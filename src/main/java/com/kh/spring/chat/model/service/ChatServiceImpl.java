package com.kh.spring.chat.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.chat.model.dao.ChatDao;
import com.kh.spring.chat.model.vo.Chat;

@Service("cService")
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	ChatDao cDao;

	@Override
	public ArrayList<Chat> getChatList(String userId) {
		return cDao.getChatList(userId);
	}

}
