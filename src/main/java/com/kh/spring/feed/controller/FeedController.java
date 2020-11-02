package com.kh.spring.feed.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.spring.feed.model.service.FeedService;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;


@SessionAttributes("feedPost")
@Controller
public class FeedController {
	
	@Autowired
	private FeedService fService;
	
	@RequestMapping("pInsertView.do")
	public String postInsertView() {
		return "feed/PostInsertForm";
	}
	
	@RequestMapping("pInsert.do")
	public String insertPost(Feed f, Photo p, MultipartHttpServletRequest multi) {
		int result = fService.insertPost(f);
		
		List<MultipartFile> fileList = multi.getFiles("upFile");
		String root = multi.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\pUploadFiles";
		ArrayList<Photo> photoList = null;
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
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "." + rdv
					//						[		20200929191422.png										]
										  + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
			
			String saveFile = savePath + "\\" +  renameFileName;
			
			if(!fileList.isEmpty()) {
				
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
	
//	@RequestMapping(value = "/PostInsertForm", method = RequestMethod.GET)
//	public String upload(Locale locale, Model model) {
//
//		return "feed/PostInsertForm";
//	}
	
//	public String MultiUpload(MultipartHttpServletRequest multi) {
//		
//		
//		
//		// 저장 경로 설정
//		String root = multi.getSession().getServletContext().getRealPath("resources");
//		String savePath = root + "\\pUploadFiles";
//		
//		File folder = new File(savePath);	// 저장 폴더
//		
//		if(!folder.exists()) {
//			folder.mkdirs();
//		}
//		
//		
//		for(MultipartFile filePart : fileList) {
//			
//			String originalFileName = filePart.getOriginalFilename();	// 원본 파일명
//			System.out.println("실제 파일명 : " + originalFileName);
//			
//			long fileSize = filePart.getSize();		// 파일 사이즈
//			System.out.println("파일 사이즈 : " + fileSize);
//			
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
//			//						[		20200929191422.											]
//			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
//					//						[		20200929191422.png										]
//										  + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
//			String renamePath = folder + "\\" + renameFileName;
//
//			try {
//				filePart.transferTo(new File(renamePath));
//			}catch (Exception e) {
//				e.printStackTrace();
//			}
//			
//			return renameFileName;
//			
//		}
//		
//		return "";
//		
//		
//	}
	
//	@RequestMapping("pUpdate.do")					//	 ↓ 제외 가능
//	public ModelAndView boardUpdate(ModelAndView mv, @ModelAttribute Feed f, 
//			@RequestParam(value="reloadFile", required=false) MultipartHttpServletRequest multi) {
//			
////			String renameFileName = MultiUpload(multi);
//			
//			if(renameFileName != null) {
//				f.setfFile(((MultipartFile) multi).getOriginalFilename());
//				f.setfRenameFile(renameFileName);
//			}
//			
//		int result = fService.updatePost(f);
//		
//		if(result > 0) {
//			mv.addObject("fNo", f.getfNo()).setViewName("redirect:home.do");
//		}else {
//			mv.addObject("msg", "수정 실패").setViewName("common/errorPage");
//		}
//		
//		return mv;
//	}
	
}
