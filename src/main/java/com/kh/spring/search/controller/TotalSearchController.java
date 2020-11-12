package com.kh.spring.search.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.search.model.service.TotalSearchService;
import com.kh.spring.search.model.vo.RelatedSearch;
import com.kh.spring.search.model.vo.Search;

@Controller()
public class TotalSearchController {
	
	@Autowired
	private TotalSearchService tsService;
	
	//검색창에 검색 컨트롤러
	@RequestMapping("search.do")
	public ModelAndView searchList(ModelAndView mv, @RequestParam(value="key") String key,@RequestParam(value="type") String type) {
		//System.out.println("key :"+key+"   type: "+type);

		if(type.equals("recommend")) { //아무것도 검색하지 않을 때
			Search srch = new Search('R', key);
			String interest = tsService.searchInterest(srch);
			System.out.println(interest);
			String[] itrst = interest.split(",");
			
			/*
			for(int i =0; i <itrst.length; i++) {
				System.out.println(i+itrst[i]);
			}
			if (itrst.length > 0) {
			ArrayList<Group> gList = tsService.searchInterestGroup(itrst);
				
			}
			*/
			
			mv.setViewName("search/totalSearch");
			return mv;
			
		}else if(type.equals("user")) {	//@달고 검색했을 때 --> 아이디, 글에 달린 @아이디 검색	
			//유저 검색
			Search srch = new Search('@', key);
			ArrayList<Member> mList = tsService.searcMember(srch);

			//피드 검색
			Search srch2 = new Search('@', '@'+key);
			ArrayList<Feed> fList = tsService.searchFeed(srch2);

			mv.addObject("mList", mList);
			mv.addObject("fList", fList);
			mv.setViewName("search/totalSearch");
			return mv;
			
		}else if(type.equals("tag")) { //# 달고 검색 했을 때 -> 태그 검색

			//유저 검색
			Search srch = new Search('#', '#'+key);
			ArrayList<Member> mList = tsService.searcMember(srch);
			
			//그룹 검색, 피드 검색
			ArrayList<Group> gList = tsService.searchGroup(srch);
			ArrayList<Feed> fList = tsService.searchFeed(srch);
			
			//연관 검색어
			ArrayList raList = tsService.relatedSearch(srch);
			ArrayList rbList = new ArrayList();

			for( int i = 0; i<raList.size();i++) {
				String str = (String) raList.get(i);
				rbList.add(i,str.substring(1));
			}

			mv.addObject("mList", mList);
			mv.addObject("gList", gList);
			mv.addObject("fList", fList);
			mv.addObject("rsList",rbList);
			mv.addObject("searchKey", key);
			
			
			mv.setViewName("search/totalSearch");

			return mv;
		}else if(type.equals("all")){	//@나 # 빼고 검색했을 때

			Search srch = new Search('N', key);
			ArrayList<Member> mList = tsService.searcMember(srch);
			ArrayList<Group> gList = tsService.searchGroup(srch);
			ArrayList<Feed> fList = tsService.searchFeed(srch);
			mv.addObject("mList", mList);
			mv.addObject("gList", gList);
			mv.addObject("fList", fList);
			mv.setViewName("search/totalSearch");
			

			return mv;
		}else {
			mv.setViewName("search/totalSearch");
			return mv;
		}
	}
	
	
	//#태그 눌러서 검색 되는 결과
	@RequestMapping("tagSearch.do")
	public ModelAndView tagSearch(ModelAndView mv , String search) {
		
//		System.out.println("태그 클릭하면 클릭한거 들어옴?:"+search); 잘들어옴
		String searchKey = search;
		String[] srch = search.split(" ");
		String[] rlist = new String[srch.length];	//검색하러 갈 리스트

//		System.out.println("srch 길이"+srch.length);
//		System.out.println("rlist 길이"+rlist.length);
		
		for(int i = 0; i < srch.length; i++) {
//			rlist.add('#'+srch[i]);
			rlist[i] = '#'+srch[i];
//			System.out.println("rlist"+i+"번"+rlist[i]);
		}
		
		//인물 검색
		ArrayList<Member> mList = tsService.tagSearchMember(rlist);
		
		//그룹 검색
		ArrayList<Group> gList = tsService.tagSearchGroup(rlist);
		
		//피드 검색
//		ArrayList<Feed> fList = tsService.tagsearchFeed(rlist);
		ArrayList<Feed> fList = tsService.tagSearchFeed(rlist);
//		System.out.println("가져온 리스트:"+fList); 가져옴

		//연관 검색어 검색
		ArrayList raList = tsService.tagSearchRs(rlist);
		//		System.out.println("연관 검색어 나오니?"+raList); //잘나옴
		ArrayList rbList = new ArrayList();
		for( int i = 0; i<raList.size();i++) {
			String str = (String) raList.get(i);
			rbList.add(i,str.substring(1));
		}
		
		mv.addObject("mList", mList);
		mv.addObject("gList", gList);
		mv.addObject("rsList",rbList);
		mv.addObject("fList",fList);
		mv.addObject("searchKey",searchKey);
		mv.setViewName("search/totalSearch");
		return mv;
	}

}
