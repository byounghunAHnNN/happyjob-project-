<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${searchlistcnt eq 0 }">
								<tr>
									<td colspan="3">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${searchlistcnt != null }">
							
								<c:forEach items="${searchlist}" var="list">								
									
									<tr>                        
										<td><a href="javascript:fselectonefile(${list.le_no})">${list.le_title}</a></td>
										<td>${list.le_date}</td>
										<td>${list.le_nm}</td>										
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="searchlistcnt" name="searchlistcnt" value ="${searchlistcnt}"/>
						
							<input type="hidden" id="loginID" name="loginID" value ="${searchlistcnt}"/>
						    <input type="hidden" id="le_nm" name="le_nm" value ="${searchlistcnt}"/>  	
							
