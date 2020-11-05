package com.kh.spring.search.model.service;

import java.util.ArrayList;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.search.model.vo.RelatedSearch;
import com.kh.spring.search.model.vo.Search;

public interface TotalSearchService {

	/**
	 * @ 인물, @ 인물이 포함됨 피드 검색
	 * @param srch
	 * @return
	 */
	ArrayList<Member> searcMember(Search srch);

	
	/**
	 * 그룹 검색
	 * @param srch
	 * @return
	 */
	ArrayList<Group> searchGroup(Search srch);

	/**
	 * # 검색 
	 *  피드
	 * @param srch
	 * @return
	 */
	ArrayList<Feed> searchFeed(Search srch);

	/**
	 * 연관 검색어 
	 * @param srch2
	 * @return
	 */
	ArrayList<RelatedSearch> relatedSearch(Search srch2);



//===============태그 눌렀을때 검색되는거==================
	/**
	 * 그룹 검색
	 * @param rlist
	 * @return
	 */
	ArrayList<Group> tagSearchGroup(String[] rlist);




	/** 
	 * 피드 검색
	 * @param rarr
	 * @return
	 */
//	ArrayList<Feed> tagsearchFeed(ArrayList rlist);
	ArrayList<Feed> tagSearchFeed(String[] rlist);


	/**
	 * 연관 검색어
	 * @param rlist
	 * @return
	 */
	ArrayList tagSearchRs(String[] rlist);


	/**
	 * 멤버 검색
	 * @param rlist
	 * @return
	 */
	ArrayList<Member> tagSearchMember(String[] rlist);


	/**
	 * 관심사 검색
	 * @param srch
	 * @return
	 */
	String searchInterest(Search srch);


	/**
	 * 관심사가 같은 그룹 검색
	 * @param itrst
	 * @return
	 */
	ArrayList<Group> searchInterestGroup(String[] itrst);



}
