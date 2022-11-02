 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${firstsearchlistcnt eq 0 }">
								<tr>
									<td colspan="2">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${firstsearchlistcnt  > 0 }">
								<c:forEach items="${firstsearchlist}" var="list">
								
									<tr> 
										<td><a href="javascript:fListclick('${list.li_no}')">${list.li_no}</a></td>
										<td><a href="javascript:fListclick('${list.li_no}')">${list.li_nm}</a></td>
									</tr>

								</c:forEach>
							</c:if>
							
							<input type="hidden" id="firstsearchlistcnt" name="firstsearchlistcnt" value ="${firstsearchlistcnt}"/>
							<input type="hidden" id="li_no" name="li_no" value ="${li_no}"/>
							<input type="hidden" id="loginID" name="loginID" value ="${loginID}"/>
							
		