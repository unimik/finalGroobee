package com.kh.spring.feed.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.feed.model.service.FeedService;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.group.model.vo.GroupName;
import com.kh.spring.member.model.vo.Member;


@Controller
public class FeedController {
	
	@Autowired
	private FeedService fService;
		
	@RequestMapping("pInsertView.do")
	public ModelAndView postInsertView(ModelAndView mv, ArrayList<GroupName> gn, HttpSession session) {
		Member mem = (Member)session.getAttribute("loginUser");
		gn = fService.selectGroupMemberId(mem.getUserId());
		
		mv.addObject("gn", gn);
		mv.setViewName("feed/PostInsertForm");
		return mv;
	}
	
	@RequestMapping("pInsert.do")
	public String insertPost(Feed f, Photo p, GroupName gn, MultipartHttpServletRequest multi) {

		System.out.println(gn.getgNo());
		int result = fService.insertPost(f);
		
		List<MultipartFile> fileList = multi.getFiles("upFile");
		String root = multi.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\pUploadFiles";
		File folder = new File(savePath);	// 저장 폴더
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		for(MultipartFile mf : fileList) {
			String originalFileName = mf.getOriginalFilename(); // 원본 파일명
			long fileSize = mf.getSize();		// 파일 사이즈
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			//						[		20200929191422.											]
			int rdv = (int)(Math.random()*1000);
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + rdv + "."
					//						[		20200929191422 + 랜덤값.png										]
										  + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
			
			String saveFile = savePath + "\\" +  renameFileName;
			
			if(!mf.getOriginalFilename().equals("")) {
				
				System.out.println("mf : " + mf.getOriginalFilename());
				System.out.println("rename : " + renameFileName);
				
				// 서버에 업로드 진행하기
				if(renameFileName != null) {	// 파일이 잘 저장된 경우
					p.setOriginName(mf.getOriginalFilename());
					p.setChangeName(renameFileName);
				}
			}
			
			try {
				p.setfNo(f.getfNo());
				int photo = fService.insertPhoto(p);
				mf.transferTo(new File(saveFile));
			}catch(IOException e) {
				e.printStackTrace();
			}
			
			System.out.println(originalFileName);
		}
		
		
		if(result > 0) {
			return "redirect:home.do";
		}else {
			return "../common/errorPage";
		}
	}
	
	@RequestMapping("pUpdateView.do")
	public ModelAndView postUpdateView(ModelAndView mv, int fNo, ArrayList<GroupName> gn, HttpSession session) {
		Member mem = (Member)session.getAttribute("loginUser");
		// 가입한 그룹(Select Tag)
		gn = fService.selectGroupMemberId(mem.getUserId());
		
		// fNo를 가지고 해당하는 피드정보 + 사진정보 가져오기 
		Feed f = fService.selectUpdateFeed(fNo);
		mv.addObject("gn", gn);
		mv.addObject("f", f);
		mv.setViewName("feed/PostUpdateForm");
		return mv;
	}
	
	@RequestMapping("pUpdate.do")
	public ModelAndView postUpdate(ModelAndView mv, @ModelAttribute Feed f, Photo p, GroupName gn, MultipartHttpServletRequest multi) {

		System.out.println(f.getfNo());
		int result = fService.updatePost(f);
		
		
		// 파일 업로드 부분
		
		List<MultipartFile> fileList = multi.getFiles("reloadFile");
		String root = multi.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\pUploadFiles";
		File folder = new File(savePath);	// 저장 폴더

		for(MultipartFile mf : fileList) {
			String originalFileName = mf.getOriginalFilename(); // 원본 파일명
			long fileSize = mf.getSize();		// 파일 사이즈
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			//						[		20200929191422.											]
			int rdv = (int)(Math.random()*1000);
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + rdv + "."
					//						[		20200929191422 + 랜덤값.png										]
										  + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
			
			String saveFile = savePath + "\\" +  renameFileName;
			
			if(!fileList.isEmpty()) {
				
				if(p.getChangeName() != null) {
					deleteFile(p.getChangeName(), multi);
				}
				
				// 서버에 업로드 진행하기
				if(renameFileName != null) {	// 파일이 잘 저장된 경우
					p.setOriginName(mf.getOriginalFilename());
					p.setChangeName(renameFileName);
				}
			}
			
			try {
				p.setfNo(f.getfNo());
				int photo = fService.insertPhoto(p);
				mf.transferTo(new File(saveFile));
			}catch(IOException e) {
				e.printStackTrace();
			}
			
			System.out.println(originalFileName);
		}
		
		// 업로드 끝
		
		
		if(result > 0) {
			mv.addObject("fNo", f.getfNo()).setViewName("redirect:home.do");
		}else {
			mv.addObject("msg", "수정 실패!").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\pUploadFiles";
		File f = new File(savePath + "\\"+ fileName);
		
		if(f.exists()) {
			f.delete();
		}
	}
	
	@RequestMapping("fDelete.do")
	public String postDelete(int fNo, Photo p, HttpServletRequest request) {
		Feed f = fService.selectUpdateFeed(fNo);
		
		if(p.getChangeName() != null) {
			deleteFile(p.getChangeName(), request);
		}
		int result = fService.deletePost(fNo);
		
		if(result > 0) {
			return "redirect:home.do";
		}else {
			return "common/errorPage";
		}
	}
	
}
