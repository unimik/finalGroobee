package com.kh.spring.feed.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
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
	public String insertPost(Feed f, HttpServletRequest request,
			@RequestParam(name="uploadFile", required=false) MultipartFile file) {
		if(!file.getOriginalFilename().equals("")) {
			
			String renameFileName = saveFile(file, request);
			
			if(renameFileName != null) {	// 파일이 잘 저장된 경우
				f.setfFile(file.getOriginalFilename());
				f.setfRenameFile(renameFileName);
			}
		}
		System.out.println(f);
		int result = fService.insertPost(f);
		
		if(result > 0) {
			return "redirect:fList.do";
			
		}else {
			return "../common/errorPage";
		}
	}
	
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			
			folder.mkdirs();
		}
		
		
		String originalFileName = file.getOriginalFilename();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
							  + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
		
		String renamePath = folder + "\\" + renameFileName;
		
		try {
			file.transferTo(new File(renamePath));
		}catch(Exception e) {
			System.out.println("파일 전송 에러 : " + e.getMessage());
		}
		
		return renameFileName;
	}
	
	@RequestMapping("fList.do")
	public ModelAndView feedList(ModelAndView mv) {
		System.out.println("ㅡㅏㅡㅏㅡㅏ");
		ArrayList<Feed> f = fService.selectFeed();
		System.out.println(f);
		
		if(f != null) {
			mv.addObject("f", f).setViewName("home");
		}else {
			mv.addObject("msg", "에러 발생").setViewName("common/errorPage");
		}
		
		return mv;
	}

}
