<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>G R O O B E E</title>
<style>
	#errorInfo{ margin:0; padding:0;  }
</style>
</head>
<body>
	<c:import url="common/menubar.jsp" />
	<p id="errorInfo">
		안내:<c:out value="${ msg }"/><br>
	</p>
</body>
</html>