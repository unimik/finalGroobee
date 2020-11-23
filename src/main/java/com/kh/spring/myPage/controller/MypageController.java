package com.kh.spring.myPage.controller;



import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.group.model.service.GroupService;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Follow;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.service.MypageService;
import com.kh.spring.myPage.model.vo.Mypage;
import com.kh.spring.myPage.model.vo.StorageBox;
import com.kh.spring.setting.model.service.SettingService;
import com.kh.spring.setting.model.vo.PersonalSetting;


@Controller
public class MypageController {
	
	@Autowired
	MypageService myService;

	@Autowired
	MemberService mService;

	@Autowired
	GroupService gService;

	@Autowired
	SettingService sService;
	
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
		ArrayList<Mypage> followerList = myService.selectFollowerList(mNo);
		ArrayList<Mypage> followingList = myService.selectFollowingList(mNo);
		
		mv.addObject("memberInfo", memberInfo);
		mv.addObject("followInfo", followInfo);
		mv.addObject("feedList", feedList);
		mv.addObject("feedCnt", feedList.size());
		mv.addObject("storageBoxList", storageBoxList);
		mv.addObject("groupList", groupList);
		mv.addObject("followerList", followerList);
		mv.addObject("followingList", followingList);
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
		String savePath = root + "/memberProfileFiles";
		
		File f = new File(savePath + "/" + memFile);
		
		if(f.exists()) {
			f.delete();
		}
	}

	private String saveFile(MultipartFile memFile, HttpServletRequest request) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/memberProfileFiles";
		String fileName = "";
		
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		String originalFileName = memFile.getOriginalFilename();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
											+ originalFileName.substring(originalFileName.lastIndexOf(".")+1);
		
		String renamePath = folder + "/" + renameFileName;
		
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
		
		if(mno !=0) {
		int result = myService.updateBox(sblist);
		//System.out.println("결과값 어캐나옴"+ result);
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
	
	//보관함 안에 게시글 보기
	@ResponseBody
	@RequestMapping(value="goStorageBox",produces="application/json;charset=utf-8")
	public String goStorageBox(int mno, int sbno){
		//객체로 옮기는게 나은가 번호 두개로 가서 옮기는게 나은가?
		StorageBox sb = new StorageBox();
		sb.setmNo(mno);
		sb.setSbNo(sbno);
		// 보관함 안에 있는 게시글  가져오가ㅣ
		ArrayList<Feed> flist = myService.sBoxfList(sb); 
//		System.out.println("보관함에 있는 게시글들"+flist);	//보관함 게시글 
		JSONObject job = new JSONObject();
		if(flist.isEmpty()) {
			job.put("msg","보관함에 게시물이 없습니다");
			return job.toString();
		}else {
			JSONArray jArr = new JSONArray();
			for(int i=0; i <flist.size(); i++) {
				JSONObject jObj = new JSONObject();
				jObj.put("fno", flist.get(i).getfNo());
				jObj.put("fcontent", flist.get(i).getfContent());
				jObj.put("thumbnail", flist.get(i).getThumbnail());
				jArr.add(jObj);				
			}
			job.put("fList", jArr);
			return job.toString();
		}
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
		ArrayList<Mypage> followerList = myService.selectFollowerList(memberInfo.getmNo());
		ArrayList<Mypage> followingList = myService.selectFollowingList(memberInfo.getmNo());
		
		PersonalSetting ps = sService.personalSetting(mNo);
		PersonalSetting userPs = sService.personalSetting(memberInfo.getmNo());
		
		String blocked = ps.getBlockedNo();
		String blockedYN = "N";
		if(blocked != null) {
			String[] blist = blocked.split(",");
			
			if(blist!=null) {
				
				for (String string : blist) {
					Member blockedMember = mService.selectOne(string);
					
					if(blockedMember.getmNo() == memberInfo.getmNo()) {
						blockedYN = "Y";
						break;
					} else {
						blockedYN = "N";
					}

				}
			}
		}
		
		mv.addObject("blockedYN",blockedYN);
		mv.addObject("userPs",userPs);
		mv.addObject("memberInfo", memberInfo);
		mv.addObject("followInfo", followInfo);
		mv.addObject("feedList", feedList);
		mv.addObject("feedCnt", feedList.size());
		mv.addObject("followYN", followYN);
		mv.addObject("followerList", followerList);
		mv.addObject("followingList", followingList);
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
	
	@RequestMapping("myGmDelete.do")
	public String myGmDelete(GroupMember gm, String gmId, int gNo, int mNo,HttpServletRequest request) {
		
		gm.setgNo(gNo);
		gm.setGmId(gmId);
		
		int result = gService.gmDelete(gm);
		
		if(result > 0) {
			return "redirect:goMypage.do?mNo="+mNo;
		}else {
			return "common/errorPage";
		}
	}

	@RequestMapping("myBlockAccount.do")
	public String blockAccount(@RequestParam("newblock") String newblock,@RequestParam("userId") String userId,
								@RequestParam("follow") int follow, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Member m = (Member)session.getAttribute("loginUser");

		int mNo = m.getmNo();
		
		PersonalSetting ps = sService.personalSetting(mNo);
		String blocked = ps.getBlockedNo();
		
		String updateList = "";
		
		if(blocked == null) {
			updateList = newblock;
		} else {
			updateList = blocked +","+newblock;
		}
		
		PersonalSetting p = new PersonalSetting(m.getmNo(),updateList);
		int result = sService.disableblock(p);
		if(result > 0 ) {
			Follow fw = new Follow();
			fw.setmNo(mNo);
			fw.setFollows(follow);
			String followYN = myService.selectFollowYN(fw);
			if("Y".equals(followYN.toString())) {
				int result2 = myService.deleteFollow(fw);				
				if(result2 > 0 ) {
					return "redirect:goUserpage.do?userId="+userId+"&mNo="+mNo;		
				}else {
					return"common/errorPage";
				}
			} else {
				return "redirect:goUserpage.do?userId="+userId+"&mNo="+mNo;	
			}
		}else {
			return"common/errorPage";
		}
	}
	
	@RequestMapping("myDisableBlock.do")
	public String disableBlock( @RequestParam("userId") String userId,
								@RequestParam("disblockId") String disblockId ) {
		
		Member m = (Member)session.getAttribute("loginUser");
		
		int mNo = m.getmNo();
		
		PersonalSetting blocked = sService.personalSetting(mNo);
	
			String[] bList = blocked.getBlockedNo().split(",");
			String updateList =	null;
			for (String b : bList) {
				if(!b.equals(disblockId)) {
					if(updateList == null) {
						updateList = b;
					}else {
						updateList += "," + b;					
					}
				}
			}
			
		PersonalSetting p = new PersonalSetting(m.getmNo(),updateList);
		int result = sService.disableblock(p);
			
		if(result > 0 ) {
			return "redirect:goUserpage.do?userId="+userId+"&mNo="+mNo;			
		}else {
			return"common/errorPage";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="goDetail.do",produces="application/json;charset=utf-8")
	public String goDetail(ModelAndView mv,String fNo, String mNo, String smNo) {
		JSONObject job = new JSONObject();
		
		int mno = 0;
		int fno = 0;
		int smno = 0;
		mno = Integer.parseInt(mNo);
		fno = Integer.parseInt(fNo);
		smno = Integer.parseInt(smNo);
		Feed f = new Feed();
		f.setmNo(mno);
		f.setfNo(fno);
		f.setSmNo(smno);
			
		Feed detail = myService.detailFeed(f);
		ArrayList<Photo> photoList = myService.selectPhotoList(fno);
		ArrayList<Reply> replyList = myService.selectReplyList(fno);
		
		if(detail == null) {
			job.put("msg", "잘못된 게시물입니다.");
			return job.toString();
		}else {
			job.put("fcontent", detail.getfContent());
			job.put("fWriter", detail.getfWriter());
			job.put("fCreateDate", detail.getfCreateDate().toString());
			job.put("fLocation", detail.getfLocation());
			job.put("fLikeCnt", detail.getfLikeCnt());
			job.put("fReplyCnt", detail.getfReplyCnt());
			job.put("mImage", detail.getmImage());
			job.put("fLikeSet", detail.getfLikeSet());
			job.put("fReplySet", detail.getfReplySet());
			job.put("fShareSet", detail.getfShareSet());
			job.put("fOpenScope", detail.getfOpenScope());
			job.put("likeChk", detail.getLikeChk());
			job.put("shareYN", detail.getShareYN());
		}

		if(photoList != null) {
			JSONArray jArr = new JSONArray();
			for(int i=0; i <photoList.size(); i++) {
					JSONObject jObj = new JSONObject();
					jObj.put("changeName", photoList.get(i).getChangeName());
					jArr.add(jObj);
			}
			job.put("photoList", jArr);
		}
		job.put("photoListSize", photoList.size());
		
		if(replyList != null) {
			JSONArray jArr = new JSONArray();
			for(int i=0; i <replyList.size(); i++) {
				JSONObject jObj = new JSONObject();
				jObj.put("mNo", replyList.get(i).getmNo());
				jObj.put("rContent", replyList.get(i).getrContent());
				jObj.put("rWriter", replyList.get(i).getrWriter());
				jObj.put("rWriterImg", replyList.get(i).getrWriterImg());
				jObj.put("rCreateDate", replyList.get(i).getrCreateDate());
				jObj.put("rModifyDate", replyList.get(i).getrModifyDate());
				jObj.put("rStatus", replyList.get(i).getrStatus());
				jArr.add(jObj);
			}
			job.put("replyListSize", replyList.size());
			job.put("replyList", jArr);
		}
		return job.toString();
	}
	
	@RequestMapping("shareFeedCancle.do")
	public String shareFeedCancle(ModelAndView mv,String sfNo, String smNo) {
		
		int sfno = 0;
		int smno = 0;
		sfno = Integer.parseInt(sfNo);
		smno = Integer.parseInt(smNo);
		Feed f = new Feed();
		f.setfNo(sfno);
		f.setSmNo(smno);
		
		int result = myService.shareFeedCancle(f);
		
		if(result > 0) {
			return "redirect:goMypage.do?mNo="+smNo;	
		} else {
			return "common/errorPage";
		}
	}
}
