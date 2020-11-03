package com.kh.spring.feed.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;

@Repository("fDao")
public class FeedDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertPost(Feed f) {
		return sqlSession.insert("feedMapper.insertPost", f);
	}

	public int insertPhoto(Photo p) {
		return sqlSession.insert("feedMapper.insertPhoto", p);
	}
	
	public ArrayList<Feed> selectFeed() {
		return (ArrayList)sqlSession.selectList("feedMapper.selectFeed");
	}

	public ArrayList<GroupMember> selectGroupMemberId(String userId) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectGroupMemberId", userId);
	}

	public ArrayList<Group> selectGroupName(int gNo) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectGroupName", gNo);
	}


	

}
