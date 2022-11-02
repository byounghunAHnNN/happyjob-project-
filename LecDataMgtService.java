package kr.happyjob.study.pfssst.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.pfssst.model.LecDataMgtModel;
import kr.happyjob.study.pfssst.model.LecDataMgtfirstModel;

public interface LecDataMgtService {

	public List<LecDataMgtfirstModel> listlecDataMgtfirst(Map<String, Object> paramMap) throws Exception;
	
	public int firstsearchlistcnt(Map<String, Object> paramMap)throws Exception;
	
	public List<LecDataMgtModel> listlecDataMgt(Map<String, Object> paramMap) throws Exception;

	public int searchlistcnt(Map<String, Object> paramMap)throws Exception;
	
	// insert 데이터 삽입 
	public void insertFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	public void updateFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	public void deleteFileuploadatt(Map<String, Object> paramMap) throws Exception;

	public LecDataMgtModel selectFileupload(Map<String, Object> paramMap)throws Exception;


	
	
}
