package com.kh.spring.myPage.model.vo;

public class StorageBox {
	private  int sbNo;
	private int mNo;
	private String sbName;
	private int fNos;

	public StorageBox() {
	}

	public StorageBox(int sbNo, int mNo, String sbName, int fNos) {
		super();
		this.sbNo = sbNo;
		this.mNo = mNo;
		this.sbName = sbName;
		this.fNos = fNos;
	}

	public int getSbNo() {
		return sbNo;
	}

	public void setSbNo(int sbNo) {
		this.sbNo = sbNo;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public String getSbName() {
		return sbName;
	}

	public void setSbName(String sbName) {
		this.sbName = sbName;
	}

	public int getfNos() {
		return fNos;
	}

	public void setfNos(int fNos) {
		this.fNos = fNos;
	}

	@Override
	public String toString() {
		return "StorageBox [sbNo=" + sbNo + ", mNo=" + mNo + ", sbName=" + sbName + ", fNos=" + fNos + "]";
	}
	
	

	
	
	
}
