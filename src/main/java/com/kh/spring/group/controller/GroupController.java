package com.kh.spring.group.controller;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.spring.group.model.service.GroupService;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;


@Controller
public class GroupController{
	
	@Autowired
	private GroupService gService;
	
	/******* 그룹 **********/
	
	@RequestMapping("glist.do")
	public ModelAndView gList(ModelAndView mv) {
		ArrayList<Group> glist = gService.selectList();
		mv.addObject("glist", glist);
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
		
		String savePath = root + "\\gUploadFiles";
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
				String renamePath = folder + "\\" + renameFileName;
			
				try {
					gfile.transferTo(new File(renamePath));
				}catch(Exception e) {
					e.printStackTrace();
				}
				groupImgFiles.add(gfile.getOriginalFilename());
				groupImgFiles.add(renameFileName);
			}
			System.out.println(groupImgFiles);
		}
		
		if( groupImgFiles.size()!=0){
		    String gProfileName = (String) groupImgFiles.get(0);
			String renameGproName = (String) groupImgFiles.get(1);
			String gImageName = (String) groupImgFiles.get(2);
			String renameGimgName = (String) groupImgFiles.get(3);
		
			System.out.println(gProfileName+", "+renameGproName+", "+gImageName+", "+renameGimgName);
			
			g.setgProfile(gProfileName);
			g.setgRenameProfile(renameGproName);
			g.setgImage(gImageName);
			g.setgRenameImage(renameGimgName);
		} 		
		
		
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
		if(g != null) {
			mv.addObject("gm",gm);
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
	public ModelAndView groupUpdate(ModelAndView mv, Group g, int gNo, HttpServletRequest request,
								MultipartHttpServletRequest groupFiles) {
		System.out.println(g.getgNo());
		g.setgNo(gNo);
		
		System.out.println("그룹번호 : " + g.getgNo());
		String root = request.getSession().getServletContext().getRealPath("resources");
		
		String savePath = root + "\\gUploadFiles";
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
				String renamePath = folder + "\\" + renameFileName;
			
				try {
					gfile.transferTo(new File(renamePath));
				}catch(Exception e) {
					e.printStackTrace();
				}
				groupImgFiles.add(gfile.getOriginalFilename());
				groupImgFiles.add(renameFileName);
			}
			System.out.println(groupImgFiles);
		}
		
		if( groupImgFiles.size()!=0){
		    String gProfileName = (String) groupImgFiles.get(0);
			String renameGproName = (String) groupImgFiles.get(1);
			String gImageName = (String) groupImgFiles.get(2);
			String renameGimgName = (String) groupImgFiles.get(3);
		
			System.out.println(gProfileName+", "+renameGproName+", "+gImageName+", "+renameGimgName);
			
			g.setgProfile(gProfileName);
			g.setgRenameProfile(renameGproName);
			g.setgImage(gImageName);
			g.setgRenameImage(renameGimgName);
		} 		

		
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
		String savePath = root + "\\buploadFiles";
		
		System.out.println(getgRenameProfile);
		System.out.println(getgRenameImage);
		File f = new File(savePath + "\\" + getgRenameProfile);
		File f2 = new File(savePath + "\\" + getgRenameImage);
		if(f.exists() && f2.exists()) {
			f.delete();
			f2.delete();
		}
	}

	@RequestMapping("gdelete.do")
	public String groupDelete(int gNo, HttpServletRequest request) {
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
		ArrayList<GroupMember> gmList = gService.selectGmList(gNo);
		
		response.setContentType("application/json; charset=UTF-8");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(gmList,response.getWriter());
		
	}
	
	@RequestMapping("NgmList.do")
	public void getNgmList(HttpServletResponse response, int gNo) throws JsonIOException, IOException {
		ArrayList<GroupMember> NgmList = gService.selectNgmList(gNo);
		
		response.setContentType("application/json; charset=UTF-8");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(NgmList,response.getWriter());
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
	
	
	@ResponseBody
	@RequestMapping(value="totalGroups.do", method = RequestMethod.GET)
	public int totalGroups(HttpServletResponse response) throws IOException{
		
		int totalGroups = gService.totalGroups();
		return totalGroups;
	}

}
