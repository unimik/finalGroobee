package com.kh.spring.group.model.vo;

import java.io.Serializable;

public class GroupName implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5470613622793414227L;
	
	private int gNo;
	private String gName;
	private String gmId;

	public GroupName() {
		super();
	}

	public GroupName(int gNo, String gName, String gmId) {
		super();
		this.gNo = gNo;
		this.gName = gName;
		this.gmId = gmId;
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

	public String getGmId() {
		return gmId;
	}

	public void setGmId(String gmId) {
		this.gmId = gmId;
	}

	@Override
	public String toString() {
		return "GroupName [gNo=" + gNo + ", gName=" + gName + ", gmId=" + gmId + "]";
	}

}
