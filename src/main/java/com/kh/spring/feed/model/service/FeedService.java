package com.kh.spring.feed.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.LikeIt;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.feed.model.vo.ShareFeed;
import com.kh.spring.feed.model.vo.Tag;
import com.kh.spring.group.model.vo.GroupName;
import com.kh.spring.myPage.model.vo.StorageBox;

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
	ArrayList<Feed> selectFeed(String userId);
	
	/**
	 * 2_2. 포스트 수정(게시글)
	 * @return
	 *
	 */
	Feed selectUpdateFeed(int fNo);
	int updatePost(Feed f);
	int updatePhoto(Photo p);

	/**
	 * 2_3. 포스트 삭제(게시글)
	 * @return
	 *
	 */
	int deletePost(int fNo);
	
	/**
	 * 3_1. 댓글 작성
	 * @return
	 */
	int insertReply(Reply r);
	
	/**
	 * 3_2. 댓글 수정
	 * @return
	 */
	int updateReply(Reply r);

	/**
	 * 3_3. 댓글 삭제
	 * @return
	 */
	int deleteReply(int rNo);
	
	/**
	 *  가입한 그룹 조회
	 * @param userId
	 * @return
	 */
	ArrayList<GroupName> selectGroupMemberId(String userId);
	

	/**
	 *  전체 그룹피드 리스트
	 * @return
	 */
	ArrayList<Feed> selectGfList();
	
	/**
	 * 한 그룹의 피드 최신순 리스트
	 * @param gNo
	 * @return
	 */
	ArrayList<Feed> selectGfeed(int gNo);
	
	/**
	 * 한 그룹의 피드 인기순 리스트
	 * @param gNo
	 * @return
	 */
	ArrayList<Feed> selectHGfeed(int gNo);
	
	/**
	 * 피드 팝업
	 * @param fno
	 * @return
	 */
	Feed popFeed(int fno);
	
	/**

	 * 좋아요 받을시 아이디 추가
	 * @param lI
	 * @return
	 */
	int insertLike(LikeIt lI);
	/**
	 * 좋아요 눌렀을 때 카운트 증
	 * @param fNo
	 * @return
	 */
	int likeUp(String fNo);
	
	/**
	 * 좋아요 눌렀을 때 카운트 감
	 * @param fNo
	 * @return
	 */
	int likeDown(String fNo);
	
	/**
	 *  로그인 된 회원이 좋아요를 눌렀는지 확
	 * @param like
	 * @return
	 */
	int selectlike(LikeIt like);
	int deleteLike(LikeIt like);
	
	

	 /* 공유하기 insert
	 * @param fNo
	 * @param mNo
	 * @return
	 */
	int insertShare(ShareFeed sf);
	
	int insertTag(ArrayList<Tag> taglist);
	
	int selectTag(int fNo);
	
	int deleteTag(int fNo);
	
	/**
	 * 보관함에 insert
	 * @param sb
	 * @return
	 */
	int insertStorage(StorageBox sb);
	
	/**
	 * 맴버 있는지 확인
	 * @param string
	 * @return
	 */
	int findTagMember(String string);
	
	
	 /* 사진 리스트
	 * @param getfNo
	 * @return
	 */
	ArrayList<Photo> selectPhotoList(int getfNo);
	
}