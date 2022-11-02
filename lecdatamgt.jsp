<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학습자료관리 </title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">


    //페이지 관리 
    
    var pagesize = 5;
    var pagenumsize = 5;

    
	/** OnLoad event */ 
		$(function() {
		
		// 게시판 조회
		fListlecDataMgtfirst();
		
		fRegisterButtonClickEvent();
		
		
	});
	
		/** 버튼 이벤트 등록 */
		function fRegisterButtonClickEvent() {
			$('a[name=btn]').click(function(e) {
				e.preventDefault();

				var btnId = $(this).attr('id');
				
				switch (btnId) {
					case 'btnSearch' : 
						fListlecDataMgtfirst();  //누르면 jquery실행하라는 의미 
						break;
					case 'btnSearchfile' : 
						fListlecDataMgt();  //누르면 jquery실행하라는 의미 
						break;
					case 'btnSavefile' : 
						fsavefileuploadatt();
						break;		
					case 'btnDeletefile' :
						$("#action").val("D");
						fsavefileuploadatt();
						break;		
					case 'btnClose' :
						gfCloseModal();
						break;
					case 'btnClosefile' :
						gfCloseModal();
						break;
					case 'btnRevisefile' :
						gfCloseModal();
						break;
				}
			});
		}
						
		
	
		
		
		
		//학습자료관리 리스트 페이지관리 
		function fListlecDataMgtfirst(clickpagenum) {
			
			clickpagenum = clickpagenum || 1;
			
			var param = {
					searchtype : $("#searchtype").val(),
					searchvalue : $("#searchvalue").val(),
					clickpagenum : clickpagenum,
					pagesize : pagesize

			};
	    	
			var firstsearchcallback = function(returndata) {
				
				console.log("returndata : " + returndata);
				
				firstsearchcallbackprocess(returndata,clickpagenum);
				
			}
			
			callAjax("/supportD/listlecDataMgtfirst.do", "post", "text", true, param, firstsearchcallback);			
		}
		
		
		//  강의명 returndata
		function firstsearchcallbackprocess(returndata,clickpagenum) {
			
			console.log("returndata : " + returndata );
			
			$("#listlecDataMgtfirst").empty().append(returndata); //초기화 시켜주고 returndata값을 listLecdatamgt에 넘겨준다. 
			
			var totalcnt = $("#firstsearchlistcnt").val();
			var li_no = $("#li_no").val();
			var loginID = $("#loginID").val();
			
			console.log("totalcnt : " + totalcnt);
			console.log(" li_no : " + li_no);
			console.log(" loginID : " + loginID);
			
			var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListlecDataMgtfirst');
			
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#listlecDataMgtfirstPagination").empty().append( paginationHtml );
			
			$("#hclickpagenum").val(clickpagenum);  // hclickpagenum => 히든값.
		}
		
		//강의 파일 리스트 
		function fListclick(no) {
			$("#li_no").val(no);
			
			fListlecDataMgt();
		}
		
	//제목 작성일 작성자 리턴파일.  
	function fListlecDataMgt(clickpagenum) {

		
		clickpagenum = clickpagenum || 1;
		
		
		var li_no = $("#li_no").val();
		
		
		var sdate = $("#sdate").val();
		var edate = $("#edate").val();
		
		var param = {
				
				clickpagenum : clickpagenum,
				pagesize : pagesize	,
				pagenumsize : pagenumsize,
				li_no : li_no,
				sdate : sdate,
				edate : edate

		};
    	
		var searchcallback = function(returndata) {
			
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/supportD/listlecDataMgt.do", "post", "text", true, param, searchcallback);			
	}
	
	//  학습자료관리 returndata
	function searchcallbackprocess(returndata,clickpagenum) {

		console.log("returndata : " + returndata );
		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ : "  );
		
		$("#listlecDataMgt").empty().append(returndata); //초기화 시켜주고 returndata값을 listLecdatamgt에 넘겨준다. 
		
		var totalcnt = $("#searchlistcnt").val();
		var li_no = $("#li_no").val();
		var loginID = $("#loginID").val();
		
		console.log("totalcnt : " + totalcnt);
		console.log(" li_no : " + li_no);
		console.log(" loginID : " + loginID);
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListlecDataMgt');
		
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnfileuploadPagination").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);  // hclickpagenum => 히든값.
	}
	
	function fPopModalfile() {
		
        $("#action").val("I");
        
        
        var li_no = $("#li_no").val();
		console.log("~~~~~~~~~~~~~~~~~~~~~~~~"+li_no);
		if(li_no==null || li_no==""){
			alert("등록할 강의번호를 선택해주세요");
			return 
		}
		fn_forminitfile();
		
		console.log(" li_no : " + $("#li_no").val());
		
		gfModalPop("#layer2");
		
	}
	
	
	
	
	function fn_forminitfile(object) {
		
		if (object == null || object=="") {
			$("#titlefile").val("");
			$("#contfile").val("");
			$("#loginID").val("");	
			$("#li_nm").val("");
			console.log(" case1" );
			$("#btnDeletefile").hide();			
			$("#upfile").val("");			
			$("#filedownloaddiv").empty();
			$("#title").focus();
			
		} else {
			$("#li_no").val(object.li_no);
			$("#le_no").val(object.le_no);
			$("#titlefile").val(object.le_title);
			$("#contfile").val(object.le_contents);
			$("#loginID").val("");
			console.log(" case2" );
			$("#btnDeletefile").show();
			$("#li_nm").val("");	
			
			
			var fileyn = "";
			var inhtml = "";
			
			if (object.att_ori == null || object.att_ori =="") {
				$("#filedownloaddiv").empty();
				// $("#filepewviewdiv").empty();
			} else {
				inhtml = "<a href='javascript:download()'>" + object.att_ori + "("  + object.att_size+ ")</a>"; 
				$("#filedownloaddiv").empty().append(inhtml);
				
			}
		
		}		
	}	
	
	function fselectonefile(no) {
		
		var param = { le_no : no };
		
		$("#le_no").val(no);

		// $("#li_no").val(no);
		
		
		var selectonecallback = function( selectonersn ) {
			console.log(JSON.stringify(selectonersn));
			//console.log(JSON.stringify(selectonersn.searchone));
			
			$("#action").val("U");			
			fn_forminitfile(selectonersn.searchone);
			
			gfModalPop("#layer2");
		}
		
		callAjax("/supportD/selectFileupload.do", "post", "json", true, param, selectonecallback);
	}
		

	
	
	function fsavefileuploadatt() {
		
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var dataWithFile = new FormData(frm);
		
		
		
		var savecallback= function(rtn) {
			
			//$("#li_no").val("");
			//$("#li_no").val("li_no");
			
			var no=$("#li_no").val();
			fListclick(no);
			console.log(JSON.stringify(rtn));
			
			alert("저장 되었습니다.");
			
			gfCloseModal();
			
			var savepageno = 1;
			
			if($("#action").val() == "U") {
				savepageno = $("#hclickpagenum").val();
			}
						
			
			fListlecDataMgtfirst(savepageno);
			
		}
		
		console.log(" fsavefileuploadatt : " + $("#li_no").val());
		
	    callAjaxFileUploadSetFormData("/supportD/saveFileuploadatt.do", "post", "json", true, dataWithFile, savecallback);
	}
	
	function download() {
		
		var params = "<input type='hidden' name='le_no' value='"+ $("#le_no").val() +"' />";

		jQuery(
				"<form action='/supportD/downloadfile.do' method='post'>"
						+ params + "</form>").appendTo('body').submit().remove();
	}

	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="li_no" name="li_no"  value="" />
	<input type="hidden" id="le_no" name="le_no"  value="" />
	<input type="hidden" id="loginID" name="loginID" value =""/>
	<input type="hidden" id="li_nm" name="li_nm"  value="" />
	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">학습자료관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>학습자료관리</span> <span class="fr"> 
							</span>
						</p>
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">

									
		     	                      <select id="searchtype" name="searchtype" style="width: 150px;" v-model="searchKey">
											<option value="number" >강의번호</option>
											<option value="name" >강의명</option>
									</select> 
								
								 
	     	                       <input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue"> 
	     	                       
	     	                       
	     	                                          
		                          
		                            
		                          <a  class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
		                          
		                          

	                           </td> 
	                           
	                        </tr>
                        </table> 
                        
                   	<div class="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="50%">
									<col width="50%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
									</tr>
								</thead>
								
								<tbody id="listlecDataMgtfirst"></tbody>
							</table>
							<div class="paging_area"  id="listlecDataMgtfirstPagination"> </div>
						</div>
						
                        <br>  
                        
                        <p>
                         <span align="left" >
		                 <span>작성일</span> <input type="date" id="sdate"> ~ <input type = "date" id ="edate"> <a  class="btnType blue" id="btnSearchfile" name="btn"><span>검  색</span></a></span>
						 <span class="fr"> 
						 
		                         
							    <a	 class="btnType blue" href="javascript:fPopModalfile();" name="modal"><span>자료등록</span></a>
						 </span>
						</p>
						
                        
                        
						<div class="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="50%">
									<col width="30%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">자료명</th>
										<th scope="col">작성일</th>
										<th scope="col">작성자</th>
									</tr>
								</thead>
								
								<tbody id="listlecDataMgt"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="comnfileuploadPagination"> </div>
						
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>글 편집</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="title" id="title" /></td>
						</tr>
						<tr>
							<th scope="row">작성일 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name=date id="date" > </textarea>
						   </td>
						</tr>
						
						<tr>
							<th scope="row">작성자 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name=name id="name" > </textarea>
						   </td>
						</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
					<a href=""	class="btnType gray"  id="btnRevisefile" name="btn"><span>수정</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>글 편집(파일)</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">제목 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="titlefile" id="titlefile" /></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="contfile" id="contfile" > </textarea>
						   </td>
						</tr>
						<tr>
							<th scope="row">첨부파일 <span class="font_red">*</span></th>
							<td>
							     <input type="file" id="upfile" name="upfile"   />
						   </td>
						</tr>
						<tr>
							<th scope="row">파일 다운로드<span class="font_red">*</span></th>
							<td>
							     <div id="filedownloaddiv"> </div>
						   </td>
						</tr>						
						<tr>
													
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSavefile" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeletefile" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClosefile" name="btn"><span>취소</span></a>

				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!--// 모달팝업 -->
</form>
</body>
</html>