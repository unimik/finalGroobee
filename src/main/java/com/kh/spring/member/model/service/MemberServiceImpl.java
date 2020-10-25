package com.kh.spring.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dao.MemberDao;
import com.kh.spring.member.model.vo.Member;

@Service("mService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDao mDao;
	
	@Override
	public Member loginMember(Member m) {
		return mDao.loginMember(m);
	}

	@Override
	public int idCheck(String userId) {
		return mDao.idCheck(userId);
	}

	@Override
	public int insertMember(Member m) {
		return mDao.insertMember(m);
	}

	@Override
	public String findId(Member m) {
		return mDao.findId(m);
	}

	@Override
	public int findPwd(Member m) {
		return mDao.findPwd(m);
	}

	@Override

	public int totalMember() {
		return mDao.totalMember();
	}


	@Override
	public Member selectOne(String mNo) {
		return mDao.selectOne(mNo);
	}

	@Override
	public int disableAccount(int mNo) {
		return mDao.disableAccount(mNo);
	}

	@Override
	public int memberUpdate(Member m) {
		return mDao.memberUpdate(m);
	}

	@Override
	public int deleteAccount(int mNo) {
		return mDao.deleteAccount(mNo);
	}

	@Override
	public Member selectNo(String mId) {
		return mDao.selectNo(mId);
	}

	@Override
	public ArrayList<Member> memberSearchList(Member m) {
		return mDao.memberSearchList(m);
	}

}
