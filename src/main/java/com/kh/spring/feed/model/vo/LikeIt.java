package com.kh.spring.feed.model.vo;

import java.io.Serializable;

public class LikeIt implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1240614260103452173L;


	private int fNo;
	private int lCount;
	private String mNo;
	
	public LikeIt(int fNo, int lCount, String mNo) {
		super();
		this.fNo = fNo;
		this.lCount = lCount;
		this.mNo = mNo;
	}
	
	public LikeIt(int fNo, String mNo) {
		super();
		this.fNo = fNo;
		this.mNo = mNo;
	}

	public LikeIt(int fNo, int lCount) {
		super();
		this.fNo = fNo;
		this.lCount = lCount;
	}

	public LikeIt() {
		super();
	}
	public int getfNo() {
		return fNo;
	}
	public void setfNo(int fNo) {
		this.fNo = fNo;
	}
	public int getlCount() {
		return lCount;
	}
	public void setlCount(int lCount) {
		this.lCount = lCount;
	}
	public String getmNo() {
		return mNo;
	}
	public void setmNo(String mNo) {
		this.mNo = mNo;
	}
	
	
	
	
	
	

}
