package com.kh.spring.myPage.controller;



import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.myPage.model.service.MypageService;
import com.kh.spring.myPage.model.vo.Mypage;

@Controller
public class MypageController {
	
	@Autowired
	MypageService myService;
	
	@RequestMapping(value="goMypage.do")
	public ModelAndView goMypage(ModelAndView mv,int mNo) {
		
		Mypage memberInfo = myService.selectMemInfo(mNo);
		Mypage followInfo = myService.selectFollowInfo(mNo);
		ArrayList<Mypage> feedList = myService.selectFeedInfo(mNo);
		ArrayList<Mypage> storageBoxList = myService.selectStorageBoxInfo(mNo);
		ArrayList<Mypage> groupList = myService.selectGroupInfo(mNo);
		
		mv.addObject("memberInfo", memberInfo);
		mv.addObject("followInfo", followInfo);
		mv.addObject("feedList", feedList);
		mv.addObject("feedCnt", feedList.size());
		mv.addObject("storageBoxList", storageBoxList);
		mv.addObject("groupList", groupList);
		mv.setViewName("myPageMain");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="insertBox.do",produces="application/json;charset=utf-8")
	public String insertBox(ModelAndView mv, String mNo) {
		JSONObject job = new JSONObject();
		job.put("msg", "실패");
		int mno = 0;
		if(mNo == null || mNo == "") {
			job.put("msg", "로그인을 해주세요");
			return job.toString();
		}else {
			mno = Integer.parseInt(mNo);
		}
		int result = myService.insertBox(mno);
		
		if(result > 0) {			
			ArrayList<Mypage> storageBoxList = myService.selectStorageBoxInfo(mno);
			JSONArray jArr = new JSONArray();
			for(int i=0; i <storageBoxList.size(); i++) {
					JSONObject jObj = new JSONObject();
					jObj.put("sbName", storageBoxList.get(i).getSbName());
					jArr.add(jObj);
			}
			job.put("result", result);
			job.put("storageBoxList", jArr);
			return job.toString();
		} else {
			job.put("msg", "실패");
		}
		
		return job.toString();
	}
	
	


}
