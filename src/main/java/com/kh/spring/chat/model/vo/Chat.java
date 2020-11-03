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
	private int gNo;
	private String gImage;
	private String gReImage;
	private String gName;
	private String fromId;
	private String toId;
	private String joinId;
	private String cContent;
	private Date chatDate;
	private String cRead;

	public Chat() {
		super();
	}

	public Chat(int cNo, int crNo, int jcNo, int crMax, int gNo, String gImage, String gReImage, String gName,
			String fromId, String toId, String joinId, String cContent, Date chatDate, String cRead) {
		super();
		this.cNo = cNo;
		this.crNo = crNo;
		this.jcNo = jcNo;
		this.crMax = crMax;
		this.gNo = gNo;
		this.gImage = gImage;
		this.gReImage = gReImage;
		this.gName = gName;
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

	public int getgNo() {
		return gNo;
	}

	public void setgNo(int gNo) {
		this.gNo = gNo;
	}

	public String getgImage() {
		return gImage;
	}

	public void setgImage(String gImage) {
		this.gImage = gImage;
	}

	public String getgReImage() {
		return gReImage;
	}

	public void setgReImage(String gReImage) {
		this.gReImage = gReImage;
	}

	public String getgName() {
		return gName;
	}

	public void setgName(String gName) {
		this.gName = gName;
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
		return "Chat [cNo=" + cNo + ", crNo=" + crNo + ", jcNo=" + jcNo + ", crMax=" + crMax + ", gNo=" + gNo
				+ ", gImage=" + gImage + ", gReImage=" + gReImage + ", gName=" + gName + ", fromId=" + fromId
				+ ", toId=" + toId + ", joinId=" + joinId + ", cContent=" + cContent + ", chatDate=" + chatDate
				+ ", cRead=" + cRead + "]";
	}
}
