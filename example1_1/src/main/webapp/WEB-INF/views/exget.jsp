<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header2.jsp" %>
<body>
<h1>
	example test
</h1>
<p>csrf 공통 테스트 입니다.</p>
<button type="button" id="testBtn" >테스트 버튼</button>

<script src="/resources/js/ajaxJsonCommon.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">

	$("#testBtn").click(function() {
		ajaxJsonCommon("/main/ex" ,$("#getForm"), function() {
			alert("성공");
		});
	});

</script>

<form id="getForm">
	<input type="hidden" name="title"    id="title"    value="aaaa@naver.com" />
    <input type="hidden" name="writer"   id="wrtier"   value="aaaaa" />
    <input type="hidden" name="content"  id="content"  value="dddd" />
</form>
</body>
</html>
