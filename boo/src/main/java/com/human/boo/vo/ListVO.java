package com.human.boo.vo;

public class ListVO {
	private int dealno, objno, floor;
	private String aptname, dongname, deal_ymd;
	public int getDealno() {
		return dealno;
	}
	public void setDealno(int dealno) {
		this.dealno = dealno;
	}
	public int getObjno() {
		return objno;
	}
	public void setObjno(int objno) {
		this.objno = objno;
	}
	public int getFloor() {
		return floor;
	}
	public void setFloor(int floor) {
		this.floor = floor;
	}
	public String getAptname() {
		return aptname;
	}
	public void setAptname(String aptname) {
		this.aptname = aptname;
	}
	public String getDongname() {
		return dongname;
	}
	public void setDongname(String dongname) {
		this.dongname = dongname;
	}
	public String getDeal_ymd() {
		return deal_ymd;
	}
	public void setDeal_ymd(String deal_ymd) {
		this.deal_ymd = deal_ymd;
	}
	@Override
	public String toString() {
		return "ListVO [dealno=" + dealno + ", objno=" + objno + ", aptname=" + aptname + ", dongname=" + dongname
				+ ", deal_ymd=" + deal_ymd + "]";
	}
}
