package com.kh.spring.feed.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.apache.ibatis.javassist.expr.NewArray;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.spring.feed.model.service.FeedService;
import com.kh.spring.feed.model.vo.Feed;
import com.kh.spring.feed.model.vo.Photo;
import com.kh.spring.feed.model.vo.Reply;
import com.kh.spring.feed.model.vo.ShareFeed;
import com.kh.spring.feed.model.vo.Tag;
import com.kh.spring.group.model.vo.GroupName;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.myPage.model.service.MypageService;
import com.kh.spring.myPage.model.vo.StorageBox;


@Controller
public class FeedController {
   
   @Autowired
   private FeedService fService;
   
   @Autowired
   private MypageService myService;
      
   @RequestMapping("pInsertView.do")
   public ModelAndView postInsertView(ModelAndView mv, ArrayList<GroupName> gn, HttpSession session) {
      Member mem = (Member)session.getAttribute("loginUser");
      gn = fService.selectGroupMemberId(mem.getUserId());
      
      mv.addObject("gn", gn);
      mv.setViewName("feed/PostInsertForm");
      return mv;
   }
   
   @RequestMapping("pInsert.do")
   public String insertPost(Feed f, Photo p, GroupName gn, MultipartHttpServletRequest multi, HttpSession session) {
	   System.out.println(f);
      System.out.println(gn.getgNo());
      int result = fService.insertPost(f);
      
      Member mem = (Member)session.getAttribute("loginUser");
      
      List<MultipartFile> fileList = multi.getFiles("upFile");
      String root = multi.getSession().getServletContext().getRealPath("resources");
      String savePath = root + "/pUploadFiles";
      File folder = new File(savePath);   // 저장 폴더
      
      if(!folder.exists()) {
         folder.mkdirs();
      }
      
      for(MultipartFile mf : fileList) {
         String originalFileName = mf.getOriginalFilename(); // 원본 파일명
         long fileSize = mf.getSize();      // 파일 사이즈
         
         SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
         //                  [      20200929191422.                                 ]
         int rdv = (int)(Math.random()*1000);
         String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + rdv + "."
               //                  [      20200929191422 + 랜덤값.png                              ]
                                + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
         
         String saveFile = savePath + "/" + renameFileName;
         
         System.out.println("" + f.getfNo());
         
         if(!mf.getOriginalFilename().equals("")) {
            
            System.out.println("mf : " + mf.getOriginalFilename());
            System.out.println("rename : " + renameFileName);
            
            // 서버에 업로드 진행하기
            if(renameFileName != null) {   // 파일이 잘 저장된 경우
               p.setOriginName(mf.getOriginalFilename());
               p.setChangeName(renameFileName);
            }
         }
         
       //태그 인서트
 		String[] strarr = f.getfContent().split(" |\\n");
 		ArrayList<Tag> taglist = new ArrayList<Tag>();
 		for(int i = 0; i < strarr.length; i++) {
 			if(strarr[i].charAt(0) == '#') {
 				Tag t = new Tag(f.getfNo(),strarr[i]);
 				taglist.add(t);
 			}
 		}
 		System.out.println("태그리스트"+taglist);
 	
 		if(!taglist.isEmpty()) {
 			int resultTag = fService.insertTag(taglist);
// 			System.out.println(resultTag); // 성공해도 -1나옴 왜...
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
         return "redirect:home.do?userId=" + mem.getUserId();
      }else {
         return "../common/errorPage";
      }
   }
   
   @RequestMapping("pUpdateView.do")
   public ModelAndView postUpdateView(ModelAndView mv, int fNo, ArrayList<GroupName> gn, HttpSession session) {
      Member mem = (Member)session.getAttribute("loginUser");
      // 가입한 그룹(Select Tag)
      gn = fService.selectGroupMemberId(mem.getUserId());
      
      // fNo를 가지고 해당하는 피드 정보 + 사진 정보 가져오기 
      Feed f = fService.selectUpdateFeed(fNo);
      
      System.out.println("view : " + f.getfNo());
      System.out.println("photo : " + f.getPhotoList());
      
      mv.addObject("gn", gn);
      mv.addObject("f", f);
      mv.addObject("pCount", f.getPhotoList().size());
      mv.setViewName("feed/PostUpdateForm");
      return mv;
   }
   
   @ResponseBody
   @RequestMapping(value="getPhotoList.do", produces="application/json; charset=utf-8")
   public String getPhotoList(int fNo) {
      
      Feed f = fService.selectUpdateFeed(fNo);
      
      Gson gson = new Gson();
      String photoList = gson.toJson(f);
      return photoList;
   }
   
   @RequestMapping("pUpdate.do")
   public ModelAndView postUpdate(ModelAndView mv, Feed f, Photo p, GroupName gn,
                           HttpSession session, MultipartHttpServletRequest multi) {
      System.out.println("사진정보 : " + p);
      int result = fService.updatePost(f);
      System.out.println(f.getfNo());
      System.out.println(result);
      
      //태그 인서트
		String[] strarr = f.getfContent().split(" |\\n");
		ArrayList<Tag> taglist = new ArrayList<Tag>();
		for(int i = 0; i < strarr.length; i++) {
			if(strarr[i].charAt(0) == '#') {
				Tag t = new Tag(f.getfNo(),strarr[i]);
				taglist.add(t);
			}
		}
	
		if(!taglist.isEmpty()) {
			int resultTag = fService.insertTag(taglist);
			System.out.println("인서트 태그"+resultTag);
		}
    		
      Member mem = (Member)session.getAttribute("loginUser");
      
      // 파일 업로드 부분
      
      List<MultipartFile> fileList = multi.getFiles("reloadFile");
      String root = multi.getSession().getServletContext().getRealPath("resources");
      String savePath = root + "/pUploadFiles";
      File folder = new File(savePath);   // 저장 폴더

      // insert -> , insert, update 
//      for(int i=0; i<fileList.size(); i++) {
//         for(int j=0; j<f.getPhotoList().size(); j++) {
//            if(!fileList.get(i).getOriginalFilename().equals(fileList.get(j).getOriginalFilename())) {
//            
//            }
//         }
//      }
//      
      for(MultipartFile mf : fileList) {
         String originalFileName = mf.getOriginalFilename(); // 원본 파일명
         long fileSize = mf.getSize();      // 파일 사이즈
         
         SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
         //                  [      20200929191422.                                 ]
         int rdv = (int)(Math.random()*1000);
         String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + rdv + "."
               //                  [      20200929191422 + 랜덤값.png                              ]
                                + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
         
         String saveFile = savePath + "/" + renameFileName;
         
         if(!mf.isEmpty() && mf.getOriginalFilename() != "") {
            
            if(p.getChangeName() != null) {
               deleteFile(p.getChangeName(), multi);
            }
            
            // 서버에 업로드 진행하기
            if(renameFileName != null) {   // 파일이 잘 저장된 경우
               p.setOriginName(mf.getOriginalFilename());
               p.setChangeName(renameFileName);
            }
            
         }
         
         try {
            p.setfNo(f.getfNo());
            System.out.println("넘길 때 : " + fService.updatePhoto(p));
            mf.transferTo(new File(saveFile));
         }catch(IOException e) {
            e.printStackTrace();
         }
         
         
         int photo = fService.updatePhoto(p);
         System.out.println("업데이트 : " + originalFileName);
      }
      
      // 업로드 끝
      
      
      if(result > 0) {
         mv.addObject("fNo", f.getfNo()).setViewName("redirect:home.do?userId=" + mem.getUserId());
      }else {
         mv.addObject("msg", "수정 실패!").setViewName("common/errorPage");
      }
      
      return mv;
   }
   
	@RequestMapping("pDelete.do")
	public String postDelete(int fNo, Photo p, HttpSession session, HttpServletRequest request) {
		Feed f = fService.selectUpdateFeed(fNo);
		Member mem = (Member)session.getAttribute("loginUser");
		System.out.println("f : " + fService.selectUpdateFeed(fNo));
		System.out.println("p : " + p);
		
		//태그 있으면 삭제 
		int tagCnt = fService.selectTag(fNo);
		if(tagCnt > 0) {
			int tag = fService.deleteTag(fNo);
		}
	  
		
		if(f.getPhotoList() != null) {	// 첨부파일이 있으면
			deleteFile(p.getChangeName(), request);	// 첨부파일 삭제
		}
		int result = fService.deletePost(fNo);
		
		if(result > 0) {
			return "redirect:home.do?userId=" + mem.getUserId();
		}else {
			return "common/errorPage";
		}
	}
   
   	public void deleteFile(String fileName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\pUploadFiles";
		File f = new File(savePath + "\\"+ fileName);
		  
		System.out.println("fileName : " + fileName);
		  
		if(f.exists()) {
		   f.delete();
		}
   	}
	
	@ResponseBody
	@RequestMapping("addReply.do")
	public String addReply(Reply r, HttpSession session, int rfNo) {
		Member mem = (Member)session.getAttribute("loginUser");
		r.setrWriterImg(mem.getmRenameImage());
		System.out.println("Reply Check : " + r);
		System.out.println("rfNo" + rfNo);
		
		r.setfNo(rfNo);
		r.setmNo(mem.getmNo());
		
		int result = fService.insertReply(r);
		
		System.out.println("reply_fNo : " + r.getfNo());
		System.out.println("reply_rNo : " + r.getrNo());
		System.out.println("reply_rWriterImg : " + r.getrWriterImg());
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping("editReply.do")
	public String editReply(Reply r, HttpSession session) {
		Member mem = (Member)session.getAttribute("loginUser");
		System.out.println("수정 Reply Check : " + r);
		
		r.setmNo(mem.getmNo());
		
		int result = fService.updateReply(r);
		
		System.out.println("수정 reply_rNo : " + r.getrNo());
		System.out.println("수정 reply_mNo : " + r.getmNo());
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping("deleteReply.do")
	public String deleteReply(Reply r, int rNo, HttpSession session) {
		Member mem = (Member)session.getAttribute("loginUser");
		System.out.println("삭제 Reply Check : " + r);
		
		r.setrNo(rNo);
		r.setmNo(mem.getmNo());
		
		int result = fService.deleteReply(rNo);
		
		System.out.println("삭제 reply_rNo : " + r.getrNo());
		System.out.println("삭제 rNo : " + rNo);
		System.out.println("삭제 reply_mNo : " + r.getmNo());
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping("shareFeed.do")
	public int shareFeed(int fNo, int mNo, HttpServletRequest request) {
		ShareFeed sf = new ShareFeed();
		
		sf.setSf_no(fNo);
		sf.setSm_no(mNo);
		int result = fService.insertShare(sf);
		
		if( result > 0) {
			return result;
		}else {
			return 0;
		}
	}
	
	//검색 팝업
		@ResponseBody
		@RequestMapping(value = "feedPop.do",produces="application/json;charset=utf-8")
		public String popFeed(int fno) {
			Feed f = new Feed();
			f = fService.popFeed(fno);
			JSONObject job = new JSONObject();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
			JSONArray jarr = new JSONArray();
			if(f.getPhotoList().size() >-1) {
			for(int i =0; i < f.getPhotoList().size(); i++) {
				jarr.add(i, f.getPhotoList().get(i).getChangeName());
				}
			}
			if(f != null) {
				System.out.println(f);
				job.put("mno", f.getmNo());
				job.put("mImage", f.getmImage());
				job.put("fno", f.getfNo());
				job.put("plist", jarr);
				job.put("fcontent", f.getfContent());
				job.put("fwriter", f.getfWriter());
				job.put("fcreate_date", sdf.format(f.getfCreateDate()) );
				job.put("fmodify_date", sdf.format(f.getfModifyDate()) );
				return job.toJSONString();
			}else {
				job.put("msg","검색되는 게시글이 없습니다");
				return job.toJSONString();
			}
		}

      
      @RequestMapping("selectStorage.do")
      public void selectStorage(int mNo, HttpServletResponse response) throws IOException {
    	  System.out.println(mNo);
    	  response.setContentType("application/json; charset=UTF-8");
    	  ArrayList<StorageBox> sblist = myService.selectStorageBoxInfo(mNo);
    	  System.out.println(sblist);
    	  JSONObject job = null;
    	  JSONArray jArr = new JSONArray();
    	  
    	  for( StorageBox sb : sblist) {
    		  System.out.println(sb.getSbName());
    		  job = new JSONObject();
    		  job.put("sbName", sb.getSbName());
    		  job.put("sbNo",sb.getSbNo());
    		  jArr.add(job);
    	  }
    	  
    	  PrintWriter out = response.getWriter();
    	  out.print(jArr);
      }
      
      @ResponseBody
      @RequestMapping("insertStorage.do")
      public int insertStorage(int fNo, int mNo, int sbNo, String sbName, StorageBox sb, HttpServletRequest request) {
    	  
    	  sb.setfNos(fNo);
    	  sb.setmNo(mNo);
    	  sb.setSbNo(sbNo);
    	  sb.setSbName(sbName);
    	  System.out.println(sb);
    	  
    	  int result = fService.insertStorage(sb);
    	  System.out.println(result);
    	  //if(result > 0) {
    		  return result;
    	 //}else {
    	//	  return 0;
    	//  }
      }
      
}