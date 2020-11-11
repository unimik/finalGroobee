package com.kh.spring.admin.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.declaration.model.vo.Declaration;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.setting.model.vo.Question;

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


	public ArrayList<Reply> replySearchList(Reply re) {
		return (ArrayList)sqlSession.selectList("feedMapper.replySearchList", re);
	}


	public int memberStatusChange(Member m) {
		return sqlSession.update("memberMapper.memberStatusChange", m);
	}


	public ArrayList<Feed> feedSearchList(Feed f) {
		return (ArrayList)sqlSession.selectList("feedMapper.feedSearchList", f);
	}


	public int feedStatusChange(Feed f) {
		return sqlSession.update("feedMapper.feedStatusChange", f);
	}


	public int replyStatusChange(Reply r) {
		return sqlSession.update("feedMapper.replyStatusChange", r);
	}


	public int groupStatusChange(Group g) {
		return sqlSession.update("groupMapper.groupStatusChange", g);
	}


	public ArrayList<Question> questionSearchList() {
		return (ArrayList)sqlSession.selectList("adminAlertMapper.questionSearchList");
	}


	public ArrayList<Member> questionSearchListName() {
		return (ArrayList)sqlSession.selectList("adminAlertMapper.questionSearchListName");
	}


	public int totalMember() {
		return sqlSession.selectOne("memberMapper.totalMember");
	}


	public int totalGroups() {
		return sqlSession.selectOne("groupMapper.totalGroups");
	}

	public int delayedReport() {
		return sqlSession.selectOne("declarationMapper.delayedReport");
	}


	public ArrayList<Declaration> reportSearchList(Declaration d) {
		return (ArrayList)sqlSession.selectList("declarationMapper.reportSearchList", d);
	}


	public Group loadGroup(int number) {
		return sqlSession.selectOne("groupMapper.loadGroup",number);
	}


	public int declarationStatusChange(String dNo) {
		return sqlSession.update("adminAlertMapper.declarationStatusChange", dNo);
	}
	
}
