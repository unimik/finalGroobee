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
		return sqlSession.update("gmMapper.gmDelete", gm);
	}

	public int totalGroups() {
		return sqlSession.selectOne("groupMapper.totalGroups");
	}
}
