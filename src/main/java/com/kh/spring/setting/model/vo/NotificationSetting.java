package com.kh.spring.setting.model.vo;

import java.io.Serializable;

public class NotificationSetting implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6631929424163230494L;

	

	private int mNo;
	private String aAll;
	private String aLike;
	private String aReply;
	private String aFriends;
	private String aMessage;
	public NotificationSetting() {
		super();
	}
	public NotificationSetting(int mNo, String aAll, String aLike, String aReply, String aFriends, String aMessage) {
		super();
		this.mNo = mNo;
		this.aAll = aAll;
		this.aLike = aLike;
		this.aReply = aReply;
		this.aFriends = aFriends;
		this.aMessage = aMessage;
	}
	public int getmNo() {
		return mNo;
	}
	public void setmNo(int mNo) {
		this.mNo = mNo;
	}
	public String getaAll() {
		return aAll;
	}
	public void setaAll(String aAll) {
		this.aAll = aAll;
	}
	public String getaLike() {
		return aLike;
	}
	public void setaLike(String aLike) {
		this.aLike = aLike;
	}
	public String getaReply() {
		return aReply;
	}
	public void setaReply(String aReply) {
		this.aReply = aReply;
	}
	public String getaFriends() {
		return aFriends;
	}
	public void setaFriends(String aFriends) {
		this.aFriends = aFriends;
	}
	public String getaMessage() {
		return aMessage;
	}
	public void setaMessage(String aMessage) {
		this.aMessage = aMessage;
	}
	
}
