package com.kh.spring.feed.model.vo;

import java.io.Serializable;

public class Photo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9044594596631728107L;
	
	private int fNo;
	private String originName;
	private String changeName;

	public Photo() {
		super();
	}

	public Photo(int fNo, String originName, String changeName) {
		super();
		this.fNo = fNo;
		this.originName = originName;
		this.changeName = changeName;
	}

	public int getfNo() {
		return fNo;
	}

	public void setfNo(int fNo) {
		this.fNo = fNo;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	@Override
	public String toString() {
		return "Photo [fNo=" + fNo + ", originName=" + originName + ", changeName=" + changeName + "]";
	}

}
