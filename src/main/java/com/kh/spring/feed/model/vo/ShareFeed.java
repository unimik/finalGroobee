package com.kh.spring.feed.model.vo;

public class ShareFeed {
	private int sf_no;
	private int sm_no;
	private String s_status;
	
	
	public ShareFeed() {
		super();
	}

	public ShareFeed(int sf_no, int sm_no, String s_status) {
		super();
		this.sf_no = sf_no;
		this.sm_no = sm_no;
		this.s_status = s_status;
	}

	public int getSf_no() {
		return sf_no;
	}

	public void setSf_no(int sf_no) {
		this.sf_no = sf_no;
	}

	public int getSm_no() {
		return sm_no;
	}

	public void setSm_no(int sm_no) {
		this.sm_no = sm_no;
	}

	public String getS_status() {
		return s_status;
	}

	public void setS_status(String s_status) {
		this.s_status = s_status;
	}

	@Override
	public String toString() {
		return "ShareFeed [sf_no=" + sf_no + ", sm_no=" + sm_no + ", s_status=" + s_status + "]";
	}
	
	
}
