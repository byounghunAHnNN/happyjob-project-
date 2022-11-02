<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userType ne 'A'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- abc -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학습지원관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
    
    var pagesize = 3;
    var pagenumsize = 5;
	
	/** OnLoad event */ 
	$(function() {
	
		fListCounsel();

		fRegisterButtonClickEvent();

	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');
			
			switch (btnId) {
				case 'btnSearch' :
					fListCounsel();
					break;
				case 'btnSave' :
					$("#action").val("I");
					consultsave();
					break;		
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	//수강 상담 이력 리스트 가지고 오는 부분
	function fListCounsel(clickpagenum) {
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				searchvalue : $("#searchvalue").val(),
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
		
		var searchcallback = function(returndata) {
			
			console.log("returndata : " + returndata);
			
			searchcallbackprocess(returndata,clickpagenum);
			
		}
		
		callAjax("/admsst/listCounsel.do", "post", "text", true, param, searchcallback);
		
	}
	
	// 수강상담이력  과정명 클릭시 콜백 함수 과장명에 등록된 학생 명을 가져오기 위해 데려간 느낌.  tbody 아이디값 들어가는 넣을수 있는 부분. 
	function searchcallbackprocess(returndata,clickpagenum) {

		$("#listCounsel").empty().append(returndata); //초기화의 느낌인가? >> 네 비워주고 불러온걸 채워주는 겁니당.

		var totalcnt = $("#searchlistcnt").val();
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListCounsel');
		
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		
		$("#comnfileuploadPagination").empty().append( paginationHtml );
		$("#hclickpagenum").val(clickpagenum);  // hclickpagenum => 히든값.
	}
	
	//과정명을 눌렀을 시에 참여 학생목록으로 값 보내줄려고 할 때 넘버랑 리스트 조회 하려고 하는 부분
	function fListclick(no) {
		$("#li_no").val(no);
		
		$("#listCounselDtl2").empty();
		fListCounselDtl();
	}
	
	//참여학생목록(수강한 학생 목록) 리스트 
	function fListCounselDtl (clickpagenum) {
		
		clickpagenum = clickpagenum || 1;
		
		var param = {
				li_no : $("#li_no").val(),
				clickpagenum : clickpagenum,
				pagesize : pagesize				
		};
            
		console.log("수강한 학생 목록 파람값들 확인: "+ param);
		console.log(JSON.stringify(param));
		
		var searchcallback = function(returndata) {
			
			console.log("returndata : " + returndata);
			
			searchcallbackprocess2(returndata,clickpagenum);

			
		}
		
		callAjax("/admsst/listCounselDtl.do", "post", "text", true, param, searchcallback);
			
	}
	
	//참여학생목록
	function searchcallbackprocess2(returndata,clickpagenum) {
		
		console.log("searchcallbackprocess2 : " + returndata);	
	
		$("#listCounselDtl").empty().append(returndata);
		
		var totalcnt = $("#searchlistcnt2").val();
		
		var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListCounselDtl');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnfileuploadPagination2").empty().append( paginationHtml );
		
		$("#hclickpagenum").val(clickpagenum);
	}
	
		//수강 상담 이력 하나 클릭시에 참여 학생 목록 리스트 데이터 값을 가지고 올 수 있게 해주는 곳
	function Listconsulting(loginID, clickpagenum) {

		clickpagenum = clickpagenum || 1;
		$("#loginID").val(loginID);
		var param = {
				li_no : $("#li_no").val(),
				loginID : loginID ,
				clickpagenum : clickpagenum,
				pagesize : pagesize
		};
	
		var searchcallback2 = function(returndata) {
			
			console.log("returndata : " + returndata);
			
			searchcallbackprocess3(returndata,clickpagenum);
			hellllo();
	}
	
		callAjax("/admsst/listCounselDtl2.do", "post", "text", true, param, searchcallback2);
		
}
		//상담이력 목록조회 
		function searchcallbackprocess3(returndata,clickpagenum) {
			
			$("#listCounselDtl2").empty().append(returndata);
			
			var totalcnt = $("#searchlistcnt2").val();
			
			var paginationHtml = getPaginationHtml(clickpagenum, totalcnt, pagesize, pagenumsize, 'fListCounselDtl2');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#comnfileuploadPagination3").empty().append( paginationHtml );
			
			$("#hclickpagenum").val(clickpagenum);
			
			
		}
		function hellllo(){
			if($("#hidenetaigutdela").val() == 0){
				$("#btnregister").css("display", "block");
			}else{
				$("#btnregister").css("display", "none");
			}
		}

		function fPopModal(loginID) {	
			
			if(loginID == null){
				$("#kaksangID").val($("#loginID").val());
				$("#kuamockMiang").val($("#li_no").val());
				$("#cont").val('');
				$("#kaksangID").attr("disabled", true);
				$("#kuamockMiang").attr("disabled", true);
				$("#cont").attr("disabled", false);
				$("#btnSave").show();
				gfModalPop("#layer1");	
			}else{
				fn_forminit(loginID);
			}
			

		}  
		
		function fn_forminit(loginID){
			var param = {
					li_no : $("#li_no").val(),
					loginID : loginID
			};
		
			var searchcallback3 = function(returndata) {
				console.log(JSON.stringify(returndata));
				hello(returndata.listCounselDtl3);
				gfModalPop("#layer1");		
		}
		
			callAjax("/admsst/listCounselDtl3.do", "post", "json", true, param, searchcallback3);
			
		}
		
		function hello(returndata){

			$("#kaksangID").val(returndata[0].loginID);
			$("#kuamockMiang").val(returndata[0].li_no);
			$("#cont").val(returndata[0].cs_ct);
			$("#cont").attr("disabled", true);
			$("#kaksangID").attr("disabled", true);
			$("#kuamockMiang").attr("disabled", true);
			$("#btnSave").hide();
		}
		

			//callAjax("/admsst/selectConsult.do", "post", "json", true, param, selectonecallback);
	
		//등록버튼시 보
		function consultsave() {
			
			console.log("consultsave : " + $("#loginID").val());
			
			var param = {
					li_no : $("#kuamockMiang").val(),
					loginID : $("#kaksangID").val(),
					cs_ct : $("#cont").val(),
					action : $("#action").val()
			};
			
			var savecallback= function(rtn) {

				alert("저장 되었습니다.");
				
				gfCloseModal();
				
				Listconsulting($("#loginID").val());
				
			}
		
			callAjax("/admsst/saveConsult.do", "post", "json", true, param, savecallback);
		}


		

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="hclickpagenum" name="hclickpagenum"  value="" />
	<input type="hidden" id="action" name="action"  value="" />
	<input type="hidden" id="li_no" name="li_no"  value="" />
	<input type="hidden" id="loginID" name="loginID" value =""/>
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
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">수강상담이력</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>수강상담이력</span> <span class="fr"> 
							</span>
						</p>
						<table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                        
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">

								     <span>과정명</span>

	     	                       <input type="text" style="width: 700px; height: 25px;" id="searchvalue" name="searchvalue">                    
		                           <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
	                           </td> 
	                           
	                        </tr>
                        </table> 
						<div class="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">과정명</th>
										<th scope="col">기간</th>

									</tr>
								</thead>
								<tbody id="listCounsel"></tbody> 
							</table>
						</div>
	
						<div class="paging_area"  id="comnfileuploadPagination"> </div>
						
						<div class="content">
						<p class="conTitle mt50">
							<span>참여학생목록</span> <span class="fr"> 
							</span>
						</p>
						<table style="margin-top: 10px" width="50%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                        
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	                           </td> 
	                        </tr>
                        </table> 
						<div class="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생명</th>
										<th scope="col">시험최종점수</th>

									</tr>
								</thead>
								<tbody id="listCounselDtl"></tbody> 
								
							</table>
						</div>
	
						<div class="paging_area"  id="comnfileuploadPagination2"> </div>
						
							<div class="content">
						<p class="conTitle mt50">
							<span>상담이력 목록 조회</span> <span class="fr"> 
							<a href="javascript:fPopModal();" class="btnType blue" id="btnregister" name="modal" style="display: none;"> <span>등 록</span> </a>
							</span>
						</p>
				
						<table style="margin-top: 10px" width="50%" cellpadding="5" cellspacing="0" border="1"  align="left"   style="collapse; border: 1px #50bcdf;">
	                        <tr style="border: 0px; border-color: blue">
	                        
	                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
	                           </td> 
	                        </tr>
                        </table> 
						<div class="divfileuploadList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="30%">
									<col width="30%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">상담일자</th>
										<th scope="col">상담장소</th>
										<th scope="col">상담자</th>
									</tr>
								</thead>
								<tbody id="listCounselDtl2"></tbody> 
							</table>
						</div>
	
						<div class="paging_area"  id="comnfileuploadPagination3"> </div>
						
						
						
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
							<th scope="row">학생ID <span class="font_red">*</span></th>
							<td><input type="text" id= "kaksangID"></td>
							<th scope="row">과목명 <span class="font_red">*</span></th>
							<td><input type="text" id= "kuamockMiang" ></td>
						</tr>
						<tr>
							<th scope="row">내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea class="inputTxt p300"	name="cont" id="cont" style="resize:none;"> </textarea>
						   </td>
						</tr>

					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>  
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</form>
</body>
</html>