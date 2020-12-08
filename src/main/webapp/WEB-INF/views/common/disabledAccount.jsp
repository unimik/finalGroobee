<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>G R O O B E E</title>
<link rel="stylesheet" href="resources/css/common.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
	#errorInfo{ margin:0; padding:0; text-align: center; margin-top: 200px; color: gray; font-size: 30px;}
	#activeBtn{ color: gray;background: #daf4ed;border: none;border-radius: 5px;width: 120px;height: 20px;margin-left: 10px;}
</style>
</head>
<body>
	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>
    <div id="header">
    	<a href="${ contextPath }/index.jsp"><img src="resources/icons/logo.png" alt="logo" id="logo" name="logo"></a>
    </div>
	<p id="errorInfo">
		비활성화 된 계정입니다.
	</p>
	<span style="display:block; text-align:center; margin-top:50px">비밀번호를 입력하시면 비활성화가 해제됩니다.</span><br>
	<div style="display:block; text-align:center;" >
		<input id="password"type="text" style="align:center;"><input id="activeBtn" type="button" value="비활성화 해제">
	</div>
	<input id="userNo"type="hidden" value="${loginUser.mNo }">
</body>
<script>
	$("#activeBtn").on('click',function(){
		var userNo = $("#userNo").val();
		var password = $("#password").val();
		console.log(userNo+password)
		$.ajax({
			url:'activeAccount.do',
			data:{userNo: userNo,
				password:password},
			success:function(){
				location.href = "loginView.do"
			}
		});
	});
</script>
</html>