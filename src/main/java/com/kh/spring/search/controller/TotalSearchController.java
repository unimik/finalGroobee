package com.kh.spring.search.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.swing.text.html.BlockView;

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
	public ModelAndView searchList(ModelAndView mv, @RequestParam(value="key") String key,@RequestParam(value="type") String type, @RequestParam(value="mNo") int mNo) {
		//System.out.println("key :"+key+"   type: "+type);
		ArrayList<Member> mList = null;
		ArrayList<Group> gList = null;
		String mno = Integer.toString(mNo);
		
		if(type.equals("recommend")) { //아무것도 검색하지 않을 때
			Search srch = new Search('R', key);
			//관심사 찾기
			String interest = tsService.searchInterest(srch);
			
			if(interest != null) {
				String[] itrst = interest.split(",");// 관심사 자른 배열
				
				//관심사 같은 멤버, 그룹 찾아줌 
				if (itrst.length > 0) {
					Search srch1 = new Search('R',itrst);
					
					mList =tsService.searcMember(srch1);
					gList = tsService.searchGroup(srch1);
					
					if(!mList.isEmpty()) {
						 ArrayList<Member> mlist = block(mList,mno);
						 mv.addObject("mList", mlist);
					}else{
						mv.addObject("mList", mList);
				}
			
				mv.addObject("gList", gList);
				mv.setViewName("search/totalSearch");
				}
				
			}else {
				
				String rStr = "관심사를 설정하시면 계정과 그룹을 추천해드려요!";
				mv.addObject("rStr", rStr);
				mv.addObject("mList", mList);
				mv.addObject("gList", gList);
				mv.setViewName("search/totalSearch");
			}
			return mv;
			
			
		}else if(type.equals("user")) {	//@달고 검색했을 때 --> 아이디, 글에 달린 @아이디 검색	
			//유저 검색
			Search srch = new Search('@', key);
			mList = tsService.searcMember(srch);

			//차단한 계정
			if(!mList.isEmpty()) {
				//차단계정 검사
				 ArrayList<Member> mlist = block(mList,mno);
				 mv.addObject("mList", mlist);
			}else{
				mv.addObject("mList", mList);
			}
			
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
			mList = tsService.searcMember(srch);
			if(!mList.isEmpty()) {
				 ArrayList<Member> mlist = block(mList,mno);
				 mv.addObject("mList", mlist);
			}else {
				mv.addObject("mList", mList);
			}
			
			//그룹 검색, 
			gList = tsService.searchGroup(srch);

			//피드 검색
			int[] barr = blockMember(mList, mno);
			ArrayList<Feed> fList = null;
			if (barr == null) {
				fList = tsService.searchFeed(srch);
			}else {
				Search srch2 = new Search('#', '#'+key, barr);
				fList = tsService.searchFeed(srch2);
			}

			//연관 검색어
			ArrayList raList = tsService.relatedSearch(srch);
			ArrayList rbList = new ArrayList();

			for( int i = 0; i<raList.size();i++) {
				String str = (String) raList.get(i);
				rbList.add(i,str.substring(1));
			}

			mv.addObject("gList", gList);
			mv.addObject("fList", fList);
			mv.addObject("rsList",rbList);
			mv.addObject("searchKey", key);
			
			
			mv.setViewName("search/totalSearch");

			return mv;
		}else if(type.equals("all")){	//@나 # 빼고 검색했을 때

			Search srch = new Search('N', key);
			mList = tsService.searcMember(srch);
			gList = tsService.searchGroup(srch);
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
	//블락 된 계정 제거
	ArrayList<Member> block(ArrayList<Member> mList, String mno){
		
		for(int i =0; i < mList.size(); i++) {
			if(mList.get(i).getBlock() != null) {
				String[] b = mList.get(i).getBlock().split(",");
				for(int j = 0; j < b.length; j++) {
					if(mno.equals(b[j])) {
						mList.remove(i);
					}
				}
			}	
		}
		
		return mList;
	}
	
	//사용자 블락한 계정 list
	int[] blockMember(ArrayList<Member> mList, String mno){
		int[] barr = null;
		for(int i =0; i < mList.size(); i++) {
			if(mList.get(i).getBlock() != null) {
				String[] b = mList.get(i).getBlock().split(",");
				for(int j = 0; j < b.length; j++) {
					int k = 0;
					if(mno.equals(b[j])) {
						barr[k] = mList.get(i).getmNo();
						k++;
					}
				}
			}	
		}
		
		return barr;
	}
	
	
	//#태그 눌러서 검색 되는 결과
	@RequestMapping("tagSearch.do")
	public ModelAndView tagSearch(ModelAndView mv , String search, int mNo) {
		System.out.println("회원번호"+mNo);
		String mno = Integer.toString(mNo);
//		System.out.println("태그 클릭하면 클릭한거 들어옴?:"+search); 잘들어옴
		String searchKey = search;
		String[] srch = search.split(" ");
		String[] rlist = new String[srch.length];	//검색하러 갈 리스트

//		System.out.println("srch 길이"+srch.length);
//		System.out.println("rlist 길이"+rlist.length);
		
		for(int i = 0; i < srch.length; i++) {
			rlist[i] = '#'+srch[i];
		}
		
		//인물 검색
		ArrayList<Member> mList = tsService.tagSearchMember(rlist);
		ArrayList<Member> mlist = block(mList, mno);
		
		//그룹 검색
		ArrayList<Group> gList = tsService.tagSearchGroup(rlist);
		
		//피드 검색
		int[] barr = blockMember(mList,mno);
		ArrayList<Feed> fList = new ArrayList<Feed>();
		
		/*if(barr != null) {
			Search sr = new Search(rlist, barr);
			fList = tsService.tagSearchbFeed(sr);	
		}else{
			fList = tsService.tagSearchFeed(rlist);			
		}*/
		if (barr != null) {
			fList = tsService.tagSearchFeed(rlist);
			for(int i =0; i<barr.length; i++) {
				for(int j =0; j< fList.size(); j++) {
					if(barr[i]==fList.get(j).getmNo()) {
						fList.remove(j);
					}
				}
			}
		}else {
			fList = tsService.tagSearchFeed(rlist);			
		}
		
		//연관 검색어 검색
		ArrayList raList = tsService.tagSearchRs(rlist);
		ArrayList rbList = new ArrayList();
		for( int i = 0; i<raList.size();i++) {
			String str = (String) raList.get(i);
			rbList.add(i,str.substring(1));
		}
		
		mv.addObject("mList", mlist);
		mv.addObject("gList", gList);
		mv.addObject("rsList",rbList);
		mv.addObject("fList",fList);
		mv.addObject("searchKey",searchKey);
		mv.setViewName("search/totalSearch");
		return mv;
	}
	

}
