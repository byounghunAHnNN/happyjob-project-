<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>파일업로드 샘플</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
    
    var pagesize = 5;
    var pagenumsize = 5;
    var listlecdatavue;
    var sraecharea;
    var listlecdatavuetwo;
    var filepopup;

    
	/** OnLoad event */ 
	$(function() {
		
		init();
				
		listsearch();
		
		
		fRegisterButtonClickEvent();
	});
    
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' :
					listsearch();
					break;
				case 'btnSave' :
					fsavefileupload();
					break;	
				case 'btnDelete' :
					//$("#action").val("D");
					nofilepopup.action = "D";	
					fsavefileupload();
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
			}
		});
	}
	
	function init() {
		
		listlecdatavue = new Vue({
		                                      el : "#divfileuploadList",
			                               data : {
			                            	           listitem : [],
		                                               pagenavi : ""			                                 
			                               },
			                               methods : {
			                            	   detailview : function(no) {
			                            		        //alert(no);
			                            		        fListclick(no);	 
			                            	   }
			                               }
			                               
		})
		
		sraecharea = new Vue({
		                                    el : "#sraecharea",
		                                 data : {
		                                	   searchKey : "",
		                                	 searchvalue : ""
		                                 }     
			
		})
		
		listlecdatavuetwo = new Vue({
								            el : "#divfileuploadListtwo",
								         data : {
								      	           listitem : [],
								                   pagenavi : ""			                                 
								         },
		                            	   detailviewfile : function(no) {
	                            		        alert(no);
	                            		        fn_selectonefile(no);	
	                            	       }
								         
								})
		
				filepopup = new Vue({	
											el : "#layer2",
										  data : {
							            	          titlefile : "",
							            	          contfile: "",
							            	          disdownload: "",
							               	          dispreview: "",
							            	          action : "",
							            	          no : 0,
							            	          delshow : false
											  
										  }
				
					
				})
				
				
		
	}
	//첫번째 리스트 뿌린부분. 
	function listsearch(pagenum) {
		
		pagenum = pagenum || 1;
		
		console.log("sraecharea.searchKey : " + sraecharea.searchKey + " sraecharea.searchvalue : " + sraecharea.searchvalue);

		var param = {
				pagenum : pagenum,
				pagesize : pagesize,
				searchtype : sraecharea.searchKey, //검색조건 위해 사용. 
				searchvalue : sraecharea.searchvalue // 검색 위해 사용. 
		}
		
		var listcallback = function(returndata) {
			
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			listlecdatavue.listitem = returndata.firstsearchlist;
			
			var paginationHtml = getPaginationHtml(pagenum, returndata.firstsearchlistcnt, pagesize, pagenumsize, 'listsearch');
			console.log("paginationHtml : " + paginationHtml);
			
			listlecdatavue.pagenavi = paginationHtml;
			
		}
		
		callAjax("/supportD/listlecDataMgtfirstvue.do", "post", "json", true, param, listcallback);
	}
 
/* 	function fn_selectone(no) {
		
		var param = { li_no : no }
		
		$("#le_no").val(no);
		
		
		var selectoncallback = function(returndata) {
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			listsearchtwo(returndata.searchone);
		}
		
		callAjax("/supportD/selectFileupload.do", "post", "json", true, param, selectoncallback);
		
	}  */
	
	//강의 파일 리스트 클릭 함수 (두번째리스트가 나옴.) 
	function fListclick(no) {
		$("#li_no").val(no);
		
		listsearchtwo();
	}
	// 두번째 리스트 부분 
	function listsearchtwo(pagenum) {
		
		pagenum = pagenum || 1;	
		
		var li_no = $("#li_no").val();
		var le_nm = $("#le_nm").val();
		
		var sdate = $("#sdate").val();
		var edate = $("#edate").val();
		
		console.log("sraecharea.searchKey : " + sraecharea.searchKey + " sraecharea.searchvalue : " + sraecharea.searchvalue);

		var param = {
				pagenum : pagenum,
				pagesize : pagesize,
				searchtype : sraecharea.searchKey, //검색조건 위해 사용. 
				searchvalue : sraecharea.searchvalue, // 검색 위해 사용.
				li_no : li_no,
				sdate : sdate,
				edate : edate,
				le_nm : le_nm
		}
		
		var listcallbacktwo = function(returndata) {
			
			console.log(  "listcallbacktwo " + JSON.stringify(returndata) );
			
			listlecdatavuetwo.listitem = returndata.searchlist;
			var paginationHtml = getPaginationHtml(pagenum, returndata.searchlistcnt, pagesize, pagenumsize, 'listsearchtwo');
			console.log("paginationHtml : " + paginationHtml);
			
			listlecdatavuetwo.pagenavi = paginationHtml;
			
		}
		
		callAjax("/supportD/listlecDataMgtvue.do", "post", "json", true, param, listcallbacktwo);
	}
	
	function fPopModalfile() {
		
		
		
		
		var li_no = $("#li_no").val();
		
		if(li_no == null || li_no==""){
			alert("등록할 강의번호를 선택해주세요");
			return 
		}
		
		fn_forminitfile();
		gfModalPop("#layer2");		
	}
	
 	function fn_forminitfile(object) {
		
		if (object == null || object=="") {
			filepopup.titlefile = "";
			filepopup.contfile = "";
			filepopup.no = "";				
			filepopup.disdownload = "";		
			filepopup.action = "I";
			console.log(" case1" );
			$("#action").val("I");
			
			filepopup.delshow = false;
		} else {
			
			filepopup.titlefile = object.le_title;
			filepopup.contfile = object.le_contents;
			filepopup.no = object.li_no;
			filepopop.no = object.le_no;
			filepopup.action = "U";			
			$("#action").val("U");
			console.log(" case2" );			
			filepopup.delshow = true;
	
		}
	}
 	
	function fn_selectonefile(no) {
		
		var param = {
				le_no : no				
		}
		var selectoncallback = function(returndata) {
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			fn_forminitfile(returndata.searchone);
			
			gfModalPop("#layer2");
		}
		
		callAjax("/supportD/selectFileupload.do", "post", "json", true, param, selectoncallback);		
	} 
	
 	function fsavefileuploadatt() {
		
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var dataWithFile = new FormData(frm);
		
		
		
		
		var savecallback= function(rtn) {
			console.log(JSON.stringify(rtn));
			
			alert("저장 되었습니다.");
			
			gfCloseModal();
			
			var savepageno = 1;
			
			
			listsearch(savepageno);
			
		}
		
		callAjaxFileUploadSetFormData("/supportD/saveFileuploadatt.do", "post", "json", true, dataWithFile, savecallback);
		
	} 
	//   파일 미첨부   팝업 처리  끝	
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
								class="btn_nav bold">학습관리</span> <span class="btn_nav bold">게시판</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>게시판</span> <span class="fr"> 
							</span>
						</p>
						
						<div id="sraecharea">
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">

										
			     	                      <select id="searchtype" name="searchtype" style="width: 150px;" v-model="searchKey">
			     	                            <option value="number" >강의번호</option>
												<option value="name" >강의명</option>
										</select> 
									
		     	                       <input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue"  v-model="searchvalue">                    
			                            <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검 색</span></a>
		                           </td> 
		                           
		                        </tr>
	                        </table> 
                        </div>
                        
                        
						<div id="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="50%">
									<col width="50%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의 번호</th> 
										<th scope="col">강의명</th>
									</tr>
								</thead>
								<tbody id="listfileupload" v-for=" (item, index) in listitem" >
								     <tr>
								         <td @click="detailview(item.li_no)"> {{ item.li_no }}  </td>
								         <td @click="detailview(item.li_nm)"> {{ item.li_nm }}  </td>
								     </tr>    
								</tbody>
							</table>
							
							<div class="paging_area"  id="listlecDataMgtfirstPagination" v-html="pagenavi"> </div>
						</div>

                        <br>  
                        
                        
                        <p>
                         <span align="left" >
		                 <span>작성일</span> <input type="date" id="sdate"> ~ <input type = "date" id ="edate"> <a  class="btnType blue" id="btnSearchfile" name="btn"><span>검  색</span></a></span>
						 <span class="fr">          
							    <a	 class="btnType blue" href="javascript:fPopModalfile();" name="modal"><span>자료등록</span></a>
						 </span>
						</p>
						                       
                        
						<div id="divfileuploadListtwo">
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
								<tbody id="listlecDataMgt" v-for="(item , index) in listitem">
									<tr>
										<td @click="detailviewfile(item.le_title)">{{ item.le_title }}</td>
										<td>{{ item.le_date }}</td>
										<td>{{ item.le_nm }}</td>
									</tr>								
								</tbody>
							</table>
							<div class="paging_area"  id="comnfileuploadPagination" v-html="pagenavi"> </div>
						</div>
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
							<td><input type="text" class="inputTxt p100" name="title" id="title" v-model="title" /></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="cont" id="cont" v-model="cont" > </textarea>
						   </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn" v-show="delshow"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
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
							<td><input type="text" class="inputTxt p100" name="titlefile" id="titlefile"  v-model="titlefile"    /></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="contfile" id="contfile" v-model="contfile"  > </textarea>
						   </td>
						</tr>
						<tr>
						</tr>
						<tr>
							<th scope="row">파일 <span class="font_red">*</span></th>
							<td>
							     <input type="file" id="upfile" name="upfile"  @change="fpreview(event)" />
						   </td>
						</tr>
						<tr>
							<th scope="row">파일 다운로드<span class="font_red">*</span></th>
							<td>
							     <div id="filedownloaddiv" v-html="disdownload"> </div>
						   </td>
						</tr>						
						<tr>
							<th scope="row">파일 미리보기<span class="font_red">*</span></th>
							<td>
							     <div id="filepewviewdiv" v-html="dispreview"> </div>
						   </td>
						</tr>								
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSavefile" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeletefile" name="btn"  v-show="delshow"><span>삭제</span></a> 
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