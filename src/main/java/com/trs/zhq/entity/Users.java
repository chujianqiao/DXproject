package com.trs.zhq.entity;

import java.io.Serializable;
import java.util.Date;

public class Users implements Serializable {
	private String ID;
	private String USERNAME;
	private String PASSWORD;
	private String NICKNAME;
	private String TRUENAME;
	private String EMAIL;
	private String TELPHONE;
	private String STATUS;
	private String DEPARTNAME;
	private String MOBILE;
	private String DESCS;
	private Date CRTIME;
	private String CRUSER;
	private String CRUSERNAME;
	public String REPASSWORDS;

	public String getID() {
		return this.ID;
	}

	public void setID(String ID) {
		this.ID = (ID == null ? null : ID.trim());
	}

	public String getUSERNAME() {
		return this.USERNAME;
	}

	public void setUSERNAME(String USERNAME) {
		this.USERNAME = (USERNAME == null ? null : USERNAME.trim());
	}

	public String getPASSWORD() {
		return this.PASSWORD;
	}

	public void setPASSWORD(String PASSWORD) {
		this.PASSWORD = (PASSWORD == null ? null : PASSWORD.trim());
	}

	public String getNICKNAME() {
		return this.NICKNAME;
	}

	public void setNICKNAME(String NICKNAME) {
		this.NICKNAME = (NICKNAME == null ? null : NICKNAME.trim());
	}

	public String getTRUENAME() {
		return this.TRUENAME;
	}

	public void setTRUENAME(String TRUENAME) {
		this.TRUENAME = (TRUENAME == null ? null : TRUENAME.trim());
	}

	public String getEMAIL() {
		return this.EMAIL;
	}

	public void setEMAIL(String EMAIL) {
		this.EMAIL = (EMAIL == null ? null : EMAIL.trim());
	}

	public String getTELPHONE() {
		return this.TELPHONE;
	}

	public void setTELPHONE(String TELPHONE) {
		this.TELPHONE = (TELPHONE == null ? null : TELPHONE.trim());
	}

	public String getSTATUS() {
		return this.STATUS;
	}

	public void setSTATUS(String STATUS) {
		this.STATUS = STATUS;
	}

	public String getDEPARTNAME() {
		return this.DEPARTNAME;
	}

	public void setDEPARTNAME(String DEPARTNAME) {
		this.DEPARTNAME = (DEPARTNAME == null ? null : DEPARTNAME.trim());
	}

	public String getMOBILE() {
		return this.MOBILE;
	}

	public void setMOBILE(String MOBILE) {
		this.MOBILE = (MOBILE == null ? null : MOBILE.trim());
	}

	public String getDESCS() {
		return this.DESCS;
	}

	public void setDESCS(String DESCS) {
		this.DESCS = (DESCS == null ? null : DESCS.trim());
	}

	public Date getCRTIME() {
		return this.CRTIME;
	}

	public void setCRTIME(Date CRTIME) {
		this.CRTIME = CRTIME;
	}

	public String getCRUSER() {
		return this.CRUSER;
	}

	public void setCRUSER(String CRUSER) {
		this.CRUSER = (CRUSER == null ? null : CRUSER.trim());
	}

	public String getCRUSERNAME() {
		return this.CRUSERNAME;
	}

	public void setCRUSERNAME(String CRUSERNAME) {
		this.CRUSERNAME = (CRUSERNAME == null ? null : CRUSERNAME.trim());
	}

	public String orderby = " crtime desc ";
	public boolean isSuperAdmin;

	public String getOrderby() {
		return this.orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}

	public String getREPASSWORDS() {
		return this.REPASSWORDS;
	}

	public void setREPASSWORDS(String rEPASSWORDS) {
		this.REPASSWORDS = rEPASSWORDS;
	}

	public boolean isSuperAdmin() {
		return this.isSuperAdmin;
	}

	public void setSuperAdmin(boolean isSuperAdmin) {
		this.isSuperAdmin = isSuperAdmin;
	}
}

/*
 * Location: C:\Users\UserHao\Desktop\通用框架\wms\WEB-INF\classes\
 * 
 * Qualified Name: com.wms.model.Users
 * 
 * JD-Core Version: 0.7.0.1
 */