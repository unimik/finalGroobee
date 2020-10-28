package com.kh.spring.myPage.controller;



import java.io.File;
import java.lang.reflect.Array;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Follow;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.service.MypageService;
import com.kh.spring.myPage.model.vo.Mypage;

import com.kh.spring.myPage.model.vo.StorageBox;
import com.kh.spring.setting.model.vo.NotificationSetting;
import com.kh.spring.setting.model.vo.PersonalSetting;


@Controller
public class MypageController {
	
	@Autowired
	MypageService myService;

	@Autowired
	MemberService mService;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("goMypage.do")
	public ModelAndView goMypage(ModelAndView mv,int mNo) {
		
		Mypage memberInfo = myService.selectMemInfo(mNo);
		Mypage followInfo = myService.selectFollowInfo(mNo);
		ArrayList<Feed> feedList = myService.selectFeedInfo(mNo);
		ArrayList<StorageBox> storageBoxList = myService.selectStorageBoxInfo(mNo);
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
	
	@RequestMapping("mupdateView.do")
	public String myPageEditView() {
		return "myPageEdit";
	}
	
	@RequestMapping(value="mupdate.do",method=RequestMethod.POST)
	public ModelAndView memberUpdate(ModelAndView mv, Member m, HttpServletRequest request
			,String email1,String email2,String interest, String mIntro, String userName
			,@RequestParam(value="file", required=false) MultipartFile  memFile) {
		
		
		Member mSesison = (Member)session.getAttribute("loginUser");
		
		if( memFile != null && !memFile.isEmpty()) {
			if(m.getmRenameImage() != null) {
				deleteFile(m.getmRenameImage(),request);
			}
			
			String renameFileName = saveFile(memFile, request);
			
			if(renameFileName != null) {
				m.setmImage(memFile.getOriginalFilename());
				m.setmRenameImage(renameFileName);
				mSesison.setmRenameImage(renameFileName);
			}
		}
		
		m.setEmail(email1+"@"+email2);
		m.setInterestes(interest);
		m.setmIntro(mIntro);
		m.setUserName(userName);
		mSesison.setEmail(email1+"@"+email2);
		mSesison.setInterestes(interest);
		mSesison.setmIntro(mIntro);
		mSesison.setUserName(userName);
		
		System.out.println(m);
		int result = mService.memberUpdate(m);
		
		if(result > 0) {
			mv.addObject("loginUser", m);
			mv.addObject("mNo", m.getmNo());
			mv.setViewName("redirect:goMypage.do");
			
			
			return mv;
		} else {
			mv.addObject("msg", "회원 정보 수정 실패");
			mv.setViewName("common/errorPage");
			
			return mv;
		}
	}
	
	private void deleteFile(String memFile, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\memberProfileFiles";
		
		File f = new File(savePath + "\\" + memFile);
		
		if(f.exists()) {
			f.delete();
		}
	}

	private String saveFile(MultipartFile memFile, HttpServletRequest request) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\memberProfileFiles";
		String fileName = "";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		String originalFileName = memFile.getOriginalFilename();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
											+ originalFileName.substring(originalFileName.lastIndexOf(".")+1);
		
		String renamePath = folder + "\\" + renameFileName;
		
		try {
			memFile.transferTo(new File(renamePath));
		}catch(Exception e) {
			System.out.println("파일 전송 에러 : " + e.getMessage());
		}
		return renameFileName;
	}

	@RequestMapping("updatePwdView.do")
	public String myPagePassEditView() {
		return "myPagePassEdit";
	}
	
	@RequestMapping(value="mPwdUpdate.do")
	public String memberUpdate(Member m, Model model, String userPwd,String userPwdeny, String userPwd1 ) {

		    
		boolean result1 = bcryptPasswordEncoder.matches(userPwd,userPwdeny);
		System.out.println(userPwd);
		System.out.println(userPwdeny);
		System.out.println(result1);
		if(!result1) {
			model.addAttribute("msg","현재 비밀 번호를 확인해주세요");
			return "common/errorPage";
		} 
		
		String encPwd1 = bcryptPasswordEncoder.encode(userPwd1);
		m.setUserPwd(encPwd1);
		int result = mService.updatePwd(m);
		
		System.out.println(m);
		
		if(result > 0) {
			model.addAttribute("loginUser", m);
			model.addAttribute("mNo", m.getmNo() );
			return "redirect:loginView.do";
		} else {
			model.addAttribute("msg","비밀번호 수정 실패!");
			return "common/errorPage";
		}
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
			ArrayList<StorageBox> storageBoxList = myService.selectStorageBoxInfo(mno);
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
	
	//보관함 이름 수정
	@RequestMapping(value="updateBox.do",method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateBox(@RequestBody Map<String, Object> sbBoxMap) {
		int mno = 0;
		ArrayList<StorageBox> sblist = new ArrayList<StorageBox>();
	
		for(String key : sbBoxMap.keySet()) {
			if( key.equals("mno")) {
				mno = (int)sbBoxMap.get(key);
			}
		}
		
		for(String key : sbBoxMap.keySet()) {
			if( !key.equals("mno")) {			
				StorageBox sb = new StorageBox();
				String value = (String) sbBoxMap.get(key); 
				sb.setSbNo(Integer.parseInt(key));
				sb.setSbName(value);
				sb.setmNo(mno);
				sblist.add(sb);
			}
		}
//		System.out.println("mno : "+mno);
//		System.out.println(sblist);
		
		if(mno !=0) {
		int result = myService.updateBox(sblist);
		System.out.println("결과값 어캐나옴"+ result);
		}
		return sbBoxMap;
		
	}
	
	//보관함 삭제
	@RequestMapping(value="deleteBox.do",method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteBox(@RequestBody Map<String, Object> sbBoxMap) {
		int mno = 0;
		StorageBox sb = new StorageBox();
		
		for(String key : sbBoxMap.keySet()) {
			if( key.equals("mno")) {
				mno = (int)sbBoxMap.get(key);
			}
		}
		String[] str = new String[sbBoxMap.size()-1];
		int i = 0;
		for(String key : sbBoxMap.keySet()) {
			if( !key.equals("mno")) {			
				String value = (String)sbBoxMap.get(key); 
				str[i] = value;
				i++;	
			}
		}
		sb.setmNo(mno);
		sb.setSbNos(str);
		System.out.println(sb);
		if(mno !=0) {
			//이거 트라이 캐치구문으로 감쌀것...
			int result = myService.deleteteBox(sb);
			System.out.println("결과값 어캐나옴"+ result);
			}

		return sbBoxMap;
		
	}
	

	@RequestMapping(value="goUserpage.do")
	public ModelAndView goUserpage(ModelAndView mv,String userId, int mNo) {
		
		Member memberInfo = mService.selectUserInfo(userId);
		
		Follow fw = new Follow();
		fw.setmNo(mNo);
		fw.setFollows(memberInfo.getmNo());
		String followYN = myService.selectFollowYN(fw);
		Mypage followInfo = myService.selectFollowInfo(memberInfo.getmNo());
		ArrayList<Feed> feedList = myService.selectFeedInfo(memberInfo.getmNo());
		
		mv.addObject("memberInfo", memberInfo);
		mv.addObject("followInfo", followInfo);
		mv.addObject("feedList", feedList);
		mv.addObject("feedCnt", feedList.size());
		mv.addObject("followYN", followYN);
		mv.setViewName("userPage");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("insertFollow.do")
	public String insertFollow(@RequestParam("follow") int follow,@RequestParam("mNo") int mNo) {
		
		Follow fw = new Follow();
		fw.setmNo(mNo);
		fw.setFollows(follow);
		int result = myService.insertFollow(fw);
		
		
		if(result > 0) {
			return "success";				
		} else {
			return"server error";			
		}
	}

	@ResponseBody
	@RequestMapping("deleteFollow.do")
	public String deleteFollow(@RequestParam("follow") int follow,@RequestParam("mNo") int mNo) {
		
		Follow fw = new Follow();
		fw.setmNo(mNo);
		fw.setFollows(follow);
		int result = myService.deleteFollow(fw);
		
		
		if(result > 0) {
			return "success";				
		} else {
			return"server error";			
		}
	}
}
