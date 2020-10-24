package com.kh.spring.chat.model.service;

import java.util.ArrayList;

import com.kh.spring.chat.model.vo.Chat;

public interface ChatService {

	/**
	 * 1. 채팅방 리스트 가져오기
	 * @param userId
	 * @return
	 */
	ArrayList<Chat> getChatList(String userId);

}
