package com.kh.spring.feed.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class Feed {

	private int fNo;
	private int mNo;
	private String fContent;
	private String fWriter;
	private Date fCreateDate;
	private Date fModifyDate;
	private String fStatus;
	private String fLocation;
	private String fOpenScope;
	private String fLikeSet;
	private String fReplySet;
	private String fShareSet;
	private int fLikeCnt;
	private int fReplyCnt;
	private int gNo;
	
	private ArrayList<Reply> replyList;
	private ArrayList<Photo> photoList;

	public Feed() {
	}

	public Feed(int fNo, int mNo, String fContent, String fWriter, Date fCreateDate, Date fModifyDate, String fStatus,
			String fLocation, String fOpenScope, String fLikeSet, String fReplySet, String fShareSet, int fLikeCnt,
			int fReplyCnt, int gNo) {
		super();
		this.fNo = fNo;
		this.mNo = mNo;
		this.fContent = fContent;
		this.fWriter = fWriter;
		this.fCreateDate = fCreateDate;
		this.fModifyDate = fModifyDate;
		this.fStatus = fStatus;
		this.fLocation = fLocation;
		this.fOpenScope = fOpenScope;
		this.fLikeSet = fLikeSet;
		this.fReplySet = fReplySet;
		this.fShareSet = fShareSet;
		this.fLikeCnt = fLikeCnt;
		this.fReplyCnt = fReplyCnt;
		this.gNo = gNo;
	}

	public Feed(int fNo, int mNo, String fContent, String fWriter, Date fCreateDate, Date fModifyDate, String fStatus,
			String fLocation, String fOpenScope, String fLikeSet, String fReplySet, String fShareSet, int fLikeCnt,
			int fReplyCnt, int gNo, ArrayList<Reply> replyList, ArrayList<Photo> photoList) {
		super();
		this.fNo = fNo;
		this.mNo = mNo;
		this.fContent = fContent;
		this.fWriter = fWriter;
		this.fCreateDate = fCreateDate;
		this.fModifyDate = fModifyDate;
		this.fStatus = fStatus;
		this.fLocation = fLocation;
		this.fOpenScope = fOpenScope;
		this.fLikeSet = fLikeSet;
		this.fReplySet = fReplySet;
		this.fShareSet = fShareSet;
		this.fLikeCnt = fLikeCnt;
		this.fReplyCnt = fReplyCnt;
		this.gNo = gNo;
		this.replyList = replyList;
		this.photoList = photoList;
	}

	public int getfNo() {
		return fNo;
	}

	public void setfNo(int fNo) {
		this.fNo = fNo;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public String getfContent() {
		return fContent;
	}

	public void setfContent(String fContent) {
		this.fContent = fContent;
	}

	public String getfWriter() {
		return fWriter;
	}

	public void setfWriter(String fWriter) {
		this.fWriter = fWriter;
	}

	public Date getfCreateDate() {
		return fCreateDate;
	}

	public void setfCreateDate(Date fCreateDate) {
		this.fCreateDate = fCreateDate;
	}

	public Date getfModifyDate() {
		return fModifyDate;
	}

	public void setfModifyDate(Date fModifyDate) {
		this.fModifyDate = fModifyDate;
	}

	public String getfStatus() {
		return fStatus;
	}

	public void setfStatus(String fStatus) {
		this.fStatus = fStatus;
	}

	public String getfLocation() {
		return fLocation;
	}

	public void setfLocation(String fLocation) {
		this.fLocation = fLocation;
	}

	public String getfOpenScope() {
		return fOpenScope;
	}

	public void setfOpenScope(String fOpenScope) {
		this.fOpenScope = fOpenScope;
	}

	public String getfLikeSet() {
		return fLikeSet;
	}

	public void setfLikeSet(String fLikeSet) {
		this.fLikeSet = fLikeSet;
	}

	public String getfReplySet() {
		return fReplySet;
	}

	public void setfReplySet(String fReplySet) {
		this.fReplySet = fReplySet;
	}

	public String getfShareSet() {
		return fShareSet;
	}

	public void setfShareSet(String fShareSet) {
		this.fShareSet = fShareSet;
	}

	public int getfLikeCnt() {
		return fLikeCnt;
	}

	public void setfLikeCnt(int fLikeCnt) {
		this.fLikeCnt = fLikeCnt;
	}

	public int getfReplyCnt() {
		return fReplyCnt;
	}

	public void setfReplyCnt(int fReplyCnt) {
		this.fReplyCnt = fReplyCnt;
	}
	
	public ArrayList<Reply> getReplyList() {
		return replyList;
	}

	public void setReplyList(ArrayList<Reply> replyList) {
		this.replyList = replyList;
	}
			
	public int getgNo() {
		return gNo;
	}

	public void setgNo(int gNo) {
		this.gNo = gNo;
	}

	public ArrayList<Photo> getPhotoList() {
		return photoList;
	}

	public void setPhotoList(ArrayList<Photo> photoList) {
		this.photoList = photoList;
	}

	@Override
	public String toString() {
		return "Feed [fNo=" + fNo + ", mNo=" + mNo + ", fContent=" + fContent + ", fWriter=" + fWriter
				+ ", fCreateDate=" + fCreateDate + ", fModifyDate=" + fModifyDate + ", fStatus=" + fStatus
				+ ", fLocation=" + fLocation + ", fOpenScope=" + fOpenScope + ", fLikeSet=" + fLikeSet + ", fReplySet="
				+ fReplySet + ", fShareSet=" + fShareSet + ", fLikeCnt=" + fLikeCnt + ", fReplyCnt=" + fReplyCnt
				+ ", gNo=" + gNo + ", replyList=" + replyList + ", photoList=" + photoList + "]";
	}

}
