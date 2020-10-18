package com.kh.spring.search.model.vo;

public class RelatedSearch {
	private int rsNo;
	private String rsTag;
	private int rsCnt;
	public RelatedSearch() {
	}
	public RelatedSearch(int rsNo, String rsTag, int rsCnt) {
		super();
		this.rsNo = rsNo;
		this.rsTag = rsTag;
		this.rsCnt = rsCnt;
	}
	public int getRsNo() {
		return rsNo;
	}
	public void setRsNo(int rsNo) {
		this.rsNo = rsNo;
	}
	public String getRsTag() {
		return rsTag;
	}
	public void setRsTag(String rsTag) {
		this.rsTag = rsTag;
	}
	public int getRsCnt() {
		return rsCnt;
	}
	public void setRsCnt(int rsCnt) {
		this.rsCnt = rsCnt;
	}
	@Override
	public String toString() {
		return "RelatedSearch [rsNo=" + rsNo + ", rsTag=" + rsTag + ", rsCnt=" + rsCnt + "]";
	}

	
}
