package kr.happyjob.study.pfssst.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pfssst.model.LecDataMgtModel;
import kr.happyjob.study.pfssst.model.LecDataMgtfirstModel;

public interface LecDataMgtDao {

	/** 강의 목록 조회.  */
	public List<LecDataMgtfirstModel> listlecDataMgtfirst(Map<String, Object> paramMap) throws Exception;
	
	public int firstsearchlistcnt(Map<String, Object> paramMap) throws Exception;
	
	/*강의목록 누르면 나오는 리스트(제목 작성일 작성자) */
	public List<LecDataMgtModel> listlecDataMgt(Map<String, Object> paramMap) throws Exception;
	
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception;
	
	//파일 선택부분. 
	public LecDataMgtModel selectFileupload(Map<String, Object> paramMap)throws Exception;
	
	// insert파일부분. 
	public void insertFileupload(Map<String, Object> paramMap) throws Exception;
	
	public void insertFileinfo(Map<String, Object> paramMap) throws Exception;
	
	public void deleteFileinfobybdno(Map<String, Object> paramMap) throws Exception;

	public void updateFileupload(Map<String, Object> paramMap)throws Exception;

	public void deleteFileupload(Map<String, Object> paramMap)throws Exception;

	public void deleteFileuploadatt(Map<String, Object> paramMap)throws Exception;
	
	
	

	
	
	
}
