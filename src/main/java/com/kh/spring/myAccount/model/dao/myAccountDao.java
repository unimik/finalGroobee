package com.kh.spring.myAccount.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.myAccount.model.vo.myAccount;

@Repository("maDao")
public class myAccountDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public ArrayList<myAccount> selectFollows(int mNo) {
		return (ArrayList)sqlSession.selectList("myAccountMapper.selectFollows", mNo);
	}

	public ArrayList<myAccount> selectFollowers(int mNo) {
		return (ArrayList)sqlSession.selectList("myAccountMapper.selectFollowers", mNo);
	}

	public ArrayList<myAccount> selectGroupList(String mId) {
		return (ArrayList)sqlSession.selectList("myAccountMapper.selectGroupList", mId);
	}

	public int delFollow(myAccount ma) {
		return sqlSession.delete("myAccountMapper.deleteFollow", ma);
	}

	public int delFollower(myAccount ma) {
		return sqlSession.delete("myAccountMapper.deleteFollower", ma);
	}
}
