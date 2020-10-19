package com.kh.spring.myPage.model.service;

import java.util.ArrayList;

import com.kh.spring.myPage.model.vo.Mypage;

public interface MypageService {

	Mypage selectMemInfo(int mNo);

	Mypage selectFollowInfo(int mNo);

	ArrayList<Mypage> selectFeedInfo(int mNo);

	ArrayList<Mypage> selectStorageBoxInfo(int mNo);

	int insertBox(int mNo);



}
