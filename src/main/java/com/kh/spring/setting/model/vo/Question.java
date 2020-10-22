package com.kh.spring.setting.model.vo;

public class Question {

	private int qNo;
	private String qContent;
	private int mNo;
	public Question(int qNo, String qContent, int mNo) {
		super();
		this.qNo = qNo;
		this.qContent = qContent;
		this.mNo = mNo;
	}
	
	public Question(String qContent, int mNo) {
		super();
		this.qContent = qContent;
		this.mNo = mNo;
	}

	public Question() {
		super();
	}
	public int getqNo() {
		return qNo;
	}
	public void setqNo(int qNo) {
		this.qNo = qNo;
	}
	public String getqContent() {
		return qContent;
	}
	public void setqContent(String qContent) {
		this.qContent = qContent;
	}
	public int getmNo() {
		return mNo;
	}
	public void setmNo(int mNo) {
		this.mNo = mNo;
	}
	@Override
	public String toString() {
		return "Question [qNo=" + qNo + ", qContent=" + qContent + ", mNo=" + mNo + "]";
	}
	
	
}
