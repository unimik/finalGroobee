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
	public Declaration() {
		super();
	}
	public Declaration(int dNO, String dDiv, String dType, String dContent, String dComplete, Date dCompleteDate,
			int mNo, Date dReportDate) {
		super();
		this.dNO = dNO;
		this.dDiv = dDiv;
		this.dType = dType;
		this.dContent = dContent;
		this.dComplete = dComplete;
		this.dCompleteDate = dCompleteDate;
		this.mNo = mNo;
		this.dReportDate = dReportDate;
	}
	public Declaration(String dDiv, String dType, String dContent, int mNo) {
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
	@Override
	public String toString() {
		return "Declaration [dNO=" + dNO + ", dDiv=" + dDiv + ", dType=" + dType + ", dContent=" + dContent
				+ ", dComplete=" + dComplete + ", dCompleteDate=" + dCompleteDate + ", mNo=" + mNo + "]";
	}
	
	
}
