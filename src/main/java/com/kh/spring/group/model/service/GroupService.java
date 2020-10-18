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

}
