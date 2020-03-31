<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<body>

<h1>Access Denied Page</h1>
	
	<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"></c:out> </h2>
	
	<h2><c:out value="${msg}"></c:out> </h2>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 	

<script>
	var msg2 = "<c:out value='${msg}'/>"
	
</script>

</body>
</html>