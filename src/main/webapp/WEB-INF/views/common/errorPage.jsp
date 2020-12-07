<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>G R O O B E E</title>
<link rel="stylesheet" href="resources/css/common.css">
<style>
	#errorInfo{ margin:0; padding:0; text-align: center; margin-top: 200px; color: gray; font-size: 30px;}
</style>
</head>
<body>
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
    <div id="header">
    	<a href="${ contextPath }/index.jsp"><img src="resources/icons/logo.png" alt="logo" id="logo" name="logo"></a>
    </div>
	<p id="errorInfo">
		안내:<c:out value="${ msg }"/><br>
	</p>
</body>
</html>