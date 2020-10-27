package com.kh.spring.group.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;

@Repository("gDao")
public class GroupDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	public ArrayList<Group> selectList() {
		return (ArrayList)sqlSession.selectList("groupMapper.groupList");
	}

	public int insertGroup(Group g) {
		return sqlSession.insert("groupMapper.insertGroup", g);
	}

	/**
	 * 1. 그룹 관리자 insert
	 * @param gm
	 * @return
	 */
	public int insertGM(GroupMember gm) {
		return sqlSession.insert("gmMapper.insertGroupMaster", gm);
	}

	public Group selectGroup(int gNo) {
		return sqlSession.selectOne("groupMapper.selectGroup", gNo);
	}

	/**
	 * 2. 그룹 회원 insert
	 * @param gm
	 * @param mId 
	 * @return
	 */
	public int groupMemberinsert(GroupMember gm) {
		return sqlSession.insert("gmMapper.insertGroupMember", gm);
	}

	public int groupMemberSelect(GroupMember gm) {
		System.out.println("dao : " + gm.getGmId());
		System.out.println("dao : " + gm.getgNo());
		return sqlSession.selectOne("gmMapper.gmSelectId", gm);
	}

	public int groupMemberDelete(GroupMember gm) {
		return sqlSession.delete("gmMapper.gmDelete", gm);
	}

	public int totalGroups() {
		return sqlSession.selectOne("groupMapper.totalGroups");
	}

	public ArrayList<GroupMember> selectGmList(int gNo) {
		return (ArrayList)sqlSession.selectList("gmMapper.SelectGmList",gNo);
	}

	public ArrayList<GroupMember> selectNgmList(int gNo) {
		return (ArrayList)sqlSession.selectList("gmMapper.selectNgmList",gNo);
	}

	public int groupUpdate(Group g) {
		return sqlSession.update("groupMapper.groupUpdate",g);
	}

	public int groupMemberUpdate(GroupMember gm) {
		return sqlSession.update("gmMapper.groupMemberUpdate",gm);
	}

	public int groupMemberCheck(GroupMember gm) {
		return sqlSession.selectOne("gmMapper.groupMemberCheck",gm);
	}

	public int groupDeleteCheck(GroupMember gm) {
		return sqlSession.update("gmMapper.groupMemberDeleteCheck", gm);
	}

	public int deleteGroup(int gNo) {
		return sqlSession.update("groupMapper.deleteGroup", gNo);
	}

	public int gmChangeMaster(GroupMember gm) {
		return sqlSession.update("gmMapper.gmChangeMaster", gm);
	}

	public int gmChangeLevel(GroupMember gm) {
		return sqlSession.update("gmMapper.gmChangeLevel",gm);
	}

	public int gCreatorChange(Group g) {
		return sqlSession.update("groupMapper.gCreatorChange",g);
	}

	public int gmChangeManager(GroupMember gm) {
		return sqlSession.update("gmMapper.gmChangeManager", gm);
	}
}
