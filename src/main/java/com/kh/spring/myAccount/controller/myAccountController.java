package com.kh.spring.myAccount.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.spring.myAccount.model.service.myAccountService;
import com.kh.spring.myAccount.model.vo.myAccount;

@Controller
public class myAccountController {
	
	@Autowired
	private myAccountService maService;
	
	@RequestMapping("getFollowList.do")
	public void getMyList(int mNo, HttpServletResponse response) throws IOException {
		response.setContentType("appliction/json; charset=UTF-8");
		ArrayList<myAccount> followerList = maService.selectFollows(mNo);
		JSONObject jOb = null;
		JSONArray jArr = new JSONArray();
		
		for( myAccount fl : followerList ) {
			System.out.println(fl.getmNo());
			System.out.println(fl.getmId());
			System.out.println(fl.getmRenameImage());
			
			jOb = new JSONObject();
			jOb.put("mNo",fl.getmNo());
			jOb.put("userId", fl.getmId());
			if(fl.getmRenameImage() != null) {
				jOb.put("mImage", "memberProfileFiles/"+fl.getmRenameImage());
			}else {
				jOb.put("mImage","icons/logo.png");
			}
			
			jArr.add(jOb);
		}
		PrintWriter out = response.getWriter();
		out.print(jArr);
	}
	
	@RequestMapping("getFollowerList.do")
	public void getFollowList(int mNo, HttpServletResponse response) throws IOException {
		response.setContentType("appliction/json; charset=UTF-8");
		ArrayList<myAccount> followList = maService.selectFollowers(mNo);
		JSONObject jOb = null;
		JSONArray jArr = new JSONArray();

		for( myAccount fl : followList ) {
			System.out.println(fl.getmNo());
			System.out.println(fl.getmId());
			System.out.println(fl.getmRenameImage());
			
			jOb = new JSONObject();
			jOb.put("mNo",fl.getmNo());
			jOb.put("userId", fl.getmId());
			if(fl.getmRenameImage() != null) {
				jOb.put("mImage", "memberProfileFiles/"+fl.getmRenameImage());
			}else {
				jOb.put("mImage","icons/logo.png");
			}
			
			jArr.add(jOb);
		}
		PrintWriter out = response.getWriter();
		out.print(jArr);
	}
	
	@RequestMapping("getGroupList.do")
	public void getGroupList(String mId, HttpServletResponse response) throws IOException {
		response.setContentType("appliction/json; charset=UTF-8");
		System.out.println(mId);
		ArrayList<myAccount> groupList = maService.selectGroupList(mId);
		JSONObject jOb = null;
		JSONArray jArr = new JSONArray();

		for( myAccount gl : groupList ) {
			System.out.println(gl.getgNo());
			System.out.println(gl.getgName());
			System.out.println(gl.getgRenameProfile());
			
			jOb = new JSONObject();
			jOb.put("gNo",gl.getgNo());
			jOb.put("gName", gl.getgName());
			if(gl.getgRenameProfile() != null) {
				jOb.put("gImage", "gUploadFiles/"+gl.getgRenameProfile());
			}else {
				jOb.put("gImage","icons/pro_default.png");
			}
			
			jArr.add(jOb);
		}
		PrintWriter out = response.getWriter();
		out.print(jArr);
	}
	
//	@RequestMapping("delFollower.do")
//	public void delFollower(int mNo, HttpServletResponse response) {
//		
//	}
	
	@ResponseBody
	@RequestMapping("delFollow.do")
	public int delFollow(myAccount ma, int mNo, int foNo, HttpServletResponse response) throws IOException {
		response.setContentType("appliction/json; charset=UTF-8");
		
		ma.setFollows(foNo);
		ma.setmNo(mNo);
		
		int result = maService.delFollow(ma);
		
		return result;
	}
}
