package com.kh.spring.chat.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.chat.model.vo.Chat;
import com.kh.spring.member.model.vo.Member;

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

	public ArrayList<Member> getChatImage(ArrayList<Member> mList) {
		ArrayList<Member> rmList = new ArrayList<Member>();
		for(Member m : mList) {
			String userId = m.getUserId();
			rmList.add(sqlSession.selectOne("memberMapper.getChatImage",userId));
		}
		return rmList;
	}

	public int insertChatRoom(String myId, String otherId) {
		Chat c1 = new Chat();
		Chat c2 = new Chat();
		c1.setFromId(myId);
		c2.setFromId(otherId);
		int insertChatRoomResult = sqlSession.insert("chatMapper.insertChatRoom");
		if(insertChatRoomResult > 0) {
			int crNo = sqlSession.selectOne("chatMapper.getFirstCrno");
			c1.setCrNo(crNo);
			c2.setCrNo(crNo);
			int insertJoinResult1 = sqlSession.insert("chatMapper.insertJoinRoom",c1);
			int insertJoinResult2 = sqlSession.insert("chatMapper.insertJoinRoom",c2);
			if(insertJoinResult1 > 0 && insertJoinResult2 > 0) {
				return crNo;
			} else 
				return 0;
		} else {
			return 0;
		}
	}

}
