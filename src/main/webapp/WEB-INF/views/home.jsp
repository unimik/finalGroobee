<%@page import="com.kh.spring.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% Member m = (Member)session.getAttribute("loginUser"); %>
<html>
<head>
	<title>Home</title>
	<link rel="stylesheet" href="resources/css/home.css">
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<c:import url="common/menubar.jsp"/>
</body>
</html>
