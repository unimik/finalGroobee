package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;

public interface FeedService {

	
	/**
	 * 1_1. 포스트 작성
	 * @param f
	 * @return
	 *
	 */
	int insertPost(Feed f);

	/**
	 * 1_2. 피드 리스트 조회
	 * @return
	 *
	 */
	ArrayList<Feed> selectList();

}
