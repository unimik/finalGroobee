package com.kh.spring.myPage.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.vo.Mypage;

public interface MypageService {

	Mypage selectMemInfo(int mNo);

	Mypage selectFollowInfo(int mNo);

	ArrayList<Feed> selectFeedInfo(int mNo);

	ArrayList<Mypage> selectStorageBoxInfo(int mNo);

	int insertBox(int mNo);

	ArrayList<Mypage> selectGroupInfo(int mNo);



}
