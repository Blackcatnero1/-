package com.human.boo.vo;

public class ListVO {
	private int muney;
	private String goo, dong, aname;
	public int getMuney() {
		return muney;
	}
	public void setMuney(int muney) {
		this.muney = muney;
	}
	public String getGoo() {
		return goo;
	}
	public void setGoo(String goo) {
		this.goo = goo;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getAname() {
		return aname;
	}
	public void setAname(String aname) {
		this.aname = aname;
	}
	@Override
	public String toString() {
		return "ListVO [muney=" + muney + ", goo=" + goo + ", dong=" + dong + ", aname=" + aname + "]";
	}
}
