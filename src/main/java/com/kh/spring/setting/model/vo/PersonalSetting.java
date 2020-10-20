package com.kh.spring.setting.model.vo;

import java.io.Serializable;

public class PersonalSetting implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8771460298301976481L;
	
	private int mNo;
	private String openStatus;
	private String pwdSaved;
	private String blockedNo;
	public PersonalSetting() {
		super();
	}
	
	
	public PersonalSetting(int mNo, String openStatus, String pwdSaved) {
		super();
		this.mNo = mNo;
		this.openStatus = openStatus;
		this.pwdSaved = pwdSaved;
	}


	public PersonalSetting(int mNo, String openStatus, String pwdSaved, String blockedNo) {
		super();
		this.mNo = mNo;
		this.openStatus = openStatus;
		this.pwdSaved = pwdSaved;
		this.blockedNo = blockedNo;
	}
	public int getmNo() {
		return mNo;
	}
	public void setmNo(int mNo) {
		this.mNo = mNo;
	}
	public String getOpenStatus() {
		return openStatus;
	}
	public void setOpenStatus(String openStatus) {
		this.openStatus = openStatus;
	}
	public String getPwdSaved() {
		return pwdSaved;
	}
	public void setPwdSaved(String pwdSaved) {
		this.pwdSaved = pwdSaved;
	}
	public String getBlockedNo() {
		return blockedNo;
	}
	public void setBlockedNo(String blockedNo) {
		this.blockedNo = blockedNo;
	}
	@Override
	public String toString() {
		return "PersonalSetting [mNo=" + mNo + ", openStatus=" + openStatus + ", pwdSaved=" + pwdSaved + ", blockedNo="
				+ blockedNo + "]";
	}

	

	
}
