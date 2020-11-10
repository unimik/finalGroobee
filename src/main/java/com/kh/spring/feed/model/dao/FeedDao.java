package com.kh.spring.feed.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.group.model.vo.GroupName;

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
	
	public ArrayList<Feed> selectFeed(String userId) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectFeed",userId);
	}

	public ArrayList<GroupName> selectGroupMemberId(String userId) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectGroupMemberId", userId);
	}

	public Feed selectUpdateFeed(int fNo) {
		return sqlSession.selectOne("feedMapper.selectUpdateFeed", fNo);
	}


	public ArrayList<Feed> selectGfList() {
		return (ArrayList)sqlSession.selectList("feedMapper.selectGfList");
	}

	public int updatePost(Feed f) {
		return sqlSession.update("feedMapper.updatePost", f);
	}

	public int updatePhoto(Photo p) {
		return sqlSession.update("feedMapper.updatePhoto", p);
	}

	public int deletePost(int fNo) {
		return sqlSession.update("feedMapper.deletePost", fNo);
	}

	public ArrayList<Feed> selectGfeed(int gNo) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectGfeed", gNo);
	}

	public ArrayList<Feed> selectHGfeed(int gNo) {
		return (ArrayList)sqlSession.selectList("feedMapper.selectHGfeed", gNo);
	}




	

}
