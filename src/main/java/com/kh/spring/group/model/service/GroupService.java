package com.kh.spring.group.model.service;

import java.util.ArrayList;

import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;

public interface GroupService {

	/**
	 * 1. 그룹 리스트
	 * @return
	 */
	ArrayList<Group> selectList();

	/**
	 * 2. 그룹 인서트
	 * @param g
	 * @return
	 */
	int insertGroup(Group g);

	/**
	 * 3. 그룹 멤버 인서트
	 * @param g
	 * @return
	 */
	int insertGM(GroupMember gm);

	/**
	 * 4. 그룹 상세조회
	 * @param gNo
	 * @return
	 */
	Group selectGroup(int gNo);

	/**
	 * 5. 그룹 회원가입 (대기)
	 * @param gm
	 * @return
	 */
	int gmInsert(GroupMember gm);

	/**
	 * 6. 회원 아이디 조회
	 *    이미 가입한 회원인지 조회하기
	 * @param gm
	 * @return
	 */
	int gmSelectId(GroupMember gm);

	/**
	 * 7. 회원 삭제
	 * @param gm
	 * @return
	 */
	int gmDelete(GroupMember gm);

}
