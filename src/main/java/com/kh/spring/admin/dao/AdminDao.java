package com.kh.spring.admin.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;

@Repository("aDao")
public class AdminDao {

	@Autowired
	SqlSessionTemplate sqlSession;


	public ArrayList<Member> memberSearchList(Member m) {
		return (ArrayList)sqlSession.selectList("memberMapper.memberSearchList", m);
	}


	public ArrayList<Group> groupSearchList(Group g) {
		return (ArrayList)sqlSession.selectList("groupMapper.groupSearchList", g);
	}


}