package com.kh.spring.feed.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.feed.model.dao.FeedDao;
import com.kh.spring.feed.model.vo.Feed;

@Service("fService")
public class FeedServiceImpl implements FeedService {

	@Autowired
	private FeedDao fDao;
	
	@Override
	public int insertPost(Feed f) {
		
		return fDao.insertPost(f);
	}

}
