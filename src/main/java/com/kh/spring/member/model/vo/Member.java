package com.kh.spring.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

import org.springframework.stereotype.Component;

public class Member implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1167064274727891479L;
	
	private int mNo;
	private String userId;
	private String userName;
	private String userPwd;
	private String email;
	private String interestes;
	private int gNo;
	private String mStatus;
	private String mImage;
	private String mRenameImage;
	private Date cDate;
	private String mLevel;
	private String mIntro;

	public Member() {
		super();
	}


	public Member(int mNo, String userId, String userName, String userPwd, String email, String interestes, int gNo,
			String mStatus, String mImage, String mRenameImage, Date cDate, String mLevel, String mIntro) {
		super();
		this.mNo = mNo;
		this.userId = userId;
		this.userName = userName;
		this.userPwd = userPwd;
		this.email = email;
		this.interestes = interestes;
		this.gNo = gNo;
		this.mStatus = mStatus;
		this.mImage = mImage;
		this.mRenameImage = mRenameImage;
		this.cDate = cDate;
		this.mLevel = mLevel;
		this.mIntro = mIntro;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getInterestes() {
		return interestes;
	}

	public void setInterestes(String interestes) {
		this.interestes = interestes;
	}

	public int getgNo() {
		return gNo;
	}

	public void setgNo(int gNo) {
		this.gNo = gNo;
	}

	public String getmStatus() {
		return mStatus;
	}

	public void setmStatus(String mStatus) {
		this.mStatus = mStatus;
	}

	public String getmImage() {
		return mImage;
	}

	public void setmImage(String mImage) {
		this.mImage = mImage;
	}

	public String getmRenameImage() {
		return mRenameImage;
	}

	public void setmRenameImage(String mRenameImage) {
		this.mRenameImage = mRenameImage;
	}

	public Date getcDate() {
		return cDate;
	}

	public void setcDate(Date cDate) {
		this.cDate = cDate;
	}

	public String getmLevel() {
		return mLevel;
	}

	public void setmLevel(String mLevel) {
		this.mLevel = mLevel;
	}
	
	public String getmIntro() {
		return mIntro;
	}

	public void setmIntro(String mIntro) {
		this.mIntro = mIntro;
	}

	@Override
	public String toString() {
		return "Member [mNo=" + mNo + ", userId=" + userId + ", userName=" + userName + ", userPwd=" + userPwd
				+ ", email=" + email + ", interestes=" + interestes + ", gNo=" + gNo + ", mStatus=" + mStatus
				+ ", mImage=" + mImage + ", mRenameImage=" + mRenameImage + ", cDate=" + cDate + ", mLevel=" + mLevel
				+ ", mIntro=" + mIntro + "]";
	}


	
}
