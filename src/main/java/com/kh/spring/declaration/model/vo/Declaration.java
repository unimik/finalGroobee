package com.kh.spring.declaration.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Declaration implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1013467122811693290L;

	
	private int dNO;
	private String dDiv;
	private String dType;
	private String dContent;
	private String dComplete;
	private Date dCompleteDate;
	private int mNo;
	private Date dReportDate;
	private int dNumber; // 그룹번호 or 회원번호 or 게시글번호 or 댓글번호
	public Declaration() {
		super();
	}
	public Declaration(int dNO, String dDiv, String dType, String dContent, String dComplete, Date dCompleteDate,
			int mNo, Date dReportDate, int dNumber) {
		super();
		this.dNO = dNO;
		this.dDiv = dDiv;
		this.dType = dType;
		this.dContent = dContent;
		this.dComplete = dComplete;
		this.dCompleteDate = dCompleteDate;
		this.mNo = mNo;
		this.dReportDate = dReportDate;
		this.dNumber = dNumber;
	}
	public Declaration(String dDiv, String dType, String dContent, int mNo) { // 신고 대상의 번호(그룹 번호, 게시글번호, 댓글번호, 회원번호) 추가해야함
		super();
		this.dDiv = dDiv;
		this.dType = dType;
		this.dContent = dContent;
		this.mNo = mNo;
	}
	public int getdNO() {
		return dNO;
	}
	public void setdNO(int dNO) {
		this.dNO = dNO;
	}
	public String getdDiv() {
		return dDiv;
	}
	public void setdDiv(String dDiv) {
		this.dDiv = dDiv;
	}
	public String getdType() {
		return dType;
	}
	public void setdType(String dType) {
		this.dType = dType;
	}
	public String getdContent() {
		return dContent;
	}
	public void setdContent(String dContent) {
		this.dContent = dContent;
	}
	public String getdComplete() {
		return dComplete;
	}
	public void setdComplete(String dComplete) {
		this.dComplete = dComplete;
	}
	public Date getdCompleteDate() {
		return dCompleteDate;
	}
	public void setdCompleteDate(Date dCompleteDate) {
		this.dCompleteDate = dCompleteDate;
	}
	public int getmNo() {
		return mNo;
	}
	public void setmNo(int mNo) {
		this.mNo = mNo;
	}
	
	public Date getdReportDate() {
		return dReportDate;
	}
	public void setdReportDate(Date dReportDate) {
		this.dReportDate = dReportDate;
	}
	
	public int getdNumber() {
		return dNumber;
	}
	public void setdNumber(int dNumber) {
		this.dNumber = dNumber;
	}
	
	@Override
	public String toString() {
		return "Declaration [dNO=" + dNO + ", dDiv=" + dDiv + ", dType=" + dType + ", dContent=" + dContent
				+ ", dComplete=" + dComplete + ", dCompleteDate=" + dCompleteDate + ", mNo=" + mNo + ", dNumber=" + dNumber + "]";
	}

	
	
}
