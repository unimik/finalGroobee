package com.kh.spring.myPage.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.member.model.vo.Follow;
import com.kh.spring.member.model.vo.Member;
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
	public ArrayList<Feed> selectFeedInfo(int mNo) {
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

	@Override
	public ArrayList<Mypage> selectGroupInfo(int mNo) {
		return myDao.selectGroupInfo(mNo);
	}

	@Override
	public String selectFollowYN(Follow fw) {
		return myDao.selectFollowYN(fw);
	}

	@Override
	public int insertFollow(Follow fw) {
		return myDao.insertFollow(fw);
	}

	@Override
	public int deleteFollow(Follow fw) {
		return myDao.deleteFollow(fw);
	}
	

}
