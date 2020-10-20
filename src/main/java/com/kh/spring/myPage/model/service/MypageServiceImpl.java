package com.kh.spring.myPage.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.myPage.model.dao.MypageDao;
import com.kh.spring.myPage.model.vo.Mypage;


@Service("myService")
public class MypageServiceImpl implements MypageService {

	@Autowired
	MypageDao myDao;

	@Override
	public Mypage selectMemInfo(int mNo) {
		return myDao.selectMemInfo(mNo);
	}

	@Override
	public Mypage selectFollowInfo(int mNo) {
		return myDao.selectFollowInfo(mNo);
	}

	@Override
	public ArrayList<Mypage> selectFeedInfo(int mNo) {
		return myDao.selectFeedInfo(mNo);
	}

	@Override
	public ArrayList<Mypage> selectStorageBoxInfo(int mNo) {
		return myDao.selectStorageBoxInfo(mNo);
	}

	@Override
	public int insertBox(int mNo) {
		return myDao.insertBox(mNo);
	}
	

}