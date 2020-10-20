package com.kh.spring.myPage.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.myPage.model.vo.Mypage;


@Repository("myDao")
public class MypageDao {

	@Autowired
	SqlSessionTemplate sqlSession;

	public Mypage selectMemInfo(int mNo) {
		return sqlSession.selectOne("mypageMapper.selectMemInfo", mNo);
	}

	public Mypage selectFollowInfo(int mNo) {
		return sqlSession.selectOne("mypageMapper.selectFollowInfo", mNo);
	}

	public ArrayList<Mypage> selectFeedInfo(int mNo) {
		return (ArrayList)sqlSession.selectList("mypageMapper.selectFeedInfo", mNo);
	}

	public ArrayList<Mypage> selectStorageBoxInfo(int mNo) {
		return (ArrayList)sqlSession.selectList("mypageMapper.selectStorageBoxInfo", mNo);
	}

	public int insertBox(int mNo) {
		return sqlSession.insert("mypageMapper.insertBox",mNo);
	}

	public ArrayList<Mypage> selectGroupInfo(int mNo) {
		return (ArrayList)sqlSession.selectList("mypageMapper.selectGroupInfo", mNo);
	}
	
}
