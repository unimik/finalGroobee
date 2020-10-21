package com.kh.spring.member.model.vo;

import java.io.Serializable;

public class Follow implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8158831402815486766L;
	
	private int mNo;
	private int follows;

	public Follow() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Follow(int mNo, int follows) {
		super();
		this.mNo = mNo;
		this.follows = follows;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public int getFollows() {
		return follows;
	}

	public void setFollows(int follows) {
		this.follows = follows;

	}
	@Override
	public String toString() {
		return "Follow [mNo=" + mNo + ", follows=" + follows + "]";
	}
	
}
