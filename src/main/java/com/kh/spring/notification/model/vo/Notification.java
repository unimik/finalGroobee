package com.kh.spring.notification.model.vo;

import java.io.Serializable;

public class Notification implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9045035082748256499L;

	private int mNo;
	private String alramContent;
	public Notification(int mNo, String alramContent) {
		super();
		this.mNo = mNo;
		this.alramContent = alramContent;
	}
	public Notification() {
		super();
	}
	public int getmNo() {
		return mNo;
	}
	public void setmNo(int mNo) {
		this.mNo = mNo;
	}
	public String getAlramContent() {
		return alramContent;
	}
	public void setAlramContent(String alramContent) {
		this.alramContent = alramContent;
	}
	@Override
	public String toString() {
		return "Notification [mNo=" + mNo + ", alramContent=" + alramContent + "]";
	}
	
	
	
}
