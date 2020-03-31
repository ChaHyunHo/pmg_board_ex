<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	$(function() {
		$("#logoutBtn").on("click",function() {
			$("#logout-form").submit();
		})
	})


</script>
<sec:authentication var="principal" property="principal" />
<sec:authorize access="isAuthenticated()">
	<div class="row">
		<div style="margin-left: 10px;">
	    <span class="badge badge-right rounded-0" style="font-weight: 900; margin-left: 5px; font-size: 20px;">
		<c:out value="${sessionName}"></c:out>님 반갑습니다</span>
		</div>
		<div style="margin-left: 20px;">
			<form id="logout-form" action="/logoutform" method='post'>
			<a id="logoutBtn" href="javascript:void(0);">
			<span class="badge badge-danger" style="font-size: 15px;">로그아웃</span></a> 
		</form>
		</div>
	</div>
	
</sec:authorize>
<sec:authorize access="isAnonymous()">
	
<!-- 	<a id="loginBtn" href="javascript:void(0);" style="font-weight: 900; margin-left: 5px; font-size: 18px;" ><span class="badge badge-danger">로그인</span></a> --> 
</sec:authorize>


