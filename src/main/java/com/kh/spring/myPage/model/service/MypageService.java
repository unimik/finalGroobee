package com.kh.spring.myPage.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.member.model.vo.Follow;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.vo.Mypage;
import com.kh.spring.myPage.model.vo.StorageBox;

public interface MypageService {

	Mypage selectMemInfo(int mNo);

	Mypage selectFollowInfo(int mNo);

	ArrayList<Feed> selectFeedInfo(int mNo);

	ArrayList<StorageBox> selectStorageBoxInfo(int mNo);

	int insertBox(int mNo);

	ArrayList<Mypage> selectGroupInfo(int mNo);

	String selectFollowYN(Follow fw);

	int insertFollow(Follow fw);

	int deleteFollow(Follow fw);

	ArrayList<Mypage> selectFollowerList(int mNo);

	ArrayList<Mypage> selectFollowingList(int mNo);

	/**
	 * 보관함 이름 수정
	 * @param sblist
	 * @return
	 */
	int updateBox(ArrayList<StorageBox> sblist);

	/**
	 * 보관함 삭제
	 * @param sblist
	 * @return
	 */
	int deleteteBox(StorageBox sb);


	/**
	 * 게시글 가져오기
	 * @param fnos
	 * @return
	 */
	ArrayList<Feed> sBoxfList(StorageBox sb);

	Feed detailFeed(Feed f);

	ArrayList<Photo> selectPhotoList(int fno);

	ArrayList<Reply> selectReplyList(int fno);









}
