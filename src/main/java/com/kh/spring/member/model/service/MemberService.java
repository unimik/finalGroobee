package com.kh.spring.member.model.service;

import java.util.ArrayList;

import com.kh.spring.member.model.vo.Follow;
import com.kh.spring.member.model.vo.Member;

public interface MemberService {

	/**
	 * 1. 로그인
	 * @param userId
	 * @param userPwd
	 * @return
	 */
	Member loginMember(Member m);

	/**
	 * 2. id 중복확인
	 * @param userId
	 * @return
	 */
	int idCheck(String userId);

	/**
	 * 3. 회원가입
	 * @param m
	 * @return
	 */
	int insertMember(Member m);

	/**
	 * 4. 아이디 찾기
	 * @param m
	 * @return
	 */
	String findId(Member m);

	/**
	 * 5. 난수로 임시비밀번호 설정하기
	 * @param m
	 * @return
	 */
	int findPwd(Member m);

	/** 6. 총 회원 수
	 * @return
	 */
	int totalMember();

	Member selectOne(String mNo);
	
	int disableAccount(int mNo);

	int memberUpdate(Member m);

	int deleteAccount(int mNo);
	
	Member selectNo(String userId);

	ArrayList<Member> memberSearchList(Member m);
	
	int selectOriginalPwdCheck(Member m);

	int updatePwd(Member m);

	Member selectUserInfo(String userId);
}
