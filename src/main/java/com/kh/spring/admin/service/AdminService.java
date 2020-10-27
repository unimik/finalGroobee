package com.kh.spring.admin.service;

import java.util.ArrayList;

import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;

public interface AdminService {



	/** 1. 회원 리스트 조회
	 * @param m
	 * @return
	 */
	ArrayList<Member> memberSearchList(Member m);

	/** 2. 그룹 리스트 조회
	 * @param g
	 * @return
	 */
	ArrayList<Group> groupSearchList(Group g);

}
