package com.kh.spring.myAccount.model.vo;

public class myAccount {
	
	private int mNo;
	private String mId;
	private String mRenameImage;
	private int follows;
	private int followers;
	private int gNo;
	private String gName;
	private String gRenameProfile;
	
	public myAccount() {
		super();
	}

	public myAccount(int mNo, String mId, String mRenameImage, int follows, int followers, int gNo, String gName,
			String gRenameProfile) {
		super();
		this.mNo = mNo;
		this.mId = mId;
		this.mRenameImage = mRenameImage;
		this.follows = follows;
		this.followers = followers;
		this.gNo = gNo;
		this.gName = gName;
		this.gRenameProfile = gRenameProfile;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmRenameImage() {
		return mRenameImage;
	}

	public void setmRenameImage(String mRenameImage) {
		this.mRenameImage = mRenameImage;
	}

	public int getFollows() {
		return follows;
	}

	public void setFollows(int follows) {
		this.follows = follows;
	}

	public int getFollowers() {
		return followers;
	}

	public void setFollowers(int followers) {
		this.followers = followers;
	}

	public int getgNo() {
		return gNo;
	}

	public void setgNo(int gNo) {
		this.gNo = gNo;
	}

	public String getgName() {
		return gName;
	}

	public void setgName(String gName) {
		this.gName = gName;
	}

	public String getgRenameProfile() {
		return gRenameProfile;
	}

	public void setgRenameProfile(String gRenameProfile) {
		this.gRenameProfile = gRenameProfile;
	}

	@Override
	public String toString() {
		return "myAccount [mNo=" + mNo + ", mId=" + mId + ", mRenameImage=" + mRenameImage + ", follows="
				+ follows + ", followers=" + followers + ", gNo=" + gNo + ", gName=" + gName + ", gRenameProfile="
				+ gRenameProfile + "]";
	}

	
	
}
