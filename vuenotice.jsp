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
    
    var pagesize = 10;
    var pagenumsize = 5;
    var listnoticevue;
    var sraecharea;
    var nofilepopup;
    
    
	/** OnLoad event */ 
	$(function() {
		
		comcombo("GRADE", "samplecom", "all", "");
		
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
		
		listnoticevue = new Vue({
		                                      el : "#divfileuploadList",
			                               data : {
			                            	           listitem : [],
		                                               pagenavi : ""
			                               },
			                               methods : {
			                            	   detailview : function(no) {
			                            		        //alert(no);
			                            		        fn_selectone(no);	
			                            	   }
			                               }
		})
		
		sraecharea = new Vue({
		                                    el : "#sraecharea",
		                                  data : {
		                                	   searchKey : "",
		                                	 searchvalue : ''
		                                 }     
			
		})
		
		nofilepopup = new Vue({
			                                 el : "#layer1",
			                               data : {
			                            	          title : "",
			                            	          cont : "",
			                            	          action : "",
			                            	          no : 0,
			                            	          delshow : false
			                              }        
		})
		
		
		
		
		
		
	}
	
	function listsearch(pagenum) {
		
		pagenum = pagenum || 1;
		
		console.log("sraecharea.searchKey : " + sraecharea.searchKey + " sraecharea.searchvalue : " + sraecharea.searchvalue);

		var param = {
				pagenum : pagenum,
				pagesize : pagesize,
				searchtype : sraecharea.searchKey,
				searchvalue : sraecharea.searchvalue
		}
		
		var listcallback = function(returndata) {
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			listnoticevue.listitem = returndata.searchlist;
			
			var paginationHtml = getPaginationHtml(pagenum, returndata.searchlistcnt, pagesize, pagenumsize, 'listsearch');
			console.log("paginationHtml : " + paginationHtml);
			
			listnoticevue.pagenavi = paginationHtml;
			
		}
		
		callAjax("/admsst/listFileuploadvue.do", "post", "json", true, param, listcallback);
	}
	
	function fPopModal() {
		
		fn_forminit();
		gfModalPop("#layer1");
		
	}
	
	
	function fn_forminit(data) {
		
		if (data == null || data=="") {
			nofilepopup.title = "";
			nofilepopup.cont = "";
			nofilepopup.no = ""
			nofilepopup.action = "I";
			
			nofilepopup.delshow = false;
		} else {
			nofilepopup.title = data.bd_title;
			nofilepopup.cont = data.bd_contents;
			nofilepopup.no = data.bd_no;
			nofilepopup.action = "U";			
			
			nofilepopup.delshow = true;
		}	
		
		
	} 
	
	function fsavefileupload() {
		
		var param = {
				title : nofilepopup.title ,
				cont : nofilepopup.cont,
				action : nofilepopup.action,
				bd_no : nofilepopup.no
				
		}
		
		var listcallback = function(returndata) {
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			if(returndata.result == "SUCESS") {
				alert("저장 되었습니다.");
				
				gfCloseModal();
			}
			
			listsearch();
		}
		
		callAjax("/admsst/saveFileupload.do", "post", "json", true, param, listcallback);
		
	}
	
	function fn_selectone(no) {
		
		var param = {
				bd_no : no				
		}
		
		var selectoncallback = function(returndata) {
			console.log(  "listcallback " + JSON.stringify(returndata) );
			
			fn_forminit(returndata.searchone);
			
			gfModalPop("#layer1");
		}
		
		callAjax("/admsst/selectFileupload.do", "post", "json", true, param, selectoncallback);
		
	} 
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="bd_no" name="bd_no"  value="" />
	
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
							    <a	 class="btnType blue" href="javascript:fPopModal();" name="modal"><span>신규등록</span></a>
							    <a	 class="btnType blue" href="javascript:fPopModalfile();" name="modal"><span>신규등록(파일)</span></a>
							</span>
						</p>
						
						<div id="sraecharea">
							<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
		                        <tr style="border: 0px; border-color: blue">
		                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
		                                  <select id="samplecom"  style="width: 150px;" >
										</select> 
										
			     	                      <select id="searchtype" name="searchtype" style="width: 150px;" v-model="searchKey">
			     	                            <option value="" >전체</option>
												<option value="seq" >순번</option>
												<option value="title" >제목</option>
												<option value="writer" >작성자</option>
										</select> 
									
		     	                       <input type="text" style="width: 300px; height: 25px;" id="searchvalue" name="searchvalue"  v-model="searchvalue">                    
			                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
		                           </td> 
		                           
		                        </tr>
	                        </table> 
                        </div>
                        
                        
						<div id="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="25%">
									<col width="25%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">작성일</th>
									</tr>
								</thead>
								<tbody id="listfileupload" v-for=" (item, index) in listitem" >
								     <tr>
								         <td> {{ item.bd_no }}  </td>
								         <td @click="detailview(item.bd_no)"> {{ item.bd_title }}  </td>
								         <td> {{ item.loginID }}  </td>
								         <td> {{ item.bd_date }}  </td>
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
							<td><input type="text" class="inputTxt p100" name="titlefile" id="titlefile" /></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td>
							     <textarea class="inputTxt p100"	name="contfile" id="contfile" > </textarea>
						   </td>
						</tr>
						<tr>
							<th scope="row">파일 <span class="font_red">*</span></th>
							<td>
							     <input type="file" id="upfile" name="upfile"  onChange="fpreview(event)" />
						   </td>
						</tr>
						<tr>
							<th scope="row">파일 다운로드<span class="font_red">*</span></th>
							<td>
							     <div id="filedownloaddiv"> </div>
						   </td>
						</tr>						
						<tr>
							<th scope="row">파일 미리보기<span class="font_red">*</span></th>
							<td>
							     <div id="filepewviewdiv"> </div>
						   </td>
						</tr>								
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