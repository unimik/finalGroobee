package com.kh.spring.group.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.group.model.dao.GroupDao;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;

@Service("gService")
public class GroupServiceImpl implements GroupService{
	
	@Autowired
	GroupDao gDao;
	
	@Override
	public ArrayList<Group> selectList() {
		return gDao.selectList();
	}

	@Override
	public int insertGroup(Group g) {
		return gDao.insertGroup(g);
	}

	@Override
	public int insertGM(GroupMember gm) {
		return gDao.insertGM(gm);
	}

	@Override
	public Group selectGroup(int gNo) {
		return gDao.selectGroup(gNo);
	}

	@Override
	public int gmInsert(GroupMember gm) {
		return gDao.groupMemberinsert(gm);
	}

	@Override
	public int gmSelectId(GroupMember gm) {
		return gDao.groupMemberSelect(gm);
	}

	@Override
	public int gmDelete(GroupMember gm) {
		return gDao.groupMemberDelete(gm);
	}

	@Override
	public int totalGroups() {
		return gDao.totalGroups();
	}

	@Override
	public Group selectUpdateGroup(int gNo) {
		return gDao.selectGroup(gNo);
	}

	@Override
	public ArrayList<GroupMember> selectGmList(int gNo) {
		return gDao.selectGmList(gNo);
	}

	@Override
	public ArrayList<GroupMember> selectNgmList(int gNo) {
		return gDao.selectNgmList(gNo);
	}
}
