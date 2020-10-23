package com.kh.spring.chat.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Chat implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4405462894760960798L;

	private int cNo;
	private int crNo;
	private int jcNo;
	private int crMax;
	private String fromId;
	private String toId;
	private String joinId;
	private String cContent;
	private Date chatDate;
	private String cRead;

	public Chat() {
		super();
	}

	public Chat(int cNo, int crNo, int jcNo, int crMax, String fromId, String toId, String joinId, String cContent,
			Date chatDate, String cRead) {
		super();
		this.cNo = cNo;
		this.crNo = crNo;
		this.jcNo = jcNo;
		this.crMax = crMax;
		this.fromId = fromId;
		this.toId = toId;
		this.joinId = joinId;
		this.cContent = cContent;
		this.chatDate = chatDate;
		this.cRead = cRead;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
	}

	public int getCrNo() {
		return crNo;
	}

	public void setCrNo(int crNo) {
		this.crNo = crNo;
	}

	public int getJcNo() {
		return jcNo;
	}

	public void setJcNo(int jcNo) {
		this.jcNo = jcNo;
	}

	public int getCrMax() {
		return crMax;
	}

	public void setCrMax(int crMax) {
		this.crMax = crMax;
	}

	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public String getToId() {
		return toId;
	}

	public void setToId(String toId) {
		this.toId = toId;
	}

	public String getJoinId() {
		return joinId;
	}

	public void setJoinId(String joinId) {
		this.joinId = joinId;
	}

	public String getcContent() {
		return cContent;
	}

	public void setcContent(String cContent) {
		this.cContent = cContent;
	}

	public Date getChatDate() {
		return chatDate;
	}

	public void setChatDate(Date chatDate) {
		this.chatDate = chatDate;
	}

	public String getcRead() {
		return cRead;
	}

	public void setcRead(String cRead) {
		this.cRead = cRead;
	}

	@Override
	public String toString() {
		return "Chat [cNo=" + cNo + ", crNo=" + crNo + ", jcNo=" + jcNo + ", crMax=" + crMax + ", fromId=" + fromId
				+ ", toId=" + toId + ", joinId=" + joinId + ", cContent=" + cContent + ", chatDate=" + chatDate
				+ ", cRead=" + cRead + "]";
	}
}
