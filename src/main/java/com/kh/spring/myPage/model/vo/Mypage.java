package com.kh.spring.myPage.model.vo;

import java.sql.Date;

public class Mypage {
	
	private int mNo;
	private String userId;
	private String mImage;
	private String mIntro;
	private String interestes;
	private int follows;
	private int followers;
	private int fNo;
	private String fContent;
	private String fFile;
	private int sbNo;	// 보관함번호
	private String sbName;	// 보관함명
	private int gNo;
	private String gName;
	private String gImage;
	private String gRenameProfile;
	private Date gJoinDate;
	private String gCategory;
	public Mypage() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public Mypage(int mNo, String userId, String mImage, String mIntro, String interestes, int follows, int followers,
			int fNo, String fContent, String fFile, int sbNo, String sbName, int gNo, String gName, String gImage,
			String gRenameProfile, Date gJoinDate, String gCategory) {
		super();
		this.mNo = mNo;
		this.userId = userId;
		this.mImage = mImage;
		this.mIntro = mIntro;
		this.interestes = interestes;
		this.follows = follows;
		this.followers = followers;
		this.fNo = fNo;
		this.fContent = fContent;
		this.fFile = fFile;
		this.sbNo = sbNo;
		this.sbName = sbName;
		this.gNo = gNo;
		this.gName = gName;
		this.gImage = gImage;
		this.gRenameProfile = gRenameProfile;
		this.gJoinDate = gJoinDate;
		this.gCategory = gCategory;
	}



	public int getmNo() {
		return mNo;
	}
	public void setmNo(int mNo) {
		this.mNo = mNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getmImage() {
		return mImage;
	}
	public void setmImage(String mImage) {
		this.mImage = mImage;
	}
	public String getmIntro() {
		return mIntro;
	}
	public void setmIntro(String mIntro) {
		this.mIntro = mIntro;
	}
	public String getInterestes() {
		return interestes;
	}
	public void setInterestes(String interestes) {
		this.interestes = interestes;
	}
	public int getFollows() {
		return follows;
	}
	public void setFollows(int follows) {
		this.follows = follows;
	}
	public int getFollowers() {
		return followers;
	}
	public void setFollowers(int followers) {
		this.followers = followers;
	}
	public int getfNo() {
		return fNo;
	}
	public void setfNo(int fNo) {
		this.fNo = fNo;
	}
	public String getfContent() {
		return fContent;
	}
	public void setfContent(String fContent) {
		this.fContent = fContent;
	}
	public String getfFile() {
		return fFile;
	}
	public void setfFile(String fFile) {
		this.fFile = fFile;
	}
	public String getSbName() {
		return sbName;
	}
	public void setSbName(String sbName) {
		this.sbName = sbName;
	}
	public int getgNo() {
		return gNo;
	}
	public void setgNo(int gNo) {
		this.gNo = gNo;
	}
	public String getgName() {
		return gName;
	}
	public void setgName(String gName) {
		this.gName = gName;
	}
	public String getgImage() {
		return gImage;
	}
	public void setgImage(String gImage) {
		this.gImage = gImage;
	}
	public Date getgJoinDate() {
		return gJoinDate;
	}
	public void setgJoinDate(Date gJoinDate) {
		this.gJoinDate = gJoinDate;
	}
	public String getgCategory() {
		return gCategory;
	}
	public void setgCategory(String gCategory) {
		this.gCategory = gCategory;
	}
	
	public int getSbNo() {
		return sbNo;
	}

	public void setSbNo(int sbNo) {
		this.sbNo = sbNo;
	}



	public String getgRenameProfile() {
		return gRenameProfile;
	}



	public void setgRenameProfile(String gRenameProfile) {
		this.gRenameProfile = gRenameProfile;
	}



	@Override
	public String toString() {
		return "Mypage [mNo=" + mNo + ", userId=" + userId + ", mImage=" + mImage + ", mIntro=" + mIntro
				+ ", interestes=" + interestes + ", follows=" + follows + ", followers=" + followers + ", fNo=" + fNo
				+ ", fContent=" + fContent + ", fFile=" + fFile + ", sbNo=" + sbNo + ", sbName=" + sbName + ", gNo="
				+ gNo + ", gName=" + gName + ", gImage=" + gImage + ", gRenameProfile=" + gRenameProfile
				+ ", gJoinDate=" + gJoinDate + ", gCategory=" + gCategory + "]";
	}

	

	
	
	

}

