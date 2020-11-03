package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;

public interface FeedService {

	
	/**
	 * 1_1. 포스트 작성
	 * @param f, p
	 * @return
	 *
	 */
	int insertPost(Feed f);
	int insertPhoto(Photo p);

	/**
	 * 2_1. 피드 리스트 조회(게시글, 댓글)
	 * @return
	 *
	 */
	ArrayList<Feed> selectFeed();

	int updatePost(Feed f);
	
	/**
	 *  가입한 그룹 조회
	 * @param userId
	 * @return
	 */
	ArrayList<GroupMember> selectGroupMemberId(String userId);
	ArrayList<Group> selectGroupName(int gNo);

}
