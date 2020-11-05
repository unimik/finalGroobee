package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.group.model.vo.GroupName;

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
	
	/**
	 * 2_2. 포스트 수정(게시글)
	 * @return
	 *
	 */
	Feed selectUpdateFeed(int fNo);
	int updatePost(Feed f);

	/**
	 * 2_3. 포스트 삭제(게시글)
	 * @return
	 *
	 */
	int deletePost(int fNo);
	
	/**
	 *  가입한 그룹 조회
	 * @param userId
	 * @return
	 */
	ArrayList<GroupName> selectGroupMemberId(String userId);
	

	ArrayList<Feed> selectGfList();

	
	


}
