package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.feed.model.dao.FeedDao;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.group.model.vo.GroupName;

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
	public ArrayList<Feed> selectFeed(String userId) {
		return fDao.selectFeed(userId);
	}

	@Override
	public ArrayList<GroupName> selectGroupMemberId(String userId) {
		return fDao.selectGroupMemberId(userId);
	}
	
	@Override
	public Feed selectUpdateFeed(int fNo) {
		return fDao.selectUpdateFeed(fNo);
	}
	
	@Override
	public ArrayList<Feed> selectGfList() {
		return fDao.selectGfList();
	}

	public int deletePost(int fNo) {
		return fDao.deletePost(fNo);
	}

	@Override
	public int updatePost(Feed f) {
		return fDao.updatePost(f);
	}
	@Override
	public ArrayList<Feed> selectGfeed(int gNo) {
		return fDao.selectGfeed(gNo);
	}

	@Override
	public ArrayList<Feed> selectHGfeed(int gNo) {
		return fDao.selectHGfeed(gNo);
	}

	@Override
	public int updatePhoto(Photo p) {
		return fDao.updatePhoto(p);
	}

	@Override
	public int insertReply(Reply r) {
		return fDao.insertReply(r);
	}

	@Override
	public Feed popFeed(int fno) {
		return fDao.popFeed(fno);
	}

	@Override
	public int updateReply(Reply r) {
		return fDao.updateReply(r);
	}

}