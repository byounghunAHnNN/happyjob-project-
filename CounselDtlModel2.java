package kr.happyjob.study.admsst.model;

public class CounselDtlModel2{
	private String loginID;		// 상담한 학생 ID
    private String cs_date;		// 상담일자
    private String cs_place;	// 상담장소	
    private String cs_nm;		// 상담자명
    private String li_no;		// 관련 과목 강의번호
    private String cs_ct;       // 상담 내용 

    
	public String getLi_no() {
		return li_no;
	}
	public void setLi_no(String li_no) {
		this.li_no = li_no;
	}

	@Override
	public String toString() {
		return "CounselDtlModel2 [loginID=" + loginID + ", cs_date=" + cs_date + ", cs_place=" + cs_place + ", cs_nm="
				+ cs_nm + ", li_no=" + li_no + "]";
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getCs_date() {
		return cs_date;
	}
	public void setCs_date(String cs_date) {
		this.cs_date = cs_date;
	}
	public String getCs_place() {
		return cs_place;
	}
	public void setCs_place(String cs_place) {
		this.cs_place = cs_place;
	}
	public String getCs_nm() {
		return cs_nm;
	}
	public void setCs_nm(String cs_nm) {
		this.cs_nm = cs_nm;
	}
	public String getCs_ct() {
		return cs_ct;
	}
	public void setCs_ct(String cs_ct) {
		this.cs_ct = cs_ct;
	}

	
}
