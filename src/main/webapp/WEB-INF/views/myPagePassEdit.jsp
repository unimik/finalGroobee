<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myPage_PassEdit.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/myAccount.css">
</head>
<body>
	 <div class="wrapper">
        <div id="header">
            <img src="<%=request.getContextPath()%>/resources/icons/logo.png" alt="logo" id="logo" name="logo">
        </div>
        <div class="content">
            <div class="search_userInfo">
                <div id="searchbar">
                    <input type="search" id="allSearch" name="allSearch">
                    <input type="button" id="allSearchBtn" name="allSearchBtn" value="검색">
                </div>
                <div id="userInfo">
                    <ul>
                        <li><a href="../views/myPage_Main.html"><img src="../resources/images/IMG_7502.JPG" alt="" id="profile_img">&nbsp;&nbsp;&nbsp;<p>user01</p></a></li>
                        <li><img src="<%=request.getContextPath()%>/resources/icons/write.png" alt="" id="writeIcon"></li>
                        <li><img src="<%=request.getContextPath()%>/resources/icons/alarm.png" alt="" id="alarmIcon"></li>
                        <li><img src="<%=request.getContextPath()%>/resources/icons/open.png" alt="" id="detailInfo"></li>
                    </ul>
                </div>
                <div class="myAccount">
                    <div id="myId">
                        <a href="../views/myPage_Main.html">
                        <img src="<%=request.getContextPath()%>/resources/images/IMG_7502.JPG" alt="myProfile" id="myProfile">
                        <p>user01</p>
                        </a>
                    </div>
                    <div id="MyTab">
                        <button class="MyTab_tab1 MyTab_tab on">친구</button>
                        <button class="MyTab_tab2 MyTab_tab">그룹</button>
                        <div id="MyTab_container">
                            <div class="MyTab_box1 MyTab_box on">
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="<%=request.getContextPath()%>/resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>user02</li>
                                        <li><button id="following" name="following">팔로잉</button></li>
                                    </ul>
                                </div>
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="../resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>user03</li>
                                        <li><button id="following" name="following">팔로잉</button></li>
                                    </ul>
                                </div>
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="../resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>user04</li>
                                        <li><button id="following" name="following">팔로잉</button></li>
                                    </ul>
                                </div>
                                <div id="My_f_list">
                                    <ul id="f_info">
                                        <li><img src="../resources/images/IMG_7273.JPEG" alt="" id="f_list_img"></li>
                                        <li>user05</li>
                                        <li><button id="follow" name="follow">팔로우</button></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="MyTab_box2 MyTab_box">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
    <!-- 비밀번호 변경 부분 -->
        <div id="editArea">
            <div id="edit">
                <div id="edit_head">
                    <h2>비밀번호 변경</h2>
                </div>
                
                <div id="edit_body">
                    <div id="myProfileImg">
                        <img src="<%=request.getContextPath()%>/resources/images/mp_profile_sample.jpg">
                        <div class="myImg">
                            <p>USER01</p>
                        </div>
                    </div>
                    <div id="pass_edit">
                        <div class="pwd1">
                            <p>현재 비밀번호</p>
                            <input type="password" id="current_pass" name="current_pass" maxlength="20">
                        </div>
                        <div class="pwd2">
                            <p>새로운 비밀번호</p>
                            <input type="password" id="new_pass" name="new_pass" maxlength="20">
                        </div>
                        <div class="pwd3">
                            <p>비밀번호 확인</p>
                            <input type="password" id="check_pass" name="check_pass" maxlength="20">
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
            </div>
        </div>
    <script>
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