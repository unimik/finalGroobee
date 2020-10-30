package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.feed.model.dao.FeedDao;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;

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



}
