package com.kh.spring.myPage.controller;



import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.service.MypageService;
import com.kh.spring.myPage.model.vo.Mypage;

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
	
	@RequestMapping(value="goMypage.do")
	public ModelAndView goMypage(ModelAndView mv,int mNo) {
		
		Mypage memberInfo = myService.selectMemInfo(mNo);
		Mypage followInfo = myService.selectFollowInfo(mNo);
		ArrayList<Feed> feedList = myService.selectFeedInfo(mNo);
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
	
	@RequestMapping("mupdateView.do")
	public String myPageEditView() {
		return "myPageEdit";
	}
	
	@RequestMapping(value="mupdate.do")
	public String memberUpdate(Member m, HttpServletRequest request
			,Model model,String email1,String email2,String interest
			,MultipartHttpServletRequest memFiles) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\memberProfileFiles";
		String fileName = "";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		Iterator<String> files = memFiles.getFileNames();
		MultipartFile mpf = memFiles.getFile(files.next());
		
		
		if(mpf == null || mpf.getSize() <= 0) {
			System.out.println("용량없음");
		}
		
		ArrayList memImgFiles = new ArrayList();
		
		List<MultipartFile> fileList = memFiles.getFiles("file");
		for(MultipartFile mfile : fileList) {
			fileName = mfile.getOriginalFilename();
			System.out.println("실제 파일 이름 : " + fileName);
			long fileSize = mfile.getSize();
			
			if(!mfile.isEmpty()) {
				String originalFileName = mfile.getOriginalFilename();
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
				int rdv = (int)(Math.random()*1000);
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "_" + rdv 
										+ originalFileName.substring(originalFileName.lastIndexOf("."));
				String renamePath = folder + "\\" + renameFileName;
			
				try {
					mfile.transferTo(new File(renamePath));
				}catch(Exception e) {
					e.printStackTrace();
				}
				memImgFiles.add(mfile.getOriginalFilename());
				memImgFiles.add(renameFileName);
			}
			System.out.println(memImgFiles);
		}
		
		if( memImgFiles.size()!=0){
		    String mProfileName = (String) memImgFiles.get(0);
			String renameMemName = (String) memImgFiles.get(1);
		
			System.out.println(mProfileName+", "+renameMemName);
			
			m.setmImage(mProfileName);
			m.setmRenameImage(renameMemName);
		} 		
		
		
		System.out.println(m.getmImage()+", " +m.getmRenameImage()+"savePath"+savePath);
		
		
		m.setEmail(email1+"@"+email2);
		m.setInterestes(interest);
		
		System.out.println(m);
		int result = mService.memberUpdate(m);
		
		if(result > 0) {
			model.addAttribute("loginUser", m);
			model.addAttribute("mNo", m.getmNo() );
			return "redirect:goMypage.do";
		} else {
			model.addAttribute("msg","회원 정보 수정 실패!");
			return "common/errorPage";
		}
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
