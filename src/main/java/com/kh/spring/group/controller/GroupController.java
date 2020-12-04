package com.kh.spring.group.controller;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonIOException;

import com.kh.spring.feed.model.service.FeedService;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.chat.model.service.ChatService;
import com.kh.spring.chat.model.vo.Chat;
import com.kh.spring.group.model.service.GroupService;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;
import com.kh.spring.search.model.vo.Search;


@Controller
public class GroupController{
	
	@Autowired
	private GroupService gService;
	
	@Autowired
	private FeedService fService;
	
	@Autowired
	private ChatService cService;
	
	/******* 그룹 **********/
	
	@RequestMapping("glist.do")
	public ModelAndView gList(ModelAndView mv, String userId) {
		ArrayList<Group> glist = gService.selectList();
		ArrayList<Feed> flist = fService.selectGfList(userId);
		System.out.println("지금 그룹리스트 불러올 때 :"+userId);
		ArrayList<Photo> fp = null;
		for(Feed f : flist) {
			fp = fService.selectPhotoList(f.getfNo());
			for(Photo p : fp) {
				if(p.getChangeName() != null) {
					f.setPhotoList(fp);
				}else {
					f.setPhotoList(null);
				}
			}
		}
		
		mv.addObject("glist", glist);
		mv.addObject("flist", flist);
		mv.setViewName("group/groupListView");
		return mv;
	}
	
	@RequestMapping("gInsertView.do")
	public String groupInsertView() {
		return "group/groupInsertForm";
	}
	
	@RequestMapping(value="ginsert.do", method=RequestMethod.POST)
	public String insertGroup(Group g, GroupMember gm, String gmId, HttpServletRequest request,
								MultipartHttpServletRequest groupFiles){
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		String savePath = root + "/gUploadFiles";
		String fileName = "";
		
		File folder = new File(savePath);
			if(!folder.exists()) {
				folder.mkdirs();
			}
		
		Iterator<String> files = groupFiles.getFileNames();
		MultipartFile mpf = groupFiles.getFile(files.next());
		
		
		if(mpf == null || mpf.getSize() <= 0) {
			System.out.println("용량없음");
			
		}
	
		ArrayList groupImgFiles = new ArrayList();
		
		List<MultipartFile> fileList = groupFiles.getFiles("file");
		for( MultipartFile gfile : fileList) {
			fileName = gfile.getOriginalFilename();
			System.out.println("실제 파일 이름 : " + fileName);
			long fileSize = gfile.getSize();
			
			if(!gfile.isEmpty()) {
				String originalFileName = gfile.getOriginalFilename();
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
				int rdv = (int)(Math.random()*1000);
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "_" + rdv 
										+ originalFileName.substring(originalFileName.lastIndexOf("."));
				String renamePath = folder + "/" + renameFileName;
			
				try {
					gfile.transferTo(new File(renamePath));
				}catch(Exception e) {
					e.printStackTrace();
				}
				groupImgFiles.add(gfile.getOriginalFilename());
				groupImgFiles.add(renameFileName);
			} else {
				groupImgFiles.add(null);
				groupImgFiles.add(null);
			}
			System.out.println(groupImgFiles);
		}
		
		
		    String gProfileName = (String) groupImgFiles.get(0);
			String renameGproName = (String) groupImgFiles.get(1);
			String gImageName = (String) groupImgFiles.get(2);
			String renameGimgName = (String) groupImgFiles.get(3);
		
			System.out.println(gProfileName+", "+renameGproName+", "+gImageName+", "+renameGimgName);
			
			g.setgProfile(gProfileName);
			g.setgRenameProfile(renameGproName);
			g.setgImage(gImageName);
			g.setgRenameImage(renameGimgName);
				
		
		
		System.out.println(g.getgProfile()+", " +g.getgRenameProfile()+", "+g.getgImage()+", "+g.getgRenameImage());
		
		g.setgCreator(gmId);
		int result = gService.insertGroup(g);
		int seq = g.getgNo();
		gm.setgNo(seq);
		System.out.println("그룹 시퀀스 : " + gm.getgNo());
		System.out.println(seq);
		if(result > 0) {
			gm.setGmId(g.getgCreator());
			int insertGm = gService.insertGM(gm);
			return "redirect:glist.do";
		} else {
			return "common/errorPage";
		}
	}
	
	@RequestMapping("gdetail.do")
	public ModelAndView groupDetail(ModelAndView mv, int gNo) {
		Group g = gService.selectGroup(gNo);
		ArrayList<GroupMember> gm = gService.selectGmList(gNo);
		ArrayList<Feed> ngflist = fService.selectGfeed(gNo);
		ArrayList<Feed> hgflist = fService.selectHGfeed(gNo);
		
		
		ArrayList<Photo> nfp = null;
		for(Feed nf : ngflist) {
			nfp = fService.selectPhotoList(nf.getfNo());
			
			for(Photo p : nfp) {
				if(p.getChangeName() != null) {
					nf.setPhotoList(nfp);
				}else {
					nf.setPhotoList(null);
				}
			}
		}
		
		ArrayList<Photo> hfp = null;
		for(Feed hf : hgflist) {
			hfp = fService.selectPhotoList(hf.getfNo());
			
			for(Photo p : hfp) {
				if(p.getChangeName() != null) {
					hf.setPhotoList(hfp);
				}else {
					hf.setPhotoList(null);
				}
			}
		}
		
		System.out.println(gm);
		String gmId = "";
		for( GroupMember getId : gm) {
			gmId += getId.getGmId() +", ";
		}
		System.out.println(gmId);
		
		if(g != null) {
			mv.addObject("gm",gm);
			mv.addObject("gmId", gmId);
			mv.addObject("ngflist", ngflist);
			mv.addObject("hgflist", hgflist);
			mv.addObject("g",g).setViewName("group/groupDetail");
		} else {
			mv.addObject("msg","그룹 상세조회에 실패하셨습니다.").setViewName("common/errerPage");
		}
		
		return mv;
	}
	
	@RequestMapping("gUpdateView.do")
	public ModelAndView gUpdateView(ModelAndView mv, int gNo) {
		ArrayList<GroupMember> gmList = gService.selectGmList(gNo);
		
		mv.addObject("gmList",gmList);
		mv.addObject("g", gService.selectUpdateGroup(gNo));
		mv.setViewName("group/groupUpdateView");
		return mv;
	}
	
	@RequestMapping("groupUpdate.do")
	public ModelAndView groupUpdate(ModelAndView mv, Group g, int gNo, String gPro, HttpServletRequest request,
								MultipartHttpServletRequest groupFiles) {
		System.out.println(g.getgNo());
		g.setgNo(gNo);
		
		System.out.println("그룹번호 : " + g.getgNo());
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		String savePath = root + "/gUploadFiles";
		String fileName = "";
		
		File folder = new File(savePath);
			if(!folder.exists()) {
				folder.mkdirs();
			}
		Iterator<String> files = groupFiles.getFileNames();
		MultipartFile mpf = groupFiles.getFile(files.next());
		
		
		if(mpf != null && mpf.isEmpty()) {
			if(g.getgRenameProfile()!=null && g.getgRenameImage()!=null) {
				deleteFile(g.getgRenameProfile(),g.getgRenameImage(),request);
			}
		}	
		ArrayList groupImgFiles = new ArrayList();
			
		List<MultipartFile> fileList = groupFiles.getFiles("file");
		for( MultipartFile gfile : fileList) {
			fileName = gfile.getOriginalFilename();
			System.out.println("실제 파일 이름 : " + fileName);
			long fileSize = gfile.getSize();
			
			if(!gfile.isEmpty()) {
				String originalFileName = gfile.getOriginalFilename();
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
				int rdv = (int)(Math.random()*1000);
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "_" + rdv 
										+ originalFileName.substring(originalFileName.lastIndexOf("."));
				String renamePath = folder + "/" + renameFileName;
			
				try {
					gfile.transferTo(new File(renamePath));
				}catch(Exception e) {
					e.printStackTrace();
				}
				groupImgFiles.add(gfile.getOriginalFilename());
				groupImgFiles.add(renameFileName);

			} else if(!gPro.isEmpty()){
				String[] str = gPro.split(",");
				for(int i = 0; i < str.length ; i++) {
					groupImgFiles.add(str[i]);
					groupImgFiles.add(str[i]);
				}
			}else {
				groupImgFiles.add(null);
				groupImgFiles.add(null);
			}
			System.out.println(groupImgFiles);
		}
		
		
		    String gProfileName = (String) groupImgFiles.get(0);
			String renameGproName = (String) groupImgFiles.get(1);
			String gImageName = (String) groupImgFiles.get(2);
			String renameGimgName = (String) groupImgFiles.get(3);
		
			System.out.println(gProfileName+", "+renameGproName+", "+gImageName+", "+renameGimgName);
			
			g.setgProfile(gProfileName);
			g.setgRenameProfile(renameGproName);
			g.setgImage(gImageName);
			g.setgRenameImage(renameGimgName);

		 	
		
		int result = gService.updateGroup(g);
		
		if(result > 0) {
			mv.addObject("g",g).setViewName("redirect:gdetail.do?gNo="+g.getgNo());
		}else {
			mv.addObject("msg","그룹정보 수정 실패").setViewName("common/errorPage");
		}

		return mv;
	}

	private void deleteFile(String getgRenameProfile, String getgRenameImage, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/buploadFiles";
		
		System.out.println(getgRenameProfile);
		System.out.println(getgRenameImage);
		File f = new File(savePath + "/" + getgRenameProfile);
		File f2 = new File(savePath + "/" + getgRenameImage);
		if(f.exists() && f2.exists()) {
			f.delete();
			f2.delete();
		}
	}

	@ResponseBody
	@RequestMapping("delFile1.do")
	public int fileDel1(int gNo, String file, HttpServletRequest request) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		
		System.out.println("넘어온 값 : "+file);
		File f = new File(savePath + "\\" + file);
		
		if(f.exists()) {
			f.delete();
			
		}
		
		int result = gService.updateFile1(gNo);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("delFile2.do")
	public int fileDel2(int gNo, String file, HttpServletRequest request) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		
		System.out.println("넘어온 값 : "+file);
		File f = new File(savePath + "\\" + file);
		
		if(f.exists()) {
			f.delete();
		}
		
		int result = gService.updateFile2(gNo);
		
		return result;
	}
	
	
	@RequestMapping("gdelete.do")
	public String groupDelete(int gNo, HttpServletRequest request) {
		System.out.println("그룹 삭제:"+gNo);
		Group g = gService.selectGroup(gNo);
		
		if(g.getgRenameImage() != null && g.getgRenameProfile() != null) {
			deleteFile(g.getgRenameImage(), g.getgRenameProfile(),request);
		}
		
		int result = gService.groupDelete(gNo);
		
		if(result > 0) {
			return "redirect:glist.do";
		}else {
			return "common/errorPage";
		}
	}
	
	
	@RequestMapping("gCreatorChange.do")
	public String gCreatorChange(Group g, String gmI, int gNo, HttpServletRequest request) {
		
		g.setgNo(gNo);
		g.setgCreator(gmI);
		System.out.println("그룹크리에이터 : " + g.getgCreator());
		int result = gService.gCreatorChange(g);
		
		if(result > 0) {
			return "redirect:gdetail.do?gNo="+gNo;
		}else {
			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@RequestMapping("gManagerChange.do")
	public int gManagerChange(Group g, String gmI, int gNo, HttpServletRequest request) {
		g.setgNo(gNo);
		g.setgManager(gmI);
		
		int result = gService.gManagerChange(g);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("gManagerDelete.do")
	public int gManagerDelete(Group g, String gmI, int gNo, HttpServletRequest request) {
		g.setgNo(gNo);
		g.setgManager(gmI);
		
		int result = gService.gManagerDelete(g);
		
		return result;
	}
	
	
	
	
	
	/*********여기서부터 그룹멤버 **************/
	
	@ResponseBody
	@RequestMapping("gmSelect.do")
	public int gmSelect(GroupMember gm, String userId, int gNo, HttpServletRequest request) {
		
		gm.setgNo(gNo);
		gm.setGmId(userId);
		System.out.println(gm.getGmId());
		System.out.println(gm.getgNo());
		
		int result = gService.gmSelectId(gm);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("gmCheckId.do")
	public int gmCheckId(GroupMember gm, String gmId, int gNo, HttpServletRequest request) {
		gm.setgNo(gNo);
		gm.setGmId(gmId);
		
		int result = gService.gmCheckId(gm);
		return result;
	}
	
	@RequestMapping(value="gmInsert.do", method=RequestMethod.POST)
	public String gmInsert(Group g, GroupMember gm, String mId, HttpServletRequest request) {
				
		gm.setgNo(g.getgNo());
		gm.setGmId(mId);
		
		
		int result = gService.gmInsert(gm);
		
		if(result > 0) {
			return "redirect:gdetail.do?gNo="+g.getgNo();
		}else {
			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@RequestMapping("gmUpdate.do")
	public int gmUpdate( GroupMember gm, String gmId, int gNo, HttpServletRequest request) {
		
		gm.setgNo(gNo);
		gm.setGmId(gmId);
		System.out.println(gm.getgNo());
		System.out.println(gm.getGmId());
		
		int result = gService.gmUpdate(gm);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("gmDeleteCheck.do")
	public int gmDeleteCheck(GroupMember gm, String gmId, int gNo, HttpServletRequest request) {
		
		
		gm.setgNo(gNo);
		gm.setGmId(gmId);
		int result = gService.gmDeleteCheck(gm);
		
		return result;
	}
	
	@RequestMapping("gmList.do")
	public void getgmList(HttpServletResponse response, int gNo) throws JsonIOException, IOException {
		
		response.setContentType("application/json; charset=UTF-8");
		ArrayList<GroupMember> gmList = gService.selectGmList(gNo);
		JSONObject job = null;
		JSONArray jArr = new JSONArray();
		
		for( GroupMember gl : gmList) {
			System.out.println(gl.getGmImage());
			
			job = new JSONObject();
			job.put("gmLevel", gl.getGmLevel());
			job.put("gmId", gl.getGmId());
			if(gl.getGmImage()!= null) {
				job.put("gmImage","memberProfileFiles/"+gl.getGmImage());
			}else {
				job.put("gmImage", "icons/logo.png");
			}
			
			jArr.add(job);
		}
		PrintWriter out = response.getWriter();
		out.print(jArr);
	}
	
	@RequestMapping("NgmList.do")
	public void getNgmList(HttpServletResponse response, int gNo) throws JsonIOException, IOException {
		response.setContentType("application/json; charset=UTF-8");
		ArrayList<GroupMember> NgmList = gService.selectNgmList(gNo);
		JSONObject job = null;
		JSONArray jArr = new JSONArray();

		for( GroupMember Ngl : NgmList) {
			System.out.println(Ngl.getGmImage());
			
			job = new JSONObject();
			job.put("gmLevel", Ngl.getGmLevel());
			job.put("gmId", Ngl.getGmId());
			job.put("a1", Ngl.getA1());
			job.put("a2", Ngl.getA2());
			job.put("a3", Ngl.getA3());
			if(Ngl.getGmImage()!= null) {
				job.put("gmImage","memberProfileFiles/"+Ngl.getGmImage());
			}else {
				job.put("gmImage", "icons/logo.png");
			}
			
			jArr.add(job);
		}
		PrintWriter out = response.getWriter();
		out.print(jArr);
	}
	
	@RequestMapping("gmDelete.do")
	public String gmDelete(GroupMember gm, String gmId, int gNo, HttpServletRequest request) {
		
		gm.setgNo(gNo);
		gm.setGmId(gmId);
		
		int result = gService.gmDelete(gm);
		
		if(result > 0) {
			return "redirect:gdetail.do?gNo="+gNo;
		}else {
			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@RequestMapping("gmChangeMaster.do")
	public int gmChangeMaster(GroupMember gm, String gmId, int gNo, HttpServletRequest request) {
		
		gm.setgNo(gNo);
		gm.setGmId(gmId);
		System.out.println("그룹장 위임 : "+gm.getgNo());
		System.out.println("그룹장 위임 : "+gm.getGmId());
		int result = gService.gmChangeMaster(gm);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("gmChangeLevel.do")
	public int gmChangeLevel(GroupMember gm, String gmL, int gNo, HttpServletRequest request) {
		gm.setgNo(gNo);
		gm.setGmLevel(gmL);

		System.out.println("그룹장 레벨변경 : "+gm.getgNo());
		System.out.println("그룹장 레벨변경 : "+gm.getGmLevel());
		int result = gService.gmChangeLevel(gm);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("changeManager.do")
	public int gmChangeManager(GroupMember gm, String gmId, int gNo, HttpServletRequest request) {
		gm.setgNo(gNo);
		gm.setGmId(gmId);
		
		int result = gService.gmChangeManager(gm);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("changeMember.do")
	public int gmChangeMember(GroupMember gm, String gmI, int gNo, HttpServletRequest request) {
		gm.setgNo(gNo);
		gm.setGmId(gmI);
		System.out.println(gNo);
		System.out.println(gmI);
		int result = gService.gmChangeMember(gm);
		
		return result;
	}

	public ArrayList<GroupMember> getGroupList(String toId) {
		int gNo = Integer.parseInt(toId);
		ArrayList<GroupMember> gmList = gService.selectGmList(gNo);
		return gmList;
	}
	
	//그룹 내 검색
	@ResponseBody
	@RequestMapping(value="gSearch.do",produces="application/json;charset=utf-8")
	public String groupSearch(int gNo, String gsearch) {
		Search s = new Search();
		s.setSearchType(gsearch.charAt(0));
		s.setsNum(gNo);
		s.setSearch(gsearch.substring(1)); // 키워드
		s.setSearchall(gsearch);
		//System.out.println("gno : "+s.getsNum()+"  searchall"+gsearch+"  SearchType: "+s.getSearchType()+"  key:"+s.getSearch());
		ArrayList<Feed> flist = new ArrayList<Feed>();
		//검색
		if(s.getSearchType() == '#') {
			flist = gService.groupSearch(s);
		}else if(s.getSearchType() =='@') {
			flist = gService.groupSearch(s);
		}else{
			flist = gService.groupSearch(s);
		}

		JSONObject job = new JSONObject();
		if(flist.isEmpty()) {
			//System.out.println("검색 결과 없음");
			job.put("msg",gsearch+"로 검색되는 게시글이 없습니다");
			return job.toString();
		}else {
			//System.out.println("검색타입"+s.getSearchType()+"  "+flist);
			JSONArray jArr = new JSONArray();
			for(int i=0; i < flist.size(); i++) {
				JSONObject jObj = new JSONObject();
				jObj.put("fno", flist.get(i).getfNo());
				jObj.put("mno", flist.get(i).getmNo());
				jObj.put("fcontent", flist.get(i).getfContent());
				jObj.put("thumbnail", flist.get(i).getThumbnail());
				jArr.add(jObj);			
			}
			job.put("flist", jArr);
			return job.toString();
		}
	}
	
	
	
	
	
}
