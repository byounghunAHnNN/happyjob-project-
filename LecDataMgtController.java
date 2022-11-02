package kr.happyjob.study.pfssst.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.admsst.model.FileuploadModel;
import kr.happyjob.study.pfssst.model.LecDataMgtModel;
import kr.happyjob.study.pfssst.model.LecDataMgtfirstModel;
import kr.happyjob.study.pfssst.service.LecDataMgtService;

@Controller
@RequestMapping("/supportD/")
public class LecDataMgtController {
	

	@Autowired
	LecDataMgtService lecdatamgtservice;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	  
	/**
	 * 파일 업로드 샘플 초기화면
	 */
	@RequestMapping("lecDataMgt.do")
	public String lecDataMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecdatamgt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lecdatamgt");
		
		logger.info("@@@@@@@@@@@@@@@@@@@@@@@" + ".lecdatamgt");
		return "pfssst/lecdatamgt";
		
	}
	
	@RequestMapping("listlecDataMgtfirst.do")
	public String listlecDataMgtfirst(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listlecDataMgtfirst");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		String loginID = (String) session.getAttribute("loginId");
		logger.info("loginId ??????????????????????????????????" + loginID);
		paramMap.put("startnum", startnum);
		
		paramMap.put("pagesize", pagesize);
		
		paramMap.put("loginID", loginID);
		
		
		List<LecDataMgtfirstModel> firstsearchlist = lecdatamgtservice.listlecDataMgtfirst(paramMap);		
		model.addAttribute("firstsearchlist", firstsearchlist);
		
		int firstsearchlistcnt =lecdatamgtservice.firstsearchlistcnt(paramMap);
		model.addAttribute("firstsearchlistcnt", firstsearchlistcnt);
		
		logger.info("+ End " + className + ".listlecDataMgtfirst");

		return "pfssst/lecdatamgtfirstlist";
	}

	@RequestMapping("listlecDataMgt.do")
	public String listlecDataMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listlecDataMgt");
		logger.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.info("   - paramMap : " + paramMap);			
		
		int clickpagenum = Integer.parseInt( String.valueOf(paramMap.get("clickpagenum"))) ;   
		int pagesize = Integer.parseInt( String.valueOf(paramMap.get("pagesize"))) ;  
		int startnum = (clickpagenum - 1) * pagesize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pagesize", pagesize);
				
		List<LecDataMgtModel> searchlist = lecdatamgtservice.listlecDataMgt(paramMap);		
		model.addAttribute("searchlist", searchlist);
		
		int searchlistcnt =lecdatamgtservice.searchlistcnt(paramMap);
		model.addAttribute("searchlistcnt", searchlistcnt);
		
		logger.info("+ End " + className + ".listlecDataMgt");
		return "pfssst/lecdatamgtlist";
	}
	
	
	@RequestMapping("saveFileuploadatt.do")
	@ResponseBody
	public Map<String, Object> saveFileuploadatt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveFileuploadatt");
		logger.info("   - paramMap : " + paramMap);			
		
		paramMap.put("loginID",(String) session.getAttribute("loginId"));
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			lecdatamgtservice.insertFileuploadatt(paramMap,request);
		} else if("U".equals(action)) {
			lecdatamgtservice.updateFileuploadatt(paramMap,request);
		} else if("D".equals(action)) {
			lecdatamgtservice.deleteFileuploadatt(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".saveFileuploadatt");

		return returnmap;
	}
	
	@RequestMapping("selectFileupload.do")
	@ResponseBody
	public Map<String, Object> selectFileupload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectFileupload");
		logger.info("   - paramMap : " + paramMap);			
		
		LecDataMgtModel searchone = lecdatamgtservice.selectFileupload(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("result", "SUCESS");
		returnmap.put("searchone", searchone);
		
		logger.info("+ End " + className + ".selectFileupload");

		return returnmap;
	}
	
	@RequestMapping("downloadfile.do")
	public void downloadfile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".downloadfile");
		logger.info("   - paramMap : " + paramMap);			
		
		LecDataMgtModel searchone = lecdatamgtservice.selectFileupload(paramMap);


		//물리경로 조회해서 담기 
		String file = searchone.getAtt_mul();

		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(searchone.getAtt_ori(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
		
	    return;
	}
	
}  
