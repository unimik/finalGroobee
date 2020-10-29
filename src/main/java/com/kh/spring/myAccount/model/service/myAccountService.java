package com.kh.spring.myAccount.model.service;

import java.util.ArrayList;

import com.kh.spring.myAccount.model.vo.myAccount;

public interface myAccountService {


	/**
	 * 1. 나를 팔로우한 리스트
	 * @param mNo
	 * @return
	 */
	ArrayList<myAccount> selectFollowers(int mNo);
	
	/**
	 * 2. 내가 팔로우한 리스트
	 * @param mNo
	 * @return
	 */
	ArrayList<myAccount> selectFollows(int mNo);
	

	/**
	 * 3. 내 그룹 리스트
	 * @param mNo
	 * @return
	 */
	ArrayList<myAccount> selectGroupList(String mId);

	/**
	 * 4. 팔로우한 아이디 삭제
	 * @param ma
	 * @return
	 */
	int delFollow(myAccount ma);

	
	

}
