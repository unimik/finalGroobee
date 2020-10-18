package com.kh.spring.member.model.service;

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

}
