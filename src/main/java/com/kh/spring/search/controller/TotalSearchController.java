package com.kh.spring.search.controller;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.search.model.service.TotalSearchService;
import com.kh.spring.search.model.vo.RelatedSearch;
import com.kh.spring.search.model.vo.Search;

@Controller()
public class TotalSearchController {
	
	@Autowired
	private TotalSearchService tsService;
	
	@RequestMapping(value="search.do",method=RequestMethod.POST)
	public ModelAndView searchList(ModelAndView mv, String allSearch) {
		
//		System.out.println("검색어 잘 들어오니?"+allSearch);
//		System.out.println("맨 앞글자 구분: "+allSearch.charAt(0));
		if(allSearch =="") { //아무것도 검색하지 않을 때
			mv.setViewName("search/totalSearch");
			return mv;
			
		}else if(allSearch.charAt(0) =='@') {	//@달고 검색했을 때 --> 아이디, 글에 달린 @아이디 검색	
			Search srch = new Search(allSearch.charAt(0), allSearch.substring(1));
			ArrayList<Member> mList = tsService.searcMember(srch);
			Search srch2 = new Search(allSearch.charAt(0), allSearch);
			ArrayList<Feed> fList = tsService.searchFeed(srch2);

			mv.addObject("mList", mList);
			mv.addObject("fList", fList);

			mv.setViewName("search/totalSearch");
			return mv;
			
		}else if(allSearch.charAt(0) =='#') { //# 달고 검색 했을 때 -> 태그 검색
			Search srch = new Search(allSearch.charAt(0), allSearch);
			ArrayList<Member> mList = tsService.searcMember(srch);
//			ArrayList<Group> gList = tsService.searchGroup(allSearch);
			Search srch2 = new Search(allSearch.charAt(0), allSearch);
			ArrayList<Feed> fList = tsService.searchFeed(srch2);
			
//			ArrayList rsList = new ArrayList<>();
			ArrayList<RelatedSearch> rsList = tsService.relatedSearch(srch2);  
//			System.out.println("연관검색어 들어옴?"+rsList);
//			System.out.println("태그로 검색했을 때 멤버 리스트"+mList);

			mv.addObject("mList", mList);
//			mv.addObject("gList", gList);
			mv.addObject("fList", fList);
			mv.addObject("rsList",rsList);
		
			mv.setViewName("search/totalSearch");
			return mv;
			
		}else{								//@나 # 빼고 검색했을 때
//			Search srch = new Search(allSearch.charAt(0), allSearch);
//			ArrayList<Member> mList = tsService.searcMember("");
//			ArrayList<Feed> gList = tsService.searchGroup(allSearch);
//			ArrayList<Feed> fList = tsService.searchFeed(srch);
//			ArrayList<Tag> 연관검색어 = 

			mv.setViewName("search/totalSearch");
			return mv;
						
		}
		
	}
	
	
	
	
	

}
