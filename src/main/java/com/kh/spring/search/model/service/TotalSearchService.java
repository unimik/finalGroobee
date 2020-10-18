package com.kh.spring.search.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.search.model.vo.RelatedSearch;
import com.kh.spring.search.model.vo.Search;

public interface TotalSearchService {

	/**
	 * @ 인물, 피드 검색
	 * @param srch
	 * @return
	 */
	ArrayList<Member> searcMember(Search srch);

//	ArrayList<Group> searchGroup(Search srch);

	/**
	 * # 검색
	 * @param srch
	 * @return
	 */
	ArrayList<Feed> searchFeed(Search srch);

	/**
	 * 연관 검색어
	 * @param srch
	 * @return
	 */
	ArrayList<RelatedSearch> relatedSearch(Search srch);
}
