package kr.happyjob.study.pfssst.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.admsst.model.FileuploadModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.pfssst.dao.LecDataMgtDao;
import kr.happyjob.study.pfssst.model.LecDataMgtModel;
import kr.happyjob.study.pfssst.model.LecDataMgtfirstModel;;

@Service
public class LecDataMgtServiceImpl implements LecDataMgtService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	
	@Autowired
	private LecDataMgtDao lecdatamgtdao;
	
	//파일 업로드 위해 사용
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Override
	public List<LecDataMgtfirstModel> listlecDataMgtfirst(Map<String, Object> paramMap) throws Exception {		
		return lecdatamgtdao.listlecDataMgtfirst(paramMap);
	}
	
	@Override
	public int firstsearchlistcnt(Map<String, Object> paramMap) throws Exception {
		return lecdatamgtdao.firstsearchlistcnt(paramMap);
	}
	
	@Override
	public List<LecDataMgtModel> listlecDataMgt (Map<String, Object> paramMap) throws Exception {		
		return lecdatamgtdao.listlecDataMgt(paramMap);
	}
	
	@Override
	public int searchlistcnt(Map<String, Object> paramMap) throws Exception {
		return lecdatamgtdao.searchlistcnt(paramMap);
		
	}
	
    public void deleteFileupload(Map<String, Object> paramMap) throws Exception {
		
    	lecdatamgtdao.deleteFileupload(paramMap);
		
		return ;
	}
    
	//insert 데이터 삽입. 
    public void insertFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
    	MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		//파일저장
		String itemFilePath = noticePath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		System.out.println("fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo);
		
//          map.put("file_nm", file_nm);
//          map.put("file_size", file_Size);
//          map.put("file_loc", file_loc);
//          map.put("fileExtension", fileExtension);
//          map.put("loc_file_loc", fileExtension);
		
		String logicalpath = virtualRootPath + File.separator + noticePath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);
		
		String FilNm = (String)fileInfo.get("file_nm");
		
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			lecdatamgtdao.insertFileinfo(fileInfo);
		} else {
			paramMap.put("fileyn", "N");
			
		}
		
		//paramMap.put("filepro", "Y");
		
		logger.info(" @@@@@@@@@@@@@@@@@@##############!!!!!!!!!!!!#!#!#!#  - paramMap : " + paramMap );	
		
		lecdatamgtdao.insertFileupload(paramMap);
    	
    }
    public void deleteFileuploadatt(Map<String, Object> paramMap) throws Exception {
		
    	LecDataMgtModel selectupload = lecdatamgtdao.selectFileupload(paramMap);
    	
        String oldFilNm = selectupload.getAtt_ori();
		if (oldFilNm != null && !"".equals(oldFilNm)) {
			lecdatamgtdao.deleteFileinfobybdno(paramMap);
	    	File oldfile = new File(selectupload.getAtt_mul());
	    	oldfile.delete();			
		}
    	
		lecdatamgtdao.deleteFileupload(paramMap);
		
		return ;
	}
    
    public void updateFileuploadatt(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
    	
MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		LecDataMgtModel selectupload = lecdatamgtdao.selectFileupload(paramMap); //파일 다운할때 쓰는.
    	    	
        String oldFilNm = selectupload.getAtt_ori();
		if (oldFilNm != null && !"".equals(oldFilNm)) {
			lecdatamgtdao.deleteFileinfobybdno(paramMap);
	    	File oldfile = new File(selectupload.getAtt_mul());
	    	oldfile.delete();			
		}
    	
 
    	
		//파일저장
		String itemFilePath = noticePath + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		System.out.println("fileInfo @@@@@@@@@@@@@@@@@@@" +fileInfo);
		
        //map.put("file_nm", file_nm);
        //map.put("file_size", file_Size);
        //map.put("file_loc", file_loc);
        //map.put("fileExtension", fileExtension);
        //map.put("loc_file_loc", fileExtension);
		
		String logicalpath = virtualRootPath + File.separator + noticePath + File.separator + fileInfo.get("file_nm");
		
		fileInfo.put("loc_file_loc", logicalpath);
		
		String FilNm = (String)fileInfo.get("file_nm");
		
		if (FilNm != null && !"".equals(FilNm)) {
			paramMap.put("fileyn", "Y");
			lecdatamgtdao.insertFileinfo(fileInfo);
		} else {
			paramMap.put("fileyn", "N");
		}
		
		paramMap.put("filepro", "Y");
		
		lecdatamgtdao.updateFileupload(paramMap);
    	
    }
    
    public LecDataMgtModel selectFileupload(Map<String, Object> paramMap) throws Exception {
		
		LecDataMgtModel selectupload = lecdatamgtdao.selectFileupload(paramMap);
		
		return selectupload;
	}

    
}
