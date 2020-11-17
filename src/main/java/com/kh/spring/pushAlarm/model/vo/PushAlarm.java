package com.kh.spring.pushAlarm.model.vo;

import java.io.Serializable;

public class PushAlarm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5219695249531314787L;

	private int pNo;
	private String toId;
	private String fromId;
	private String type;
	private String typeNo;
	private String readYN;
	public PushAlarm() {
		super();
	}
	public PushAlarm(int pNo, String toId, String fromId, String type, String typeNo, String readYN) {
		super();
		this.pNo = pNo;
		this.toId = toId;
		this.fromId = fromId;
		this.type = type;
		this.typeNo = typeNo;
		this.readYN = readYN;
	}
	public PushAlarm( String toId, String fromId, String type, String typeNo, String readYN) {
		super();
		this.toId = toId;
		this.fromId = fromId;
		this.type = type;
		this.typeNo = typeNo;
		this.readYN = readYN;
	}
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
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
	public String getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(String typeNo) {
		this.typeNo = typeNo;
	}
	public String getReadYN() {
		return readYN;
	}
	public void setReadYN(String readYN) {
		this.readYN = readYN;
	}
	@Override
	public String toString() {
		return "PushAlarm [pNo=" + pNo + ", toId=" + toId + ", fromId=" + fromId + ", type=" + type + ", typeNo="
				+ typeNo + ", readYN=" + readYN + "]";
	}
	
	
	
}
