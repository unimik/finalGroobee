package com.kh.spring.feed.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.feed.model.vo.Feed;

@Repository("fDao")
public class FeedDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertPost(Feed f) {
		return sqlSession.insert("feedMapper.insertPost", f);
	}
	
	

}