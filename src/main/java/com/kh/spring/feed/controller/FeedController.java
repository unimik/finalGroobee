package com.kh.spring.feed.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.feed.model.service.FeedService;
import com.kh.spring.feed.model.vo.Feed;


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
	public String insertPost(Feed f,
			@RequestParam(value="uploadFile", required=false) MultipartHttpServletRequest multi) {
		System.out.println("들어오니?");
		if(!((MultipartFile) multi).getOriginalFilename().equals("")) {
			
			String renameFileName = MultiUpload(multi);
			
			if(renameFileName != null) {	// 파일이 잘 저장된 경우
				f.setfFile(((MultipartFile) multi).getOriginalFilename());
				f.setfRenameFile(renameFileName);
			}
		}
		
		int result = fService.insertPost(f);
		
		if(result > 0) {
			return "redirect:home.do";
			
		}else {
			return "../common/errorPage";
		}
	}
	
	@RequestMapping("/upload")
	public String MultiUpload(Model model,
			@RequestParam(required=false) List<MultipartFile> fileList) {
		
		// 저장 경로 설정
		String root = ((HttpServletRequest) fileList).getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\pUploadFiles";
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		
		for(MultipartFile filePart : fileList) {
			String originalFileName = filePart.getOriginalFilename();	// 원본 파일명
			System.out.println("실제 파일명 : " + originalFileName);
			long fileSize = filePart.getSize();		// 파일 사이즈
			System.out.println("파일 사이즈 : " + fileSize);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			//						[		20200929191422.											]
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
					//						[		20200929191422.png										]
										  + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
			String renamePath = folder + "\\" + originalFileName;

			try {
				filePart.transferTo(new File(renamePath));
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			return renameFileName;
		}
		
	}
	
	@RequestMapping("pUpdate.do")					//	 ↓ 제외 가능
	public ModelAndView boardUpdate(ModelAndView mv, @ModelAttribute Feed f, 
			@RequestParam(value="reloadFile", required=false) MultipartHttpServletRequest multi) {
			
			String renameFileName = MultiUpload(multi);
			
			if(renameFileName != null) {
				f.setfFile(((MultipartFile) multi).getOriginalFilename());
				f.setfRenameFile(renameFileName);
			}
			
		int result = fService.updatePost(f);
		
		if(result > 0) {
			mv.addObject("fNo", f.getfNo()).setViewName("redirect:home.do");
		}else {
			mv.addObject("msg", "수정 실패").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
}
