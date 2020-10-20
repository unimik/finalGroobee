package com.kh.spring.group.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class GroupMember implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -945082179979937540L;
	
	private int gNo;
	private String gmId;
	private String gmStatus;
	private String gmLevel;
	private String a1;
	private String a2;
	private String a3;
	private Date gJoinDate;
	
	public GroupMember() {
		super();
	}

	public GroupMember(int gNo, String gmId, String gmStatus, String gmLevel, String a1, String a2, String a3,
			Date gJoinDate) {
		super();
		this.gNo = gNo;
		this.gmId = gmId;
		this.gmStatus = gmStatus;
		this.gmLevel = gmLevel;
		this.a1 = a1;
		this.a2 = a2;
		this.a3 = a3;
		this.gJoinDate = gJoinDate;
	}

	public int getgNo() {
		return gNo;
	}

	public void setgNo(int gNo) {
		this.gNo = gNo;
	}

	public String getGmId() {
		return gmId;
	}

	public void setGmId(String gmId) {
		this.gmId = gmId;
	}

	public String getGmStatus() {
		return gmStatus;
	}

	public void setGmStatus(String gmStatus) {
		this.gmStatus = gmStatus;
	}

	public String getGmLevel() {
		return gmLevel;
	}

	public void setGmLevel(String gmLevel) {
		this.gmLevel = gmLevel;
	}

	public String getA1() {
		return a1;
	}

	public void setA1(String a1) {
		this.a1 = a1;
	}

	public String getA2() {
		return a2;
	}

	public void setA2(String a2) {
		this.a2 = a2;
	}

	public String getA3() {
		return a3;
	}

	public void setA3(String a3) {
		this.a3 = a3;
	}

	public Date getgJoinDate() {
		return gJoinDate;
	}

	public void setgJoinDate(Date gJoinDate) {
		this.gJoinDate = gJoinDate;
	}

	@Override
	public String toString() {
		return "GroupMember [gNo=" + gNo + ", gmId=" + gmId + ", gmStatus=" + gmStatus + ", gmLevel=" + gmLevel
				+ ", a1=" + a1 + ", a2=" + a2 + ", a3=" + a3 + ", gJoinDate=" + gJoinDate + "]";
	}

	
	
}
