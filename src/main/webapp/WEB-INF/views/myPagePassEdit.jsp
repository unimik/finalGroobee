<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myPage_PassEdit.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myAccount.css">
    <style>
    	#editArea{ margin-left:100px; width:640px; }
		#edit_head>h2{ margin-top:30px; }
		#edit{ width:640px; }
		.myImg>p{ font-size:xx-large; line-height: 20pt; margin-top:50px; }
    </style>
</head>
<body>
	 <c:import url="common/menubar.jsp"/>
            
    <!-- 비밀번호 변경 부분 -->
        <div id="editArea">
            <div id="edit">
              	<form action="mPwdUpdate.do" method="post" id="updateForm">
                <div id="edit_head">
                    <h2>비밀번호 변경</h2>
                </div>
                <input type="hidden" name="mNo" value="${ loginUser.mNo }">
                
                <div id="edit_body">
                    <div id="myProfileImg">
                    	 	<c:if test="${ !empty loginUser.mRenameImage }">
                           		<img src="<%=request.getContextPath()%>/resources/memberProfileFiles/${ loginUser.mRenameImage }" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                            </c:if>
                            <c:if test="${ empty loginUser.mRenameImage }">
                            	<img src="resources/icons/pro_default.png" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;
                            </c:if>
                        <div class="myImg">
                            <p>${ loginUser.userId }</p>
                        </div>
                    </div>
                    <div id="pass_edit">
                        <div class="pwd1">
                            <p>현재 비밀번호</p>
                            <input type="hidden"   id="userPwd" name="userPwdeny" value="${loginUser.userPwd }">
                            <input type="password" id="current_pass" name="userPwd" maxlength="11">
                        </div>
                        <div class="pwd2">
                            <p>새로운 비밀번호</p>
                            <input type="password" id="new_pass" name="userPwd1" maxlength="11" onkeyup="passwordCheckFunction();" placeholder="  4자리 이상 입력">
                        </div>
                        <div class="pwd3">
                            <p>비밀번호 확인</p>
                            <input type="password" id="check_pass" name="userPwd2" maxlength="11" onkeyup="passwordCheckFunction();">
                            <span id="pwdCheckResult"> </span>
                        </div>
                    </div>
                </div>
            <!-- 버튼 만들기 -->
                <div id="edit_body2">
                    <div id="editBtnArea">
                        <input type="submit" id="edit_submitBtn" class="completeBtn" value="변경하기">
                        <input type="button" id="edit_cancleBtn" class="completeBtn" value="취소" onclick="goBack()">
                    </div>
                </div>
                </form>
            </div>
        </div>
    <script>
    $('#edit_submitBtn').click(function(){
    		var pwd1 = $("#new_pass").val();
    		var pwd2 = $("#check_pass").val();
    		if(pwd1 == null || pwd1 == "" || pwd2 == null || pwd2 == "") {
    			alert("비밀번호를 입력해주세요");
    			return false;
    		} else if(pwd1 != pwd2) {
    			alert("비밀번호를 동일하게 입력해주세요");
    			return false;
    		} 
    		var vPwd = $("#new_pass").val();
    		var regex = /^[a-z\d]{4,11}$/;
          	var resultPwd = regex.exec(vPwd);
            if(resultPwd == null) {
            	alert("영어 소문자 및 숫자로 4자리 이상 11자리 이하로 입력해주세요");
            	return false;
            }
    	});
    
        $(document).ready(function(){
            $('#chat_icon').click(function(){
                var state = $(".chat").css('display');
                if(state=='none'){
                    $('.chat').show();
                }else{
                    $('.chat').hide();
                }
            });
        });

       $('.tab_menu_btn').on('click',function(){
            $('.tab_menu_btn').removeClass('on');
            $(this).addClass('on')
        });

        $('.tab_menu_btn1').on('click',function(){
            $('.tab_box').hide();
            $('.tab_box1').show();
        });

        $('.tab_menu_btn2').on('click',function(){
            $('.tab_box').hide();
            $('.tab_box2').show();
        });

        $(document).ready(function(){
            $('#detailInfo').click(function(){
                $(".myAccount").animate({width:"toggle"},250);
            });
        });

        $('.MyTab_tab').on("click",function(){
            $('.MyTab_tab').removeClass('on');
            $(this).addClass('on')
        });

        $('.MyTab_tab1').on('click', function(){
            $('.MyTab_box').hide();
            $('.MyTab_box1').show();
        });

        $('.MyTab_tab2').on('click', function(){
            $('.MyTab_box').hide();
            $('.MyTab_box2').show();
        });

        /* 게시글, 보관함, 내 그룹 전환 시 스크립트 */
        $('.feedPost_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
        });

        $('.feedStorageBox_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedMyGroup_btn').css({'border-bottom' : '2px solid #daf4ed'});
        });

        $('.feedMyGroup_btn').click(function() {
            $(this).css({'border-bottom' : '2px solid #47c6a3'});
            $('.feedPost_btn').css({'border-bottom' : '2px solid #daf4ed'});
            $('.feedStorageBox_btn').css({'border-bottom' : '2px solid #daf4ed'});
        });

        $('div[type = button]').css({'cursor' : 'pointer'});
        $('input[type = button]').css({'cursor' : 'pointer'});
        $('input[type = submit]').css({'cursor' : 'pointer'});
        $('img[type = button]').css({'cursor' : 'pointer'});

        function goBack() {
            window.history.back();
        }

    </script>
</body>
</html>