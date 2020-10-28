package com.kh.spring.myAccount.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.myAccount.model.dao.myAccountDao;
import com.kh.spring.myAccount.model.vo.myAccount;

@Service("maService")
public class myAccountServiceImpl implements myAccountService{
	
	@Autowired
	myAccountDao maDao;
	
	
	@Override
	public ArrayList<myAccount> selectFollowers(int mNo) {
		return maDao.selectFollowers(mNo);
	}
		
	@Override
	public ArrayList<myAccount> selectFollows(int mNo) {
		return maDao.selectFollows(mNo);
	}

	@Override
	public ArrayList<myAccount> selectGroupList(String mId) {
		return maDao.selectGroupList(mId);
	}

	@Override
	public int delFollow(myAccount ma) {
		return maDao.delFollow(ma);
	}

	
}
