package com.kh.spring.group.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Group implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8634022983657162732L;
	
	private int gNo;
	private String gCreator;
	private String gManager;
	private String gName;
	private String gCategory;
	private int gMax;
	private Date gDate;
	private String gOpenScope;
	private String gJoinSet;
	private String gQset;
	private String q1;
	private String q2;
	private String q3;
	private String gIntro;
	private String gTag;
	private String gStatus;
	private String gNotice;
	private String gProfile;
	private String gImage;
	private String gRenameProfile;
	private String gRenameImage;
	
	public Group() {
		super();
	}

	
	public Group(int gNo, String gCreator, String gManager, String gName, String gCategory, int gMax, Date gDate,
			String gOpenScope, String gJoinSet, String gQset, String q1, String q2, String q3, String gIntro,
			String gTag, String gStatus, String gNotice, String gProfile, String gImage, String gRenameProfile,
			String gRenameImage) {
		super();
		this.gNo = gNo;
		this.gCreator = gCreator;
		this.gManager = gManager;
		this.gName = gName;
		this.gCategory = gCategory;
		this.gMax = gMax;
		this.gDate = gDate;
		this.gOpenScope = gOpenScope;
		this.gJoinSet = gJoinSet;
		this.gQset = gQset;
		this.q1 = q1;
		this.q2 = q2;
		this.q3 = q3;
		this.gIntro = gIntro;
		this.gTag = gTag;
		this.gStatus = gStatus;
		this.gNotice = gNotice;
		this.gProfile = gProfile;
		this.gImage = gImage;
		this.gRenameProfile = gRenameProfile;
		this.gRenameImage = gRenameImage;
	}



	public int getgNo() {
		return gNo;
	}


	public void setgNo(int gNo) {
		this.gNo = gNo;
	}


	public String getgCreator() {
		return gCreator;
	}


	public void setgCreator(String gCreator) {
		this.gCreator = gCreator;
	}


	public String getgManager() {
		return gManager;
	}


	public void setgManager(String gManager) {
		this.gManager = gManager;
	}


	public String getgName() {
		return gName;
	}


	public void setgName(String gName) {
		this.gName = gName;
	}


	public String getgCategory() {
		return gCategory;
	}


	public void setgCategory(String gCategory) {
		this.gCategory = gCategory;
	}


	public int getgMax() {
		return gMax;
	}


	public void setgMax(int gMax) {
		this.gMax = gMax;
	}


	public Date getgDate() {
		return gDate;
	}


	public void setgDate(Date gDate) {
		this.gDate = gDate;
	}


	public String getgOpenScope() {
		return gOpenScope;
	}


	public void setgOpenScope(String gOpenScope) {
		this.gOpenScope = gOpenScope;
	}


	public String getgJoinSet() {
		return gJoinSet;
	}


	public void setgJoinSet(String gJoinSet) {
		this.gJoinSet = gJoinSet;
	}


	public String getgQset() {
		return gQset;
	}


	public void setgQset(String gQset) {
		this.gQset = gQset;
	}


	public String getQ1() {
		return q1;
	}


	public void setQ1(String q1) {
		this.q1 = q1;
	}


	public String getQ2() {
		return q2;
	}


	public void setQ2(String q2) {
		this.q2 = q2;
	}


	public String getQ3() {
		return q3;
	}


	public void setQ3(String q3) {
		this.q3 = q3;
	}


	public String getgIntro() {
		return gIntro;
	}


	public void setgIntro(String gIntro) {
		this.gIntro = gIntro;
	}


	public String getgTag() {
		return gTag;
	}


	public void setgTag(String gTag) {
		this.gTag = gTag;
	}


	public String getgStatus() {
		return gStatus;
	}


	public void setgStatus(String gStatus) {
		this.gStatus = gStatus;
	}


	public String getgNotice() {
		return gNotice;
	}


	public void setgNotice(String gNotice) {
		this.gNotice = gNotice;
	}


	public String getgProfile() {
		return gProfile;
	}


	public void setgProfile(String gProfile) {
		this.gProfile = gProfile;
	}


	public String getgImage() {
		return gImage;
	}


	public void setgImage(String gImage) {
		this.gImage = gImage;
	}


	public String getgRenameProfile() {
		return gRenameProfile;
	}


	public void setgRenameProfile(String gRenameProfile) {
		this.gRenameProfile = gRenameProfile;
	}


	public String getgRenameImage() {
		return gRenameImage;
	}


	public void setgRenameImage(String gRenameImage) {
		this.gRenameImage = gRenameImage;
	}


	@Override
	public String toString() {
		return "Group [gNo=" + gNo + ", gCreator=" + gCreator + ", gManager=" + gManager + ", gName=" + gName
				+ ", gCategory=" + gCategory + ", gMax=" + gMax + ", gDate=" + gDate + ", gOpenScope=" + gOpenScope
				+ ", gJoinSet=" + gJoinSet + ", gQset=" + gQset + ", q1=" + q1 + ", q2=" + q2 + ", q3=" + q3
				+ ", gIntro=" + gIntro + ", gTag=" + gTag + ", gStatus=" + gStatus + ", gNotice=" + gNotice
				+ ", gProfile=" + gProfile + ", gImage=" + gImage + ", gRenameProfile=" + gRenameProfile
				+ ", gRenameImage=" + gRenameImage + "]";
	}
	
}
