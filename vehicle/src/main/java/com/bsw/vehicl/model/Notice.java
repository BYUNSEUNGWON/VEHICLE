package com.bsw.vehicl.model;

public class Notice {
    private int bno;
    private String title;
    private String date;
    private String contents;
    private String regist_user_nm;
    
	public String getRegist_user_nm() {
		return regist_user_nm;
	}
	public void setRegist_user_nm(String regist_user_nm) {
		this.regist_user_nm = regist_user_nm;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
    public Notice(int bno, String title, String date, String regist_user_nm) {
        this.bno = bno;
        this.title = title;
        this.date = date;
        this.regist_user_nm = regist_user_nm;
    }
    
    
}
