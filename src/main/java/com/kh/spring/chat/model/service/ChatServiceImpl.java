package com.kh.spring.chat.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.chat.model.dao.ChatDao;
import com.kh.spring.chat.model.vo.Chat;
import com.kh.spring.member.model.vo.Member;

@Service("cService")
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	ChatDao cDao;

	@Override
	public ArrayList<Chat> getChatList(String userId) {
		return cDao.getChatList(userId);
	}

	@Override
	public ArrayList<Chat> getChatContentList(Chat readC) {
		return cDao.getChatContentList(readC);
	}

	@Override
	public int insertChat(Chat c) {
		return cDao.insertChat(c);
	}

	@Override
	public ArrayList<Member> getChatImage(ArrayList<Member> mList) {
		return cDao.getChatImage(mList);
	}

	@Override
	public int insertChatRoom(String myId, String otherId) {
		return cDao.insertChatRoom(myId,otherId);
	}

	@Override
	public int countChat(String myId) {
		return cDao.countChat(myId);
	}

	@Override
	public int insertGroupChatRoom(String createId) {
		return cDao.insertGroupChatRoom(createId);
	}

	@Override
	public ArrayList<Chat> getGroupChatList(String userId) {
		return cDao.getGroupChatList(userId);
	}

	@Override
	public int insertGroupChat(Chat c) {
		return cDao.insertGroupChat(c);
	}

}
