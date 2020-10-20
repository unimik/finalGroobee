package com.kh.spring.search.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.search.model.vo.RelatedSearch;
import com.kh.spring.search.model.vo.Search;

@Repository("tsDao")
public class TotalSearchDao {


	@Autowired
	SqlSessionTemplate sqlSession;
	
	public ArrayList<Member> searchMember(Search srch) {
		return (ArrayList)sqlSession.selectList("searchMapper.searchMember",srch);
	}

	public ArrayList<Group> searchGroup(Search srch) {
		return (ArrayList)sqlSession.selectList("searchMapper.searchGroup",srch);
	}

	public ArrayList<Feed> searchFeed(Search srch) {
		return (ArrayList)sqlSession.selectList("searchMapper.searchFeed",srch);
	}

	public ArrayList<RelatedSearch> relatedSearch(Search srch) {
		return (ArrayList)sqlSession.selectList("searchMapper.relatedSearch", srch);
	}

}
