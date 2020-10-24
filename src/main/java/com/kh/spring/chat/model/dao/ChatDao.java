package com.kh.spring.chat.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.chat.model.vo.Chat;

@Repository("cDao")
public class ChatDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Chat> getChatList(String userId) {
		 ArrayList<Chat> crNoList = (ArrayList)sqlSession.selectList("chatMapper.getCrNo",userId);
		 ArrayList<Chat> cList = new ArrayList<Chat>();
		 for (Chat c : crNoList) {
			Chat result = sqlSession.selectOne("chatMapper.getChatList",c);
			cList.add(result);
		}
		return cList;
	}

	public ArrayList<Chat> getChatContentList(int crNo) {
		return (ArrayList)sqlSession.selectList("chatMapper.getChatContentList",crNo);
	}

	public int insertChat(Chat c) {
		return sqlSession.insert("chatMapper.insertChat",c);
	}

}
