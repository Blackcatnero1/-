package com.human.boo.vo;

public class ChatbotVO {
	
	private int acc_year, p_year, p_total, obj_amt, deal_ydm, build_year, deal_cnt;
	private float bldg_area;
	private String sgg_nm, bjdong_nm, jibeon,bldg_nm, nickname;
	
	
	

	public String getSgg_nm() {
		return sgg_nm;
	}

	public void setSgg_nm(String sgg_nm) {
		this.sgg_nm = sgg_nm;
	}

	public int getDeal_cnt() {
		return deal_cnt;
	}

	public void setDeal_cnt(int deal_cnt) {
		this.deal_cnt = deal_cnt;
	}

	public String getJibeon() {
		return jibeon;
	}

	public void setJibeon(String jibeon) {
		this.jibeon = jibeon;
	}

	public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
	public int getAcc_year() {
		return acc_year;
	}
	public void setAcc_year(int acc_year) {
		this.acc_year = acc_year;
	}
	public int getP_year() {
		return p_year;
	}
	public void setP_year(int p_year) {
		this.p_year = p_year;
	}
	public int getP_total() {
		return p_total;
	}
	public void setP_total(int p_total) {
		this.p_total = p_total;
	}
	public int getObj_amt() {
		return obj_amt;
	}
	public void setObj_amt(int obj_amt) {
		this.obj_amt = obj_amt;
	}
	public int getDeal_ydm() {
		return deal_ydm;
	}
	public void setDeal_ydm(int deal_ydm) {
		this.deal_ydm = deal_ydm;
	}
	public int getBuild_year() {
		return build_year;
	}
	public void setBuild_year(int build_year) {
		this.build_year = build_year;
	}
	public float getBldg_area() {
		return bldg_area;
	}
	public void setBldg_area(float bldg_area) {
		this.bldg_area = bldg_area;
	}

	public String getBjdong_nm() {
		return bjdong_nm;
	}
	public void setBjdong_nm(String bjdong_nm) {
		this.bjdong_nm = bjdong_nm;
	}

	public String getBldg_nm() {
		return bldg_nm;
	}
	public void setBldg_nm(String bldg_nm) {
		this.bldg_nm = bldg_nm;
	}

	@Override
	public String toString() {
		return "ChatbotVO [acc_year=" + acc_year + ", p_year=" + p_year + ", p_total=" + p_total + ", obj_amt="
				+ obj_amt + ", deal_ydm=" + deal_ydm + ", build_year=" + build_year + ", deal_cnt=" + deal_cnt
				+ ", bldg_area=" + bldg_area + ", sgg_nm=" + sgg_nm + ", bjdong_nm=" + bjdong_nm + ", jibeon=" + jibeon
				+ ", bldg_nm=" + bldg_nm + ", nickname=" + nickname + "]";
	}

	
	
	
	
}
