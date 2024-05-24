package com.human.boo.vo;

public class ListVO {
	private int money, rno;
	private String goo, dong, aname;
	public int getMuney() {
		return money;
	}
	public void setMuney(int muney) {
		this.money = muney;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
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
		return "ListVO [money=" + money + ", rno=" + rno + ", goo=" + goo + ", dong=" + dong + ", aname=" + aname + "]";
	}
}
