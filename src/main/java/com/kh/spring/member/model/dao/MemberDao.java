package com.kh.spring.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.member.model.vo.Member;

@Repository("mDao")
public class MemberDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	public Member loginMember(Member m) {
		return sqlSession.selectOne("memberMapper.loginMember",m);
	}

	public int idCheck(String userId) {
		return sqlSession.selectOne("memberMapper.idCheck",userId);
	}

	public int insertMember(Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public String findId(Member m) {
		return sqlSession.selectOne("memberMapper.findId",m);
	}

	public int findPwd(Member m) {
		return sqlSession.update("memberMapper.findPwd",m);
	}

	public Member selectOne(String mNo) {
		return sqlSession.selectOne("memberMapper.selectOne",mNo);
	}

	public int disableAccount(int mNo) {
		return sqlSession.update("memberMapper.disableAccount",mNo);
	}

	public int deleteAccount(int mNo) {
		return sqlSession.update("memberMapper.deleteAccount",mNo);
	}

	public Member selectNo(String mId) {
		return sqlSession.selectOne("memberMapper.selectNo",mId);
	}

}
