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

}
