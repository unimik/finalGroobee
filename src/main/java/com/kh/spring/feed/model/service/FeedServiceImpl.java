package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.feed.model.dao.FeedDao;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;

@Service("fService")
public class FeedServiceImpl implements FeedService {

	@Autowired
	private FeedDao fDao;
	
	@Override
	public int insertPost(Feed f) {
		return fDao.insertPost(f);
	}
	
	@Override
	public int insertPhoto(Photo p) {
		return fDao.insertPhoto(p);
	}

	@Override
	public ArrayList<Feed> selectFeed() {
		return fDao.selectFeed();
	}

	@Override
	public int updatePost(Feed f) {
		return 0;
	}

	@Override
	public ArrayList<GroupMember> selectGroupMemberId(String userId) {
		return fDao.selectGroupMemberId(userId);
	}

	@Override
	public ArrayList<Group> selectGroupName(int gNo) {
		return fDao.selectGroupName(gNo);
	}



}
