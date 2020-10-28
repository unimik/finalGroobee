package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Reply;

public interface FeedService {

	
	/**
	 * 1_1. 포스트 작성
	 * @param f
	 * @return
	 *
	 */
	int insertPost(Feed f);

	/**
	 * 2_1. 피드 리스트 조회(게시글, 댓글)
	 * @return
	 *
	 */
	ArrayList<Feed> selectFeed();

	int updatePost(Feed f);
}
