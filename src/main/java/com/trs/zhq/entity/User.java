package com.trs.zhq.entity;



public class User {
	private String USERNAME;
	private String UID;
	private String FILESIZE;
	private String MAXSIZE;

	public String getUSERNAME() {
		return USERNAME;
	}

	public void setUSERNAME(String USERNAME) {
		this.USERNAME = USERNAME;
	}

	public String getUID() {
		return UID;
	}

	public void setUID(String UID) {
		this.UID = UID;
	}

	public String getFILESIZE() {
		return FILESIZE;
	}

	public void setFILESIZE(String FILESIZE) {
		this.FILESIZE = FILESIZE;
	}

	public String getMAXSIZE() {
		return MAXSIZE;
	}

	public void setMAXSIZE(String MAXSIZE) {
		this.MAXSIZE = MAXSIZE;
	}
}
