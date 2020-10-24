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

	/**
	 * 2. 채팅방 내용 불러오기
	 * @param crNo
	 * @return
	 */
	ArrayList<Chat> getChatContentList(int crNo);

	/**
	 * 3. 채팅내용 인서트
	 * @param c
	 * @return
	 */
	int insertChat(Chat c);

}
