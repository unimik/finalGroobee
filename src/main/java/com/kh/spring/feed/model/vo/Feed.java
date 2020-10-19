package com.kh.spring.feed.model.vo;

import java.sql.Date;

public class Feed {

	private int fNo;
	private int mNo;
	private String fContent;
	private String fWriter;
	private String fFile;
	private String fRenameFile;
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

	public Feed() {
	}

	public Feed(int fNo, int mNo, String fContent, String fWriter, String fFile, String fRenameFile, Date fCreateDate,
			Date fModifyDate, String fStatus, String fLocation, String fOpenScope, String fLikeSet, String fReplySet,
			String fShareSet, int fLikeCnt, int fReplyCnt) {
		super();
		this.fNo = fNo;
		this.mNo = mNo;
		this.fContent = fContent;
		this.fWriter = fWriter;
		this.fFile = fFile;
		this.fRenameFile = fRenameFile;
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

	public String getfFile() {
		return fFile;
	}

	public void setfFile(String fFile) {
		this.fFile = fFile;
	}

	public String getfRenameFile() {
		return fRenameFile;
	}

	public void setfRenameFile(String fRenameFile) {
		this.fRenameFile = fRenameFile;
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

	@Override
	public String toString() {
		return "Feed [fNo=" + fNo + ", mNo=" + mNo + ", fContent=" + fContent + ", fWriter=" + fWriter + ", fFile="
				+ fFile + ", fRenameFile=" + fRenameFile + ", fCreateDate=" + fCreateDate + ", fModifyDate="
				+ fModifyDate + ", fStatus=" + fStatus + ", fLocation=" + fLocation + ", fOpenScope=" + fOpenScope
				+ ", fLikeSet=" + fLikeSet + ", fReplySet=" + fReplySet + ", fShareSet=" + fShareSet + ", fLikeCnt="
				+ fLikeCnt + ", fReplyCnt=" + fReplyCnt + "]";
	}
	
	
	
}
