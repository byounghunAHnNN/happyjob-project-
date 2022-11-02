package kr.happyjob.study.admsst.model;

public class CounselDtlModel{
	
	public String getUi_name() {
		return ui_name;
	}
	public void setUi_name(String ui_name) {
		this.ui_name = ui_name;
	}
	public String getSs_score() {
		return ss_score;
	}
	public void setSs_score(String ss_score) {
		this.ss_score = ss_score;
	}

	@Override
	public String toString() {
		return "CounselDtlModel [loginID=" + loginID + "]";
	}
	

	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	
	public String getLi_no() {
		return li_no;
	}
	public void setLi_no(String li_no) {
		this.li_no = li_no;
	}

	private String ss_score;
	private String ui_name;
	private String loginID;
	private String li_no;

	

}
