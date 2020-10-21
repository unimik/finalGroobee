<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GROOBEE</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/login.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<div class="wapper">
        <div class="content">
            <img src="<%=request.getContextPath()%>/resources/icons/logo.png" alt="index_logo" id="index_logo" name="index_logo">
            <div id="login_Box">
                <div id="inputArea">
                <form action="login.do" method="post">
                    <label id="id">아 이 디</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="userId" name="userId"><br>
                    <label id="pwd">비밀번호</label> &nbsp;&nbsp;<input type="password" id="userPwd" name="userPwd"><br>
                    <input type="submit" id="loginBtn" name="loginBtn" value="로그인"> 
                </form>
                </div>
                <a href="goMemberFindForm.do" id="find_Id_Pwd">아이디나 비밀번호를 잊어버리셨나요? &nbsp;&nbsp;<b>아이디/비밀번호 찾기</b></a><br><br>
                <a href="goMemberJoinForm.do" id="create_Id">아직 회원이 아니신가요? &nbsp;&nbsp;<b>계정만들기</b></a>
            </div>
        </div>
        <div id="copy">
            <p>GROOBEE © 2020</p>
        </div>
    </div>
    <script>
    /* 유효성 검사 */
    $(function(){
    	$("#loginBtn").on("click",function(){
		    var vUserId = $("#userId").val();
	   		var regex = /^[a-z\d]{4,11}$/;
	       	var resultId = regex.exec(vUserId);
	        if(resultId == null) {
	        	alert("올바른 문자열을 입력해주세요");
	        	return false;
	        }
		    var vPwd = $("#userPwd").val();
			var regex = /^[a-z\d]{4,11}$/;
		  	var resultPwd = regex.exec(vPwd);
		    if(resultPwd == null) {
		    	alert("올바른 문자열을 입력해주세요");
		    	return false;
		    }
    	});
    });
    </script>
</body>
</html>