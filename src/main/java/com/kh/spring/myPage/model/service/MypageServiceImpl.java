package com.kh.spring.myPage.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.member.model.vo.Follow;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.dao.MypageDao;
import com.kh.spring.myPage.model.vo.Mypage;
import com.kh.spring.myPage.model.vo.StorageBox;


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
	public ArrayList<StorageBox> selectStorageBoxInfo(int mNo) {
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

	@Override
	public ArrayList<Mypage> selectFollowerList(int mNo) {
		return myDao.selectFollowerList(mNo);
	}

	@Override
	public ArrayList<Mypage> selectFollowingList(int mNo) {
		return myDao.selectFollowingList(mNo);
	}

	@Override
	public int updateBox(ArrayList<StorageBox> sblist) {
		return myDao.updateBox(sblist);
	}

	@Override
	public int deleteteBox(StorageBox sb) {
		return myDao.deleteBox(sb);
	}

	@Override
	public ArrayList<Feed> sBoxfList(StorageBox sb) {
		return myDao.sBoxfList(sb);
	}

	@Override
	public Feed detailFeed(Feed f) {
		return myDao.detailFeed(f);
	}

	@Override
	public ArrayList<Photo> selectPhotoList(int fno) {
		return myDao.selectPhotoList(fno);
	}

	@Override
	public ArrayList<Reply> selectReplyList(int fno) {
		return myDao.selectReplyList(fno);
	}

	@Override
	public int shareFeedCancle(Feed f) {
		return myDao.shareFeedCancle(f);
	}



	

}
