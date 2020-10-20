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

import com.kh.spring.group.model.service.GroupService;
import com.kh.spring.group.model.vo.Group;
import com.kh.spring.group.model.vo.GroupMember;


@Controller
public class GroupController{
	
	@Autowired
	private GroupService gService;
	
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
		
		if(g != null) {
			mv.addObject("g",g).setViewName("group/groupDetail");
		} else {
			mv.addObject("msg","그룹 상세조회에 실패하셨습니다.").setViewName("common/errerPage");
		}
		
		return mv;
	}
	
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
	@RequestMapping(value="totalGroups.do", method = RequestMethod.GET)
	public int totalGroups(HttpServletResponse response) throws IOException{
		
		int totalGroups = gService.totalGroups();
		return totalGroups;
	}
	
	
	
	@RequestMapping("gUpdateView.do")
	public ModelAndView gUpdateView(ModelAndView mv, int gNo) {
		ArrayList<GroupMember> gmList = gService.selectGmList(gNo);
		ArrayList<GroupMember> NgmList = gService.selectNgmList(gNo);
		mv.addObject("g", gService.selectUpdateGroup(gNo));
		mv.addObject("NgmList", NgmList);
		mv.addObject("gmList", gmList);
		mv.setViewName("group/groupUpdateView");
		return mv;
	}
}
