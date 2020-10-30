package com.kh.spring.notification.model.vo;

import java.io.Serializable;

public class PushAlram implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5866047029454315233L;
	
	private int pNo;
	private String toId;
	private String fromId;
	private String type;
	private int typeNo;
	
	
	public PushAlram() {
		super();
	}
	public PushAlram(int pNo, String toId, String fromId, String type, int typeNo) {
		super();
		this.pNo = pNo;
		this.toId = toId;
		this.fromId = fromId;
		this.type = type;
		this.typeNo = typeNo;
	}
	public PushAlram(String toId, String fromId, String type, int typeNo) {
		super();
		this.toId = toId;
		this.fromId = fromId;
		this.type = type;
		this.typeNo = typeNo;
	}
	
	
	public int getpNo() {
		return pNo;
	}
	public void setaNo(int pNo) {
		this.pNo = pNo;
	}
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(int typeNo) {
		this.typeNo = typeNo;
	}
	@Override
	public String toString() {
		return "PushAlram [toId=" + toId + ", fromId=" + fromId + ", type=" + type + ", typeNo=" + typeNo + "]";
	}
	
	
	
}
