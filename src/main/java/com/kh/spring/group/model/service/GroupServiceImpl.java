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

	@Override
	public int updateGroup(Group g) {
		return gDao.groupUpdate(g);
	}

	@Override
	public int gmUpdate(GroupMember gm) {
		return gDao.groupMemberUpdate(gm);
	}

	@Override
	public int gmCheckId(GroupMember gm) {
		return gDao.groupMemberCheck(gm);
	}

	@Override
	public int gmDeleteCheck(GroupMember gm) {
		return gDao.groupDeleteCheck(gm);
	}

	@Override
	public int groupDelete(int gNo) {
		return gDao.deleteGroup(gNo);
	}

	@Override
	public int gmChangeMaster(GroupMember gm) {
		return gDao.gmChangeMaster(gm);
	}

	@Override
	public int gmChangeLevel(GroupMember gm) {
		return gDao.gmChangeLevel(gm);
	}

	@Override
	public int gCreatorChange(Group g) {
		return gDao.gCreatorChange(g);
	}

	@Override
	public int gmChangeManager(GroupMember gm) {
		return gDao.gmChangeManager(gm);
	}

	@Override
	public int gManagerChange(Group g) {
		return gDao.gManagerChange(g);
	}

	@Override
	public int gmChangeMember(GroupMember gm) {
		return gDao.gmChangeMember(gm);
	}

	@Override
	public int gManagerDelete(Group g) {
		return gDao.gManagerDelete(g);
	}

	@Override
	public Group getManagerId(String fromId) {
		return gDao.getManagerId(fromId);
	}
}
