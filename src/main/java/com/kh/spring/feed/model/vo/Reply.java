package com.kh.spring.feed.model.vo;

import java.io.Serializable;

public class Reply implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7111116973579378000L;
	
	private int rNo;
	private int mNo;
	private int fNo;
	private String rContent;
	private String rWriterImg;
	private String rWriter;
	private String rCreateDate;
	private String rModifyDate;
	private String rStatus;

	public Reply() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Reply(int rNo, int mNo, int fNo, String rContent, String rWriterImg, String rWriter, String rCreateDate,
			String rModifyDate, String rStatus) {
		super();
		this.rNo = rNo;
		this.mNo = mNo;
		this.fNo = fNo;
		this.rContent = rContent;
		this.rWriterImg = rWriterImg;
		this.rWriter = rWriter;
		this.rCreateDate = rCreateDate;
		this.rModifyDate = rModifyDate;
		this.rStatus = rStatus;
	}

	public int getrNo() {
		return rNo;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public int getfNo() {
		return fNo;
	}

	public void setfNo(int fNo) {
		this.fNo = fNo;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getrWriterImg() {
		return rWriterImg;
	}

	public void setrWriterImg(String rWriterImg) {
		this.rWriterImg = rWriterImg;
	}

	public String getrWriter() {
		return rWriter;
	}

	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}

	public String getrCreateDate() {
		return rCreateDate;
	}

	public void setrCreateDate(String rCreateDate) {
		this.rCreateDate = rCreateDate;
	}

	public String getrModifyDate() {
		return rModifyDate;
	}

	public void setrModifyDate(String rModifyDate) {
		this.rModifyDate = rModifyDate;
	}

	public String getrStatus() {
		return rStatus;
	}

	public void setrStatus(String rStatus) {
		this.rStatus = rStatus;
	}

	@Override
	public String toString() {
		return "Reply [rNo=" + rNo + ", mNo=" + mNo + ", fNo=" + fNo + ", rContent=" + rContent + ", rWriterImg="
				+ rWriterImg + ", rWriter=" + rWriter + ", rCreateDate=" + rCreateDate + ", rModifyDate=" + rModifyDate
				+ ", rStatus=" + rStatus + "]";
	}
}
