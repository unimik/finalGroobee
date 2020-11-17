package com.kh.spring.feed.model.vo;

import java.io.Serializable;

public class Tag implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6473308258795551428L;
	
	private int fNo;
	private String fTag;

	public Tag() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Tag(int fNo, String fTag) {
		super();
		this.fNo = fNo;
		this.fTag = fTag;
	}

	public int getfNo() {
		return fNo;
	}

	public void setfNo(int fNo) {
		this.fNo = fNo;
	}

	public String getfTag() {
		return fTag;
	}

	public void setfTag(String fTag) {
		this.fTag = fTag;
	}

	@Override
	public String toString() {
		return "Tag [fNo=" + fNo + ", fTag=" + fTag + "]";
	}
}
