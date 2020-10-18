package com.kh.spring.group.model.dao;

import java.util.ArrayList;

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

	public int insertGM(GroupMember gm) {
		return sqlSession.insert("gmMapper.insertGroupMember", gm);
	}

}
