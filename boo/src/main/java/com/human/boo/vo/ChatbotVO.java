package com.human.boo.vo;

public class ChatbotVO {
	
	
	private int acc_year, p_year, p_total, obj_amt, deal_ydm, build_year, deal_cnt,avg_amt,rno,low_amt, high_amt,avg_per_area;
	private float bldg_area;
	private String sgg_nm, bjdong_nm, jibeon,bldg_nm, nickname, grade, juso,range_area;
	
	//페이징 처리 관련 VO 
	private int nowPage = 1;
	private int totalCount,pageRow,pageGroup, startPage, endPage,totalPage,startRno, endRno ;
	
	public String getJuso() {
		return juso;
	}
	public void setJuso(String juso) {
		this.juso = juso;
	}
	public int getAvg_per_area() {
		return avg_per_area;
	}
	public void setAvg_per_area(int avg_per_area) {
		this.avg_per_area = avg_per_area;
	}
	public int getLow_amt() {
		return low_amt;
	}
	public void setLow_amt(int low_amt) {
		this.low_amt = low_amt;
	}
	public int getHigh_amt() {
		return high_amt;
	}
	public void setHigh_amt(int high_amt) {
		this.high_amt = high_amt;
	}
	
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public void setPage() {
		setPage(nowPage, totalCount, 20, 5);
	}
	
	public void setPage(int nowPage, int totalCount) {
		setPage(nowPage, totalCount, 20, 5);
	}
	public void setPage(int nowPage, int totalCount, int pageRow, int pageGroup) {
		this.nowPage = nowPage;
		this.totalCount = totalCount;
		this.pageRow = pageRow;
		this.pageGroup = pageGroup;
		calcTotalPage();
		calcPage();
		calcRno();
	}
	public void calcTotalPage() {
		if(totalCount == 0) {
			totalPage = 1;
		} else {
			totalPage = (totalCount % pageRow == 0) ? (totalCount / pageRow) : (totalCount / pageRow + 1);
		}
	}
	public void calcPage() {
		startPage = (nowPage - 1) / pageGroup * pageGroup + 1;
		endPage = (startPage - 1) + pageGroup;
		if(totalPage < endPage) {
			endPage = totalPage;
		}
	}
	public void calcRno() {
		startRno = (nowPage - 1) * pageRow + 1;
		endRno = startRno + (pageRow - 1);
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage == 0 ? 1 : nowPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPageRow() {
		return pageRow;
	}
	public void setPageRow(int pageRow) {
		this.pageRow = pageRow;
	}
	public int getPageGroup() {
		return pageGroup;
	}
	public void setPageGroup(int pageGroup) {
		this.pageGroup = pageGroup;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartRno() {
		return startRno;
	}
	public void setStartRno(int startRno) {
		this.startRno = startRno;
	}
	public int getEndRno() {
		return endRno;
	}
	public void setEndRno(int endRno) {
		this.endRno = endRno;
	}
	public String getRange_area() {
		return range_area;
	}
	public void setRange_area(String range_area) {
		this.range_area = range_area;
	}
	public int getAvg_amt() {
		return avg_amt;
	}
	public void setAvg_amt(int avg_amt) {
		this.avg_amt = avg_amt;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
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
				+ ", avg_amt=" + avg_amt + ", rno=" + rno + ", low_amt=" + low_amt + ", high_amt=" + high_amt
				+ ", avg_per_area=" + avg_per_area + ", bldg_area=" + bldg_area + ", sgg_nm=" + sgg_nm + ", bjdong_nm="
				+ bjdong_nm + ", jibeon=" + jibeon + ", bldg_nm=" + bldg_nm + ", nickname=" + nickname + ", grade="
				+ grade + ", juso=" + juso + ", range_area=" + range_area + ", nowPage=" + nowPage + ", totalCount="
				+ totalCount + ", pageRow=" + pageRow + ", pageGroup=" + pageGroup + ", startPage=" + startPage
				+ ", endPage=" + endPage + ", totalPage=" + totalPage + ", startRno=" + startRno + ", endRno=" + endRno
				+ "]";
	}
}
